//
//  network.swift
//  App Demo Qnips
//
//  Created by Timo Kurtz on 11.04.23.
//


struct Network: Codable {
    
    let Allergens: [String: AllergensLabel]
    let Products: [String: Product]
    let Rows: [Row]
}

struct Product: Codable, Hashable {
    let AllergenIds: [String]
    let ProductId: Int
    let Name: String
    let Price: [String: Float]
}

struct AllergensLabel: Codable {
    let Id: String
    let Label: String
    
}

struct Row: Codable, Hashable {
    static func == (lhs: Row, rhs: Row) -> Bool {
        true
    }
    
    let Name: String
    let Days: [Day]
}

struct Day: Codable, Hashable {
    static func == (lhs: Day, rhs: Day) -> Bool {
        true
    }
    
    let Weekday: Int
    let ProductIds: [ProductId]
}

struct ProductId: Codable, Hashable {
    let ProductId: Int
}

