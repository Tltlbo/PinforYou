//
//  MygifticonCell.swift
//  PinforYou
//
//  Created by 박진성 on 7/28/24.
//

import SwiftUI
import Kingfisher

struct MygifticonCell: View {
    let gifticon : Usergifticon.gifticon
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
                        .foregroundStyle(.white)
                }
                .padding(.vertical, 10)
                
                HStack {
                    Text(gifticon.giftName)
                }
                .padding(.bottom, 20)
                

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
    MygifticonCell(gifticon: .init(list_id: 1, item_id: 1, place: "장소", giftName: "이름", imageURL: "", category: "카페", barcode: ""))
}
