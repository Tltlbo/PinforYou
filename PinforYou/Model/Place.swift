//
//  Place.swift
//  PinforYou
//
//  Created by 박진성 on 5/9/24.
//

import Foundation

struct PlaceModel : Decodable {
    
    var PlaceList : [Place] = []
    
    struct Place : Decodable {
        var addressName : String
        var categoryName : String
        var placeName : String
        var longitude : String
        var latitude : String
        
        enum CodingKeys : String, CodingKey {
            case addressName = "address_name"
            case categoryName = "category_group_name"
            case placeName = "place_name"
            case longitude = "x"
            case latitude = "y"
        }
    }
    
    enum CodingKeys : String, CodingKey {
        case PlaceList = "documents"
    }
    
}

extension PlaceModel{
    static var placestub1 : PlaceModel {
        .init(PlaceList: [.init(addressName: "경북 경산시 계양동 683-2", categoryName: "문화시설", placeName: "경산시민회관 대강당", longitude: "128.747792077122", latitude: "35.8182327198273")])
    }
    
    static var placestub2 : PlaceModel {
        .init(PlaceList: [.init(addressName: "경북 경산시 중방동 241-9", categoryName: "문화시설", placeName: "남천둔치 야외공연장", longitude: "128.733586292405", latitude: "35.8306614099553")])
    }
}
