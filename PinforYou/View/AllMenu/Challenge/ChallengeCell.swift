//
//  ChallengeCell.swift
//  PinforYou
//
//  Created by 박진성 on 6/12/24.
//

import SwiftUI

struct ChallengeCell: View {
    var body: some View {
        HStack {
            VStack(alignment:.leading) {
                HStack {
                    Text("미션")
                        .font(.system(size: 17))
                        .foregroundStyle(.white)
                }
                .padding(.bottom, 10)
                
                VStack(alignment: .trailing) {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: 230, height: 2)
                        
                        Rectangle()
                            .frame(width: 100, height: 2)
                            .foregroundStyle(Color.blue)
                    }
                    
                    Text("17 / 20")
                    
                    Text("2000P")
                }
            }
            .padding(.leading, 15)
            Spacer()
            
            Image(systemName: "creditcard")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .padding(.trailing, 20)
                .padding(.leading, 10)
        }
        .frame(width: UIScreen.main.bounds.size.width - 20)
        .background {
            Color("CellBackgroundColor")
        }
        .clipShape(.rect(cornerRadius: 20))
        
        
    }
}

#Preview {
    ChallengeCell()
}
