//
//  AllMenuView.swift
//  PinforYou
//
//  Created by 박진성 on 6/3/24.
//

import SwiftUI

struct AllMenuView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment:.leading) {
                
                HStack {
                    Text("""
                        박진성님,
                        안녕하세요!
                        """)
                    .font(.system(size: 26, weight: .bold))
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.bottom, 63)
                .padding(.top, 60)
                
                
                NavigationLink {
                    MyInfoView()
                } label: {
                    Text("내 정보")
                        .font(.system(size: 26))
                        .padding(.leading, 20)
                        .padding(.bottom, 58)
                        .foregroundStyle(.white)
                }
                
                NavigationLink {
                    ChallengeView()
                } label: {
                    Text("챌린지")
                        .font(.system(size: 26))
                        .padding(.leading, 20)
                        .padding(.bottom, 58)
                }
                
                Text("포인트 샵")
                    .font(.system(size: 26))
                    .padding(.leading, 20)
                
                
                //임시 작업
                Spacer()
            }
            .background {
                Color("BackgroundColor")
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    AllMenuView()
}
