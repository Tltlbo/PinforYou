//
//  Event.swift
//  PinforYou
//
//  Created by 박진성 on 8/12/24.
//

import Foundation

struct Event : Decodable {
    
    var issuanceEvent : [Issuance] = []
    var paymentEvent  : [Payment] = []
    
    struct Issuance: Decodable, Hashable {
        let card_event_image: String
        let card_event_url: String
    }
    
    struct Payment: Decodable, Hashable {
        let pay_event_image: String
        let pay_event_url: String
    }
    
    
    enum CodingKeys : String, CodingKey {
        case issuanceEvent = "card_event"
        case paymentEvent = "pay_event"
    }
    
}
