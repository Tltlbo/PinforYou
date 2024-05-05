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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MainTabView()
}
