//
//  UserObject.swift
//  PinforYou
//
//  Created by 박진성 on 5/2/24.
//

import Foundation

struct UserObject : Codable {
    var id : String
    var name : String
    var phoneNumber : String?
    var profileURL : String?
    var description : String?
}

extension UserObject {
    func toModel() -> User {
        .init(
            id : id,
            name : name,
            phoneNumber : phoneNumber,
            profileURL : profileURL,
            description : description
        )
    }
}
