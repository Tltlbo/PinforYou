//
//  RecommendCardView.swift
//  PinforYou
//
//  Created by 박진성 on 6/11/24.
//

import SwiftUI
import Kingfisher

struct RecommendCardView: View {
    
    @StateObject var recommendCardViewModel : RecommendCardViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("""
                        \(recommendCardViewModel.category) 카테고리에서
                        많이 사용하셨네요!
                        이 카드는 어떠세요?
                        """)
                    .font(.system(size: 26, weight: .bold))
                    
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.bottom, 10)
                
                KFImage(URL(string: recommendCardViewModel.image_url))
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.size.width, height: 330)
                
                Text(recommendCardViewModel.name)
                    .font(.system(size: 25))
                
                ForEach(recommendCardViewModel.benefits, id: \.self) { benefit in
                    HStack {
                        Text("* ")
                        Text(benefit)
                    }
                }
                
            }
            .background {
                Color("BackgroundColor")
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            recommendCardViewModel.send(action: .getRecommendCard)
        }
    }
}

#Preview {
    RecommendCardView(recommendCardViewModel: .init(container: .init(services: StubService())))
}
