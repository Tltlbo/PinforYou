//
//  PhoneNumberCell.swift
//  PinforYou
//
//  Created by 박진성 on 7/27/24.
//

import SwiftUI

struct PhoneNumberCell: View {
    var body: some View {
        HStack {
            VStack(alignment:.leading) {
                HStack {
                    Text("휴대폰 번호")
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                }
                .padding(.bottom, 5)
                .padding(.leading, 10)
                
                HStack {
                    Text("010-7450-9304")
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                }
                .padding(.leading, 10)
            }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.size.width - 25, height: 76)
        .background {
            Color("CellBackgroundColor")
        }
        .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    PhoneNumberCell()
}
