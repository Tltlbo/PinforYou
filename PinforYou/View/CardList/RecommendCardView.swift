//
//  RecommendCardView.swift
//  PinforYou
//
//  Created by 박진성 on 6/11/24.
//

import SwiftUI

struct RecommendCardView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("""
                        // 카테고리에서
                        많이 사용하셨네요!
                        이 카드는 어떠세요?
                        """)
                    .font(.system(size: 26, weight: .bold))
                    
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.bottom, 10)
                
                Image(systemName: "creditcard.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.size.width, height: 330)
                
                Text("네이버페이머니카드")
                    .font(.system(size: 25))
                Text("*")
                
            }
            .background {
                Color("BackgroundColor")
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    RecommendCardView()
}
