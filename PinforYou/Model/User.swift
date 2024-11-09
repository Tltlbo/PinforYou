//
//  User.swift
//  PinforYou
//
//  Created by 박진성 on 5/2/24.
//

import Foundation

struct User {
    var id : String
    var name : String
    var phoneNumber : String?
    var profileURL : String?
    var description : String?
}

struct UserInfo: Decodable {
    let result: Bool
    let name: String
    let tel: String
    let email: String?
}

extension User {
    func toObject() -> UserObject {
        .init(
            id : id,
            name : name,
            phoneNumber : phoneNumber,
            profileURL : profileURL,
            description : description
        )
    }
}


extension User {
    static var stub1 : User {
        .init(id: "user1_id", name: "박진성")
    }
    
    static var stub2 : User {
        .init(id: "user2_id", name: "김성훈")
    }
}
