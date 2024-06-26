//
//  AuthenticatedView.swift
//  PinforYou
//
//  Created by 박진성 on 4/15/24.
//

import SwiftUI
import GoogleSignIn

struct AuthenticatedView: View {
    
    @StateObject var authViewModel : AuthenticationViewModel
    
    var body: some View {
        
        VStack {
            switch authViewModel.authenticationState {
            case .unauthenticated:
                LoginIntroView()
                    .environmentObject(authViewModel)
                
            case .authenticated:
                MainTabView()
                    .environmentObject(authViewModel)
            }
        }
        .onAppear {
            authViewModel.send(action: .checkAuthenticationState)
        }
        
        
        
    }
}

#Preview {
    AuthenticatedView(authViewModel: .init(container: .init(services: StubService())))
}
