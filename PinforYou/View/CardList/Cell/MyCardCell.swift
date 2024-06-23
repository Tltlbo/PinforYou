//
//  CardCell.swift
//  PinforYou
//
//  Created by 박진성 on 5/30/24.
//

import SwiftUI

struct MyCardCell: View {
    
    var cardName : String
    var cardNum : String
    
    var body: some View {
        HStack {
            Image(systemName: "creditcard")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .padding(.horizontal, 10)
                
            
            VStack(alignment:.leading) {
                HStack {
                    Text(cardName)
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                }
                .padding(.bottom, 30)
                
                Text(cardNum)
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
    MyCardCell(cardName: "HELLO", cardNum: "1234-1234-1234-1234")
}
