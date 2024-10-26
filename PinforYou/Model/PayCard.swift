//
//  PayCard.swift
//  PinforYou
//
//  Created by 박진성 on 6/14/24.
//

import Foundation

struct PayCardModel : Decodable {
    
    var CardList : [PayCard] = []
    
    struct PayCard : Decodable, Hashable {
        var userID : String
        var cardID : Int
        var cardName : String
        var cardLastNum : String
        var discountPercent : Int
        var cardColor : String
        var description: String
        var uuid = UUID()
        
        enum CodingKeys : String, CodingKey {
            case userID = "hashed_id"
            case cardID = "card_id"
            case cardName = "card_name"
            case cardLastNum = "card_last_num"
            case discountPercent = "discount_percentage"
            case cardColor = "card_color"
            case description = "description"
        }
    }
    
    enum CodingKeys : String, CodingKey {
        case CardList = "card_list"
    }
}

//
//extension PayCard{
//    static var PaycardStub1 : Card {
//        .init(cardName: "나라사랑카드", cardNumber: "1994", salePercent: "10")
//    }
//    
//    static var PaycardStub2 : Card {
//        .init(cardName: "네이버페이머니카드", cardNumber: "1224", salePercent: "5")
//    }
//    
//    static var PaycardStub3 : Card {
//        .init(cardName: "토스카드", cardNumber: "1000", salePercent: "3")
//    }
//    
//    static var PaycardStub4 : Card {
//        .init(cardName: "신힌카드", cardNumber: "2352", salePercent: "5")
//    }
//    
//}
