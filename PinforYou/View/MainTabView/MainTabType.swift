//
//  MainTabType.swift
//  PinforYou
//
//  Created by 박진성 on 5/5/24.
//

import Foundation

enum MainTabType : String, CaseIterable {
    case home
    case CardList //이거 이름 바꿔야 하지 않을까? MY 이런걸로 카드 정보랑 친구, 모임을 가지게 될 건데?
    case Event
    case AllMenu
    
    var title : String {
        switch self {
        case .home:
            return "홈"
        case .CardList:
            return "내 카드"
        case .Event:
            return "이벤트"
        case .AllMenu:
            return "메뉴"
        }
    }
    
    func imageName(selected: Bool) -> String {
        selected ? "square.and.arrow.up.circle.fill" : "square.and.arrow.up.circle.fill"
//        selected ? "\(rawValue)_fill" : "\(rawValue)"
    }
}
