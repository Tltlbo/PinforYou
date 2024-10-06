//
//  LoginOptionView.swift
//  PinforYou
//
//  Created by 박진성 on 4/15/24.
//

import SwiftUI
import AuthenticationServices
import GoogleSignInSwift

struct LoginOptionView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel : AuthenticationViewModel
    
    var body: some View {
        VStack (alignment: .leading){
            
            HStack {
                Text("""
                로그인 방법을
                선택해주세요!
                """)
                .font(.system(size: 30, weight: .bold))
                
                Spacer()
            }
            .padding(.leading, 21)
            .padding(.top, 177)
            
            Spacer()
            
            
            VStack(spacing: 40) {
                HStack(spacing: 90){
                    GoogleSignInButton(
                        scheme: .light,
                        style: .wide,
                        action: {
                            authViewModel.send(action: .googleLogin)
                        }
                    )
                    .frame(width: 80)
                    
                    KakaoLoginBtn()
                    
                }
                
                HStack(spacing:90) {
                
                SignInWithAppleButton { request in
                    authViewModel.send(action: .appleLogin(request))
                } onCompletion: { result in
                    authViewModel.send(action: .appleLoginCompletion(result))
                }
                .frame(height: 20)

                    
                    Button {
                        //TODO: 소셜
                    } label: {
                        Circle()
                            .frame(width: 80,height: 80)
                            .overlay {Text("소셜").foregroundColor(.black)}
                    }
                }
            }
            .padding(.bottom, 200)
            .padding(.leading, 71)
            
        }
    }
}

#Preview {
    LoginOptionView()
}
