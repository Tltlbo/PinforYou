//
//  MygifticonCell.swift
//  PinforYou
//
//  Created by 박진성 on 7/28/24.
//

import SwiftUI

struct MygifticonCell: View {
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
                .padding(.vertical, 10)
                
                HStack {
                    Text("스타벅스 아메리카노(T)")
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
    MygifticonCell()
}
