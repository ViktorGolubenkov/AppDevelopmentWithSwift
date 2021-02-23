//
//  Extensions.swift
//  RestaurantOrder
//
//  Created by Viktor Golubenkov on 06.11.2020.
//

import Foundation
import UIKit


// badge for order controller
extension UITabBarController {
    func increaseBadge(indexOfTab: Int, num: String) {
        let tabItem = tabBar.items![1]
        tabItem.badgeValue = num
        tabItem.badgeColor = .red
    }
}

