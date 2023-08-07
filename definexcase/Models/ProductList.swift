//
//  List.swift
//  definexcase
//
//  Created by Digiturk on 22.01.2023.
//

import Foundation

// MARK: - ListResponse
struct ListResponse: APIResponse {
    var message: String?
    let isSuccess: Bool
    let list: [ProductList]
}

// MARK: - ProductList
struct ProductList: Codable, Identifiable {
    let id = UUID()
    let imageURL: String?
    let description: String
    let price, oldPrice: Price?
    let discount: String?
    let ratePercentage: Int?

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case description, price
        case oldPrice = "oldPrice"
        case discount
        case ratePercentage = "ratePercentage"
    }
}

// MARK: - Price
struct Price: Codable {
    let value: Double?
    let currency: String?
}

extension ProductList {
    static var dummyData: ProductList {
        .init(imageURL: "https://teamdefinex-mobile-casestudy.vercel.app/images/image1.jpeg", description: "Little Black Book For Perfect Reading", price: Price(value: 39.00, currency: "$"), oldPrice: Price(value: 39.99, currency: "$"), discount: "48% OFF", ratePercentage: nil)
    }
}
