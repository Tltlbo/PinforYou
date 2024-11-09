//
//  Challenge.swift
//  PinforYou
//
//  Created by 박진성 on 8/3/24.
//

import Foundation

struct Challenges: Decodable {
    var challenges: [Challenge] = []
    
    enum CodingKeys: String, CodingKey {
        case challenges = "user_progress"
    }
}

struct Challenge : Decodable, Hashable {
    let goal : Int
    let challengeID : Int
    let challengeName : String
    var percent : Int
    let achivement : Bool
    let point : Int
    let imageUrl: String
    let description1: String
    let description2: String
    let description3: String
    let description4: String
    
    enum CodingKeys : String, CodingKey {
        case goal = "goal"
        case challengeID = "challenge_id"
        case challengeName = "challenge_name"
        case percent = "progress"
        case achivement = "achieved"
        case point = "point"
        case imageUrl
        case description1, description2, description3, description4
    }
    
    
}


