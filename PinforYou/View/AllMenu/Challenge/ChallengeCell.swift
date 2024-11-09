//
//  ChallengeCell.swift
//  PinforYou
//
//  Created by 박진성 on 6/12/24.
//

import SwiftUI
import Kingfisher

struct ChallengeCell: View {
    let challenge: Challenge
    
    var body: some View {
        HStack {
            VStack(alignment:.leading) {
                HStack {
                    Text(challenge.challengeName)
                        .font(.system(size: 17))
                        .foregroundStyle(.black)
                }
                .padding(.bottom, 10)
                
                VStack(alignment: .trailing) {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: 230, height: 2)
                            .foregroundColor(.black)
                        
                        Rectangle()
                            .frame(width: (Double(challenge.percent)/100) * 230, height: 2)
                            .foregroundStyle(Color.blue)
                    }
                    
                    Text("\(challenge.percent) / \(challenge.goal)")
                        .foregroundColor(.black)
                    
                    Text("\(challenge.point)P")
                        .foregroundColor(.black)
                }
            }
            .padding(.leading, 15)
            Spacer()
            
            KFImage(URL(string: challenge.imageUrl))
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .padding(.trailing, 20)
                .padding(.leading, 10)
                .foregroundColor(.white)
        }
        .frame(width: UIScreen.main.bounds.size.width - 20)
        .background {
            Color("CellBackgroundColor")
        }
        .clipShape(.rect(cornerRadius: 20))
        
        
    }
}

