//
//  DefinexService.swift
//  definexcase
//
//  Created by Digiturk on 22.01.2023.
//

import Foundation
import Combine

protocol APIResponse: Codable {
    var isSuccess: Bool { get }
    var message: String? { get }
}

protocol DefinexService {
    func request<T: APIResponse>(from endpoint: DefinexAPI, method: HTTPMethod, bodyParameters: [String: String]?, headers: [String: String]?) -> AnyPublisher<T, APIError>
}

struct DefinexServiceImpl: DefinexService {
    func request<T: APIResponse>(from endpoint: DefinexAPI, method: HTTPMethod, bodyParameters: [String: String]?, headers: [String: String]?) -> AnyPublisher<T, APIError> {
        var urlRequest = endpoint.urlRequest
            
                if let headers = headers {
                    for (key, value) in headers {
                        urlRequest.addValue(value, forHTTPHeaderField: key)
                    }
                }
                
                if method == .post, let bodyParameters = bodyParameters {
                    var request = urlRequest
                    request.httpMethod = method.rawValue
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    do {
                        request.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters, options: [])
                    } catch {
                        return Fail(error: APIError.unknown).eraseToAnyPublisher()
                    }
                    
                    urlRequest = request
                }
        
        return URLSession
            .shared
            .dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.unknown }
            .flatMap { data, response -> AnyPublisher<T, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                if (200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    return Just(data)
                        .decode(type: T.self, decoder: jsonDecoder)
                        .mapError { _ in APIError.decodingError }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .mapError{
                error in
                APIError.customError(message: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}
