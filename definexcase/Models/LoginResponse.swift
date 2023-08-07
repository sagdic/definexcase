//
//  LoginResponse.swift
//  definexcase
//
//  Created by Tayfun Sagdic on 5.08.2023.
//

import Foundation

struct LoginResponse: APIResponse {
    var isSuccess: Bool
    var message: String?
    let token: String

    enum CodingKeys: String, CodingKey {
        case isSuccess
        case message
        case token
    }
}


//{
//  "isSuccess": true,
//  "message": "Transaction Succesfull",
//  "statusCode": 200,
//  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5b"
//}
