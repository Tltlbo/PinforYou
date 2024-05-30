//
//  CardCell.swift
//  PinforYou
//
//  Created by 박진성 on 5/30/24.
//

import SwiftUI

struct MyCardCell: View {
    var body: some View {
        
    
        HStack {
            Image(systemName: "creditcard")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .padding(.horizontal, 10)
                
            
            VStack(alignment:.leading) {
                HStack {
                    Text("KB 국민 노리2 체크카드")
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                }
                .padding(.bottom, 30)
                
                Text("1234-1234-1234-1234")
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
                    
                
                
            }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.size.width)
        .background(Color.gray)
        .clipShape(.rect(cornerRadius: 20))
        
    }
}

#Preview {
    MyCardCell()
}
