//
//  UserID.swift
//  PinforYou
//
//  Created by 박진성 on 10/25/24.
//

import Foundation

final class UserID {
    
    static let shared = UserID()
    
    private init() {}
    
    var hashedID: String? {
        if let id = UserDefaults.standard.string(forKey: "hashedID") {
            return id
        }
        return nil
    }
}
