//
//  CardCell.swift
//  PinforYou
//
//  Created by 박진성 on 5/19/24.
//

import SwiftUI

struct CardCell: View {
    var body: some View {
        
        VStack (alignment: .trailing) {
            HStack {
                Spacer()
                Text("나라사랑카드")
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
                
                
                VStack {
                    Spacer()
                    Text("1994")
                        .font(.system(size: 12))
                        .foregroundStyle(.white)
                }
                
            }
            .frame(height: 20)
            .padding(.bottom, 30)
            
            Text("30% 할인")
                .font(.system(size: 30))
                .foregroundStyle(.white)
        }
        .frame(width: UIScreen.main.bounds.size.width)
        .background(Color.gray)
        
    }
}

#Preview {
    CardCell()
}
