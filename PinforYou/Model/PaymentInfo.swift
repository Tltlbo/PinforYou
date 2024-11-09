//
//  PaymentInfo.swift
//  PinforYou
//
//  Created by 박진성 on 6/19/24.
//

import Foundation

struct PaymentInfo : Decodable {
    
    var userID : String
    var cardID : Int
    var cardName : String
    var cardNum : String
    var cardColor : String
    var card_image_url : String
    var Payments : [Payment] = []
    
    
    struct Payment : Decodable, Hashable {
        var payAmount : Int
        var Date : String
        var StoreName : String
        var category : String
        var id = UUID()
        
        enum CodingKeys : String, CodingKey {
            case payAmount = "pay_amount"
            case Date = "purchase_date"
            case StoreName = "store_name"
            case category = "category"
        }
    }
    
    enum CodingKeys : String, CodingKey {
        case userID = "hashed_id"
        case cardID = "card_id"
        case cardName = "card_name"
        case cardNum = "card_num"
        case cardColor = "card_color"
        case Payments = "payments"
        case card_image_url
    }
}

extension PaymentInfo {
//    static var paymentCardInfotub1 : Location {
//        .init(longitude: 126.978365, latitude: 37.566691)
//    }

}
