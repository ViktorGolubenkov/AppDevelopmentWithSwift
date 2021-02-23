//
//  IntermediaryModels.swift
//  RestaurantOrder
//
//  Created by Viktor Golubenkov on 31.10.2020.
//

import Foundation

struct Categories: Codable {
    
    let categories: [String]
    
}

struct PreparationTime: Codable {
    
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
