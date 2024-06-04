//
//  MainTabType.swift
//  PinforYou
//
//  Created by 박진성 on 5/5/24.
//

import Foundation

enum MainTabType : String, CaseIterable {
    
    case Community = "person.2"
    case CardList = "creditcard"
    case home = "house"
    case Event = "gift"
    case AllMenu = "tray"
    
    var title : String {
        switch self {
        case .home:
            return "홈"
        case .CardList:
            return "내 카드"
        case .Community:
            return "커뮤니티"
        case .Event:
            return "이벤트"
        case .AllMenu:
            return "메뉴"
        }
    }
    
    func imageName(selected: Bool) -> String {
        //selected ? "square.and.arrow.up.circle.fill" : "square.and.arrow.up.circle.fill"
        selected ? "\(rawValue).fill" : "\(rawValue)"
    }
}
