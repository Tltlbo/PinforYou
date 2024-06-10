//
//  MeetingCell.swift
//  PinforYou
//
//  Created by 박진성 on 6/10/24.
//

import SwiftUI

struct MeetingCell: View {
    var body: some View {
        HStack {
            Image(systemName: "airplane")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .padding(.horizontal, 10)
                
            
            VStack(alignment:.leading) {
                HStack {
                    Text("일본 여행 모임")
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                }
                .padding(.bottom, 30)
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
    MeetingCell()
}
