//
//  MyCartModel.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 30.08.2022.
//

import Foundation

struct MyCartModel: Decodable {
    let basket: [DetailsForCart]
    let delivery: String
    let id: String
    let total: Int
}

struct DetailsForCart: Decodable {
    
    let id: Int
    let images: String
    let price: Int
    let title: String
}
