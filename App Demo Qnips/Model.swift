//
//  Modal.swift
//  App Demo Qnips
//
//  Created by Timo Kurtz on 11.04.23.
//

import Foundation

struct SideView: Codable {
    let weekDay: Int
    let categories: [Category]
    let products: [String: Product]
    let allergens: [String: AllergensLabel]
}

struct Category: Codable, Hashable {
    let name: String
    let ProductIds: [Int]
}
