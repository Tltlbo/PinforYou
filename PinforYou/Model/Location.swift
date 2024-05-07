//
//  Location.swift
//  PinforYou
//
//  Created by 박진성 on 5/7/24.
//

import Foundation

struct Location {
    var longitude : Double
    var latitude : Double
}

extension Location {
    static var locationstub1 : Location {
        .init(longitude: 126.978365, latitude: 37.566691)
    }
    
    static var loactionstub2 : User {
        .init(id: "user2_id", name: "김성훈")
    }
}

