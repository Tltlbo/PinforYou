//
//  Event.swift
//  PinforYou
//
//  Created by 박진성 on 8/12/24.
//

import Foundation

struct Event : Decodable {
    
    var issuanceEvent : [String] = []
    var paymentEvent  : [String] = []
    
    
    enum CodingKeys : String, CodingKey {
        case issuanceEvent = "card_event"
        case paymentEvent = "pay_event"
    }
    
}
