//
//  Gifticon.swift
//  PinforYou
//
//  Created by 박진성 on 8/4/24.
//

import Foundation

struct PointShopGifticon : Decodable {
    
    var items: [Gifticon] = []
    
    struct Gifticon: Decodable, Hashable {
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
    enum CodingKeys : String, CodingKey {
        case items = "items"
    }
    
    
}

struct Usergifticon : Decodable {
    let userID : Int
    var gifticonList : [gifticon] = []
    
    struct gifticon : Decodable, Hashable, Identifiable {
        var id: Int {item_id}
        let list_id : Int
        let item_id : Int
        let place : String
        let giftName : String
        let imageURL : String
        let category : String
        let barcodeURL : String
        
        enum CodingKeys : String, CodingKey {
            case list_id = "item_list_id"
            case item_id = "item_id"
            case place = "use_place"
            case giftName = "name"
            case imageURL = "image_url"
            case category = "category"
            case barcodeURL = "barcode_url"
        }
    }
    
    enum CodingKeys : String, CodingKey {
        case userID = "user_id"
        case gifticonList = "item_list"
    }
}

