//
//  Registration.swift
//  HotelManzana2020
//
//  Created by Viktor Golubenkov on 09.10.2020.
//

import Foundation


struct Registration {
    
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    var roomType: RoomType
    var wifi: Bool
  
}


struct RoomType {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    static var all: [RoomType] {
        return [
            RoomType(id: 0, name: "Two Queen", shortName: "2Q", price: 179),
            RoomType(id: 1, name: "King Bed", shortName: "1K", price: 209),
            RoomType(id: 2, name: "Penthouse Suite", shortName: "PHS", price: 309),
        ]
    }
}

extension RoomType: Equatable {
    static func ==(lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
}




