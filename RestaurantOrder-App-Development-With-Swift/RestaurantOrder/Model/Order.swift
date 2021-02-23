//
//  Order.swift
//  RestaurantOrder
//
//  Created by Viktor Golubenkov on 31.10.2020.
//

import Foundation

struct Order: Codable {
    
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
