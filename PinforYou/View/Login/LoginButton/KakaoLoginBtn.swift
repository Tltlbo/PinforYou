//
//  KakaoLoginBtn.swift
//  PinforYou
//
//  Created by 박진성 on 5/1/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

struct KakaoLoginBtn: View {
    var body: some View {
        Button {
            if (UserApi.isKakaoTalkLoginAvailable()) {
                UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    
                    if let oauthToken = oauthToken {
                        //TODO: 소셜 로그인(회원가입 API Call)
                    }
                    
                }
            } else {
                UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    if let oauthToken = oauthToken {
                        print("kakao success")
                        //TODO: 소셜 로그인(회원가입 API Call)
                    }
                }
            }
        } label: {
            Image("kakao_login_medium_narrow")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
        }
        
        
    }
}

#Preview {
    KakaoLoginBtn()
}