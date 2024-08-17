//
//  MyCardView.swift
//  PinforYou
//
//  Created by 박진성 on 6/10/24.
//

import SwiftUI

enum CardOption {
    case MyCard
    case Recommend
}

struct MyCardView: View {
    
    @State var OptionSelect : CardOption = .MyCard
    @EnvironmentObject var container : DIContainer
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    OptionSelect = .MyCard
                } label: {
                    HStack {
                        Text("내 카드")
                            .font(.system(size: 17))
                    }
                    .frame(width: 70, height: 35)
                    .background(Color("CellBackgroundColor"))
                    .clipShape(.rect(cornerRadius: 12))
                }
                .padding(.leading, 10)
                
                Button {
                    OptionSelect = .Recommend
                } label: {
                    HStack {
                        Text("추천")
                            .font(.system(size: 17))
                    }
                    .frame(width: 70, height: 35)
                    .background(Color("CellBackgroundColor"))
                    .clipShape(.rect(cornerRadius: 12))
                }
                Spacer()
            }
            
            switch OptionSelect {
            case .MyCard:
                CardListView(cardlistViewModel: .init(container: container))
            case .Recommend:
                RecommendCardView(recommendCardViewModel: .init(container: container))
            }
        }
        .background {
            Color("BackgroundColor")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    MyCardView()
}
