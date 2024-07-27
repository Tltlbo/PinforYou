//
//  passwordModifyCell.swift
//  PinforYou
//
//  Created by 박진성 on 7/27/24.
//

import SwiftUI

struct passwordModifyCell: View {
    var body: some View {
        HStack {
            VStack(alignment:.leading) {
                HStack {
                    Text("비밀번호 변경")
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                }
                .padding(.bottom, 5)
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
    passwordModifyCell()
}
