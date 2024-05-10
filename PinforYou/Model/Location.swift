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
    
    static var loactionstub2 : Location {
        .init(longitude: 128.75714469364593, latitude: 35.828704833984375)
    }
}

