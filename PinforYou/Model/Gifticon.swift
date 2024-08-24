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

struct Usergifticon : Decodable {
    let userID : Int
    var gifticonList : [gifticon] = []
    
    struct gifticon : Decodable, Hashable {
        let list_id : Int
        let item_id : Int
        let place : String
        let giftName : String
        let imageURL : String
        let category : String
        let barcode : Barcode
        
        struct Barcode: Decodable, Hashable {
            let image_URL: String
            
            enum CodingKeys : String, CodingKey {
                case image_URL = "body"
            }
        }
        
        enum CodingKeys : String, CodingKey {
            case list_id = "item_list_id"
            case item_id = "item_id"
            case place = "use_place"
            case giftName = "name"
            case imageURL = "image_url"
            case category = "category"
            case barcode = "barcode"
        }
    }
    
    enum CodingKeys : String, CodingKey {
        case userID = "user_id"
        case gifticonList = "item_list"
    }
}
