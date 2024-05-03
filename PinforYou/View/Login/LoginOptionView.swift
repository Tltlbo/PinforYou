//
//  LoginOptionView.swift
//  PinforYou
//
//  Created by 박진성 on 4/15/24.
//

import SwiftUI
import AuthenticationServices

struct LoginOptionView: View {
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
                    Button {
                        //TODO: Google
                    } label: {
                        Circle()
                            .frame(width: 80,height: 80)
                            .overlay {Text("구글").foregroundColor(.black)}
                    }
                    
//                    Button {
//                        //TODO: KAKAO
//                    } label: {
//                        Circle()
//                            .frame(width: 80,height: 80)
//                            .overlay {Text("카카오").foregroundColor(.black)}
//                    }
                    KakaoLoginBtn()
                    
                }
                
                HStack(spacing:90) {
                
                SignInWithAppleButton { request in
                    //TODO:
                } onCompletion: { result in
                    //TODO:
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
