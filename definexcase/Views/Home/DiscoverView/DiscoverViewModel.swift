//
//  DiscoverViewViewModel.swift
//  definexcase
//
//  Created by Digiturk on 22.01.2023.
//

import Foundation
import Combine


enum ListType {
    case first
    case second
    case third
}

protocol DiscoverViewModel: ObservableObject{
    func getFirstList()
    func getSecondList()
    func getThirdList()
}

class DiscoverViewModelImpl: ObservableObject, DiscoverViewModel {
    
    private let service: DefinexService
    private var cancellables = Set<AnyCancellable>()
    @Published var isRefreshing: Bool = false
    
    @Published private(set) var state: ResultState<[ProductList]> = .loading
    
    init(service: DefinexService) {
        self.service = service
    }
    
    internal var lists: [ListType: [ProductList]] = [:]
    
    private var cache: [ListType: [ProductList]] = [:]
        
    
    func getList(endpoint: DefinexAPI, listType: ListType) {
        if let cachedList = cache[listType] {
                    self.lists[listType] = cachedList
                    self.state = .success(content: cachedList)
                    self.isRefreshing = false
                    return
                }
        
        guard let token = KeychainHelper.loadToken() else {
                self.state = .failed(error: APIError.customError(message: "Token not found."))
                return
            }
        
        let headers: [String: String] = [
            "Content-Type": "application/json",
            "token": "\(token)"
        ]
        
            service.request(from: endpoint, method: .get, bodyParameters: nil, headers: headers)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            }, receiveValue: { (listResponse: ListResponse) in
                self.cache[listType] = listResponse.list
                self.lists[listType] = listResponse.list
                self.state = .success(content: listResponse.list)
                self.isRefreshing = false
            })
            .store(in: &cancellables)
    }
    
    func getFirstList() {
        getList(endpoint: .getFirstList,listType: .first)
    }

    func getSecondList() {
        getList(endpoint: .getSecondList,listType: .second)
    }
    
    func getThirdList() {
        getList(endpoint: .getThirdList,listType: .third)
    }
    
    func refresh() {
        self.isRefreshing = true
        getFirstList()
        getSecondList()
        getThirdList()
    }
    
    
}
