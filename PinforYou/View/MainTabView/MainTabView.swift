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
                        HomeView(kakaoMapViewModel: .init(container: container))
                    case .CardList:
                        CardListView()
                    case .Community:
                        CommunityView()
                    case .Event:
                        EventView()
                    case .AllMenu:
                        AllMenuView()
                    }
                }
                .tabItem {
                    Label(tab.title, systemImage: tab.imageName(selected: selectedTab == tab))
                    
                }
                .tag(tab)
            }
        }
        .tint(.white)
    }
    
    // 아직 swiftUI에서는 선택되지 않은 탭의 컬러 변경은 구현되지 X UIKit에 의존해야함.
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.gray)
    }
}

#Preview {
    MainTabView()
}
