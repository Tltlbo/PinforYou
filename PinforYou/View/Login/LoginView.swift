//
//  LoginView.swift
//  PinforYou
//
//  Created by 박진성 on 11/3/24.
//

import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var authViewModel : AuthenticationViewModel
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading){
                HStack {
                    Text("""
                로그인 정보를
                입력해주세요!
                """)
                    .font(.system(size: 30, weight: .bold))
                    
                    Spacer()
                }
                .padding(.top, 50)
                
                VStack(alignment: .leading) {
                    Text("이메일")
                    TextField("이메일을 입력해주세요", text: $email)
                        .autocorrectionDisabled(true)
                        .keyboardType(.emailAddress)
                    Divider()
                }
                .padding(.top, 48)
                
                VStack(alignment: .leading) {
                    Text("비밀번호")
                    SecureField("비밀번호를 입력해주세요", text: $password)
                        .autocorrectionDisabled(true)
                        .keyboardType(.default)
                    Divider()
                }
                .padding(.top, 52)
                
                Spacer()
                
                Button {
                    authViewModel.send(action: .login, email: email, password: password)
                } label: {
                    HStack(alignment: .center) {
                        Text("완료")
                    }
                    .frame(width: UIScreen.main.bounds.size.width - 20, height: 72)
                    .background(Color("CellBackgroundColor"))
                    .clipShape(.rect(cornerRadius: 20))
                }
                .disabled(email.isEmpty || password.isEmpty)
            }
            .padding(.leading, 10)
        }
    }
}

#Preview {
    LoginView()
}
