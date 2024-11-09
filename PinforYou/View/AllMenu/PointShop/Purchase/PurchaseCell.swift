//
//  PurchaseCell.swift
//  PinforYou
//
//  Created by 박진성 on 6/13/24.
//

import SwiftUI
import Kingfisher

struct PurchaseCell: View {
    
    let gifticon : PointShopGifticon.Gifticon
    
    var body: some View {
        HStack {
            
            KFImage(URL(string: gifticon.imageURL))
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .padding(.trailing, 20)
                .padding(.leading, 10)
            
            VStack(alignment:.leading) {
                HStack {
                    Text(gifticon.place)
                        .font(.system(size: 17))
                        .foregroundStyle(.black)
                }
                .padding(.top, 10)
                
                HStack {
                    Text(gifticon.giftName)
                }
                .padding(.bottom, 10)
                
                HStack {
                    Text("\(gifticon.price)P")
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
    PurchaseCell(gifticon: .init(id: 1, giftName: "이름", place: "장소", price: 1000, category: "음식", imageURL: ""))
}
