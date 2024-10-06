//
//  SignUpUserInfoView.swift
//  PinforYou
//
//  Created by 박진성 on 6/11/24.
//

import SwiftUI

struct SignUpUserInfoView: View {
    
    @EnvironmentObject var authViewModel : AuthenticationViewModel
    
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
                
                
                Text("이름")
                    .padding(.top, 48)
                
                Text("휴대폰 번호")
                    .padding(.top, 82)
                
                Text("성별")
                    .padding(.top, 82)
                
                Text("나이")
                    .padding(.top, 82)
                
                Spacer()
                
                NavigationLink {
                    //
                } label: {
                    HStack(alignment: .center) {
                        Text("완료")
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
    SignUpUserInfoView()
}
