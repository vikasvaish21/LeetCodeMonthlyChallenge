//
//  Model.swift
//  nykaaProject
//
//  Created by Vikas Vaish on 04/10/22.
//

import Foundation

struct Welcome: Codable {
    let products: [Product]
}

// MARK: - Product
struct Product: Codable {
    let name: String?
    let price, rating: Double?
}

