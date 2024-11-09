//
//  EmailCell.swift
//  PinforYou
//
//  Created by 박진성 on 7/27/24.
//

import SwiftUI

struct EmailCell: View {
    let email: String
    var body: some View {
        HStack {
            VStack(alignment:.leading) {
                HStack {
                    Text("이메일")
                        .font(.system(size: 20))
                        .foregroundStyle(.black)
                }
                .padding(.bottom, 5)
                .padding(.leading, 10)
                
                HStack {
                    Text(email)
                        .font(.system(size: 20))
                        .foregroundStyle(.black)
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
    EmailCell(email: "")
}
