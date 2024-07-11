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
        
        VStack(spacing: 0) {
            
            
            switch selectedTab {
            case .home:
                HomeView(kakaoMapViewModel: .init(container: container))
            case .CardList:
                MyCardView()
            case .Community:
                CommunityView()
            case .Event:
                EventView()
            case .AllMenu:
                AllMenuView()
            }
            
            Spacer()
            
            CustomTabView(selectedTab: $selectedTab)
        }
        .background {
            Color("BackgroundColor")
        }
        
    }
    
}

#Preview {
    MainTabView()
}
