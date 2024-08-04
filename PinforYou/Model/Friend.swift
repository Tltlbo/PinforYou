//
//  Friend.swift
//  PinforYou
//
//  Created by 박진성 on 8/4/24.
//

import Foundation

struct Friends : Decodable {
    
    var friendList : [Friend] = []
    
    struct Friend : Hashable, Decodable {
        let friendID : Int
        let name : String
        
        enum CodingKeys : String, CodingKey {
            case friendID = "friend_id"
            case name = "name"
        }
    }
    
    enum CodingKeys : String, CodingKey {
        case friendList = "friend"
    }
    
    
}
