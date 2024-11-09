//
//  CardCell.swift
//  PinforYou
//
//  Created by 박진성 on 5/19/24.
//

import SwiftUI

struct CardCell: View {
    var cardInfo : PayCardModel.PayCard
    var body: some View {
        
        VStack (alignment: .trailing) {
            HStack {
                Spacer()
                Text("\(cardInfo.cardName)")
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
                
                
                VStack {
                    Spacer()
                    Text("\(cardInfo.cardLastNum)")
                        .font(.system(size: 12))
                        .foregroundStyle(.white)
                }
                
            }
            .frame(height: 20)
            .padding(.bottom, 30)
            
            Text("\(String(format: "%.1f", cardInfo.discountPercent))% 할인")
                .font(.system(size: 30))
                .foregroundStyle(.white)
        }
        .frame(width: UIScreen.main.bounds.size.width)
        .background(Color.init(hex: cardInfo.cardColor))
        
    }
}

