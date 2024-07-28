//
//  CardCell.swift
//  PinforYou
//
//  Created by 박진성 on 5/30/24.
//

import SwiftUI

struct MyCardCell: View {
    
    let card : CardInfo.Carda
    
    var body: some View {
        HStack {
            Image(systemName: "creditcard")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .padding(.horizontal, 10)
                
            
            VStack(alignment:.leading) {
                HStack {
                    Text(card.cardName)
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                }
                .padding(.bottom, 30)
                
                Text(card.cardNum)
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
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
    MyCardCell(card: .init(cardID: 1, cardName: "test", cardNum: "teset"))
}
