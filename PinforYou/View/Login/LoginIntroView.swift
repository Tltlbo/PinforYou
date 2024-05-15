//
//  LoginIntroView.swift
//  PinforYou
//
//  Created by 박진성 on 5/4/24.
//

import SwiftUI

struct LoginIntroView: View {
    
    @State private var isPresentedLoginOptionView : Bool = false
    
    var body: some View {
        
        
        NavigationStack {
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
                    isPresentedLoginOptionView = true
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
                
                .navigationDestination(isPresented: $isPresentedLoginOptionView) {
                    LoginOptionView()
                }
                
            }
        }
    }
        
}

#Preview {
    LoginIntroView()
}
