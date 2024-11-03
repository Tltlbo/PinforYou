//
//  SignUpEmailView.swift
//  PinforYou
//
//  Created by 박진성 on 6/11/24.
//

import SwiftUI

struct SignUpEmailView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var verifyPassword: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text("""
                        사용자 정보를
                        입력해주세요!
                        """)
                        .font(.system(size: 26, weight: .bold))
                        
                        Spacer()
                    }
                    .padding(.top, 80)
                    
                    VStack(alignment: .leading) {
                        Text("이메일")
                        TextField("이메일을 입력해주세요", text: $email)
                            .autocorrectionDisabled(true)
                            .keyboardType(.emailAddress)
                        Divider()
                    }
                    .padding(.top, 48)
                    
                    
                    Text("이메일 인증번호")
                        .padding(.top, 52)
                    
                    VStack(alignment: .leading) {
                        Text("비밀번호")
                        SecureField("비밀번호를 입력해주세요", text: $password)
                            .autocorrectionDisabled(true)
                            .keyboardType(.default)
                        Divider()
                    }
                    .padding(.top, 52)
                    
                    
                    VStack(alignment: .leading) {
                        Text("비밀번호")
                        SecureField("비밀번호를 입력해주세요", text: $verifyPassword)
                            .autocorrectionDisabled(true)
                            .keyboardType(.default)
                        Divider()
                    }
                    .padding(.top, 52)
                    
                    Spacer()
                    
                    NavigationLink {
                        SignUpUserInfoView(email: $email, password: $password)
                    } label: {
                        HStack(alignment: .center) {
                            Text("다음")
                        }
                        .frame(width: UIScreen.main.bounds.size.width - 20, height: 72)
                        .background(Color("CellBackgroundColor"))
                        .clipShape(.rect(cornerRadius: 20))
                    }
                    .disabled(
                        email.isEmpty ||
                        (password != verifyPassword)
                    )
                    
                    
                }
                .padding(.leading, 10)
            }
        }
    }
}

#Preview {
    SignUpEmailView()
}
