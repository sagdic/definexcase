//
//  LoginViewModel.swift
//  definexcase
//
//  Created by Digiturk on 21.01.2023.
//

import Foundation
import Combine
import SwiftUI

enum LoginResult {
    case success
    case failure(error: APIError)
}

protocol LoginViewModel: ObservableObject {
    var state: ResultState<LoginResult> { get }
    var credentials: Credentials { get set }
    func performLogin()
}

class LoginViewModelImpl: ObservableObject, LoginViewModel {
    
    private let service: DefinexService
    
    @Published var isLogged = false
    @Published private(set) var state: ResultState<LoginResult> = .loading
    @Published var credentials = Credentials()
    
    init(service: DefinexService) {
        self.service = service
    }
    
    func performLogin() {
        
        let parameters: [String: String] = [
            "email": "\(credentials.email)",
            "password": "\(credentials.password)"
        ]
        
        service.request(from: .login, method: .post, bodyParameters: parameters, headers: nil)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            }, receiveValue: { (loginResponse: LoginResponse) in
                if loginResponse.isSuccess {
                    if KeychainHelper.saveToken(loginResponse.token) {
                        self.state = .success(content: .success)
                        self.isLogged = true
                    } else {
                        self.state = .success(content: .failure(error: APIError.unknown))
                    }
                } else {
                    self.state = .success(content: .failure(error: APIError.unknown))
                }
            })
            .store(in: &cancellables)
    }
    
    private var cancellables = Set<AnyCancellable>()
}
