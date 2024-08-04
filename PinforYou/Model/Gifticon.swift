//
//  Gifticon.swift
//  PinforYou
//
//  Created by 박진성 on 8/4/24.
//

import Foundation

struct PointShopGifticon : Decodable, Hashable {
    
    let id : Int
    let giftName : String
    let place : String
    let price : Int
    let category : String
    let imageURL : String
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case giftName = "item_name"
        case place = "use_place"
        case price = "item_price"
        case category = "category"
        case imageURL = "image_url"
    }
    
    
}
