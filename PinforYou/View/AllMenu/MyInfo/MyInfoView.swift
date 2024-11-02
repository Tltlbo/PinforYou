//
//  MyInfoView.swift
//  PinforYou
//
//  Created by 박진성 on 6/11/24.
//

import SwiftUI

struct MyInfoView: View {
    @EnvironmentObject var authViewModel : AuthenticationViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack(spacing: 25) {
                    NameCell()
                    EmailCell()
                    PhoneNumberCell()
                    passwordModifyCell()
                    
                    Spacer()
                    
                    HStack(spacing: 10){
                        Button {
                            authViewModel.send(action: .logout)
                        } label: {
                            Text("로그아웃")
                        }
                        
                        Text("|")
                        
                        Button {
                            //
                        } label: {
                            Text("회원탈퇴")
                        }
                    }
                    .padding(.bottom, 40)

                }
                .navigationTitle("내 정보 수정")
                .background {
                    Color("BackgroundColor")
                        .ignoresSafeArea()
                }
            }
        }
    }
}





#Preview {
    MyInfoView()
}
