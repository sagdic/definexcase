//
//  APIError.swift
//  definexcase
//
//  Created by Digiturk on 22.01.2023.
//

import Foundation


enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
    case customError(message: String)
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to decode the object from the service"
        case .errorCode(let code):
            return "\(code) - Something went wrong"
        case .unknown:
            return "The error is unknown"
        case .customError(let message):
            return message
        }
    }
}
