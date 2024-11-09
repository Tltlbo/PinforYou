//
//  CardCell.swift
//  PinforYou
//
//  Created by 박진성 on 5/30/24.
//

import SwiftUI
import Kingfisher

struct MyCardCell: View {
    
    let card : CardInfo.Carda
    
    var body: some View {
        HStack {
            KFImage(URL(string: card.card_image_url))
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 100)
                .padding(.horizontal, 30)
                .rotationEffect(.degrees(-90.0))
                
            VStack(alignment:.leading) {
                HStack {
                    Text(card.cardName)
                        .font(.system(size: 20))
                        .foregroundStyle(.black)
                }
                .padding(.bottom, 20)
                
                Text(card.cardNum)
                    .font(.system(size: 20))
                    .foregroundStyle(.black)
            }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.size.width - 20)
        .background {
            Color("CellBackgroundColor")
        }
        .clipShape(.rect(cornerRadius: 20))
        
    }
}

#Preview {
    MyCardCell(card: .init(cardID: 1, cardName: "test", cardNum: "teset", card_image_url: ""))
}
