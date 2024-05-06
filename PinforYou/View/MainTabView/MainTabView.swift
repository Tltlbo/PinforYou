//
//  MainTabView.swift
//  PinforYou
//
//  Created by 박진성 on 5/5/24.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var authViewModel : AuthenticationViewModel
    @EnvironmentObject var container : DIContainer
    @State private var selectedTab : MainTabType = .home
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            ForEach(MainTabType.allCases,id: \.self) { tab in
                
                Group {
                    switch tab {
                    case .home:
                        Color.blue
                    case .CardList:
                        Color.white
                    case .Event:
                        Color.brown
                    case .AllMenu:
                        Color.cyan
                    }
                }
                .tabItem {
                    Label(tab.title, image: tab.imageName(selected: selectedTab == tab))
                }
                .tag(tab)
            }
        }
        .tint(.black)
    }
    
    // 아직 swiftUI에서는 선택되지 않은 탭의 컬러 변경은 구현되지 X UIKit에 의존해야함.
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.black)
    }
}

#Preview {
    MainTabView()
}
