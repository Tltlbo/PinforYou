//
//  MainTabType.swift
//  PinforYou
//
//  Created by 박진성 on 5/5/24.
//

import Foundation

enum MainTabType : String, CaseIterable {
    
    case Community = "community"
    case CardList = "mycard"
    case home = "Main"
    case Event = "event"
    case AllMenu = "allmenu"
    
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
        selected ? "\(rawValue)_fill" : "\(rawValue)"
    }
}
