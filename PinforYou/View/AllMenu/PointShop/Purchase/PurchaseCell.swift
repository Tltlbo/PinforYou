//
//  PurchaseCell.swift
//  PinforYou
//
//  Created by 박진성 on 6/13/24.
//

import SwiftUI

struct PurchaseCell: View {
    var body: some View {
        HStack {
            
            Image(systemName: "creditcard")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .padding(.trailing, 20)
                .padding(.leading, 10)
            
            VStack(alignment:.leading) {
                HStack {
                    Text("스타벅스")
                        .font(.system(size: 17))
                        .foregroundStyle(.white)
                }
                .padding(.top, 10)
                
                HStack {
                    Text("스타벅스 아메리카노(T)")
                }
                .padding(.bottom, 10)
                
                HStack {
                    Text("4500P")
                }
                .padding(.bottom, 10)
            }
            .padding(.leading, 15)
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
    PurchaseCell()
}
