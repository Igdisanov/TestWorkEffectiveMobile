//
//  Product.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 24.08.2022.
//

import Foundation

struct Product: Decodable {
    let id: Int?
    let title: String?
    let subtitle: String?
    let picture: String?
    let isBuy: Bool?
    let isNew: Bool?
    let isFavorites: Bool?
    let discountPrice: Int?
    let priceWithout_discount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, title, subtitle, picture
        case isBuy = "is_buy"
        case isNew = "is_new"
        case isFavorites = "is_favorites"
        case discountPrice = "discount_price"
        case priceWithout_discount = "price_without_discount"
    }
    
}


struct Shope: Decodable {
    let homeStore: [Product]?
    let bestSeller: [Product]?
    
    enum CodingKeys: String, CodingKey {
        case homeStore = "home_store"
        case bestSeller = "best_seller"
    }
}
