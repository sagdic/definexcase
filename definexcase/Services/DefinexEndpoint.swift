//
//  DefinexEndpoint.swift
//  definexcase
//
//  Created by Digiturk on 22.01.2023.
//

import Foundation

protocol APIBuilder {
    
    var baseUrl: URL { get }
    var path: String { get }
    var urlRequest: URLRequest { get }
}

enum DefinexAPI {
    case login
    case getFirstList
    case getSecondList
    case getThirdList
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

extension DefinexAPI: APIBuilder {
    
    var baseUrl: URL {
        guard let url = URL(string: "https://teamdefinex-mobile-auth-casestudy.vercel.app") else {
            fatalError("Default URL is invalid")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .login:
            return "/login"
        case .getFirstList:
            return "/discoverFirstHorizontalList"
        case .getSecondList:
            return "/discoverSecondHorizontalList"
        case .getThirdList:
            return "/discoverThirthTwoColumnList"
        }
    }
    
    var urlRequest: URLRequest {
        return URLRequest(url: self.baseUrl.appendingPathComponent(self.path))
    }
}
