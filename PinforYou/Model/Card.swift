//
//  Card.swift
//  PinforYou
//
//  Created by 박진성 on 5/19/24.
//

import Foundation

struct Card : Hashable {
    var cardName : String
    var cardNumber : String
    //test
    var salePercent : String
    
    var id = UUID()
}

struct CardInfo : Decodable {
    
    var CardList : [Carda] = []
    
    struct Carda : Hashable, Decodable {
        var cardID : Int
        var cardName : String
        var cardNum : String
        var ID = UUID()
        
        enum CodingKeys : String, CodingKey {
            case cardID = "card_id"
            case cardName = "card_name"
            case cardNum = "card_num"
        }
    }
    
    enum CodingKeys : String, CodingKey {
        case CardList =  "userCard_list"
    }
    
    
}


extension Card{
    static var cardStub1 : Card {
        .init(cardName: "나라사랑카드", cardNumber: "1994", salePercent: "10")
    }
    
    static var cardStub2 : Card {
        .init(cardName: "네이버페이머니카드", cardNumber: "1224", salePercent: "5")
    }
    
    static var cardStub3 : Card {
        .init(cardName: "토스카드", cardNumber: "1000", salePercent: "3")
    }
    
    static var cardStub4 : Card {
        .init(cardName: "신힌카드", cardNumber: "2352", salePercent: "5")
    }
    
}

struct RecommendCardInfo : Decodable {
    let category : String
    let name : String
    let image_URL : String
    let benefits : [String]
    
    enum CodingKeys: String, CodingKey {
        case category = "category"
        case name = "name"
        case image_URL = "image_url"
        case benefits = "benefits"
    }
}

struct ValidityCard: Decodable {
    let company: String
    let card: String
    
    enum CodingKeys: String, CodingKey {
        case company = "company_name"
        case card = "card_name"
    }
}
