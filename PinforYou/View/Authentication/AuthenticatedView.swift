//
//  AuthenticatedView.swift
//  PinforYou
//
//  Created by 박진성 on 4/15/24.
//

import SwiftUI

struct AuthenticatedView: View {
    
    @StateObject var authViewModel : AuthenticationViewModel
    
    var body: some View {
        VStack (alignment: .leading){
            
            HStack {
                Text("""
                핀에 오신 걸
                환영해요!
                """)
                .font(.system(size: 30, weight: .bold))
                
                Spacer()
            }
            .padding(.leading, 21)
            .padding(.top, 177)
            
            Spacer()
            
            Button {
                //TODO: Login
            } label: {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 352,height: 72)
                    .overlay {Text("로그인").foregroundColor(.black)}
            }
            .padding(20)
            
            Button {
                //TODO: register
            } label: {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 352,height: 72)
                    .overlay {Text("회원가입").foregroundColor(.black)}
            }
            .padding(.leading, 20)
            .padding(.bottom, 200)
            
        }
        
        
        
    }
}

#Preview {
    LoginView()
}
