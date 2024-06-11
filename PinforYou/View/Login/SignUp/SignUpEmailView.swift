//
//  SignUpEmailView.swift
//  PinforYou
//
//  Created by 박진성 on 6/11/24.
//

import SwiftUI

struct SignUpEmailView: View {
    var body: some View {
        NavigationStack {
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
                
                
                Text("이메일")
                    .padding(.top, 48)
                
                Text("이메일 인증번호")
                    .padding(.top, 82)
                
                Text("비밀번호")
                    .padding(.top, 82)
                
                Text("비밀번호 확인")
                    .padding(.top, 82)
                
                Spacer()
                
                NavigationLink {
                    SignUpUserInfoView()
                } label: {
                    HStack(alignment: .center) {
                        Text("다음")
                    }
                    .frame(width: UIScreen.main.bounds.size.width - 20, height: 72)
                    .background(Color("CellBackgroundColor"))
                    .clipShape(.rect(cornerRadius: 20))
                }

                
            }
            .padding(.leading, 10)
        }
    }
}

#Preview {
    SignUpEmailView()
}
