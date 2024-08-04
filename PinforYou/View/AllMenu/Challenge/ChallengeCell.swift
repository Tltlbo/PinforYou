//
//  ChallengeCell.swift
//  PinforYou
//
//  Created by 박진성 on 6/12/24.
//

import SwiftUI

struct ChallengeCell: View {
    let challengeName : String
    let goal : Int
    let achiveNumber : Int
    let point : Int
    
    var body: some View {
        HStack {
            VStack(alignment:.leading) {
                HStack {
                    Text(challengeName)
                        .font(.system(size: 17))
                        .foregroundStyle(.white)
                }
                .padding(.bottom, 10)
                
                VStack(alignment: .trailing) {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: 230, height: 2)
                            .foregroundColor(.white)
                        
                        Rectangle()
                            .frame(width: (Double(achiveNumber)/100) * 230, height: 2)
                            .foregroundStyle(Color.blue)
                    }
                    
                    Text("\(Int((Double(achiveNumber)/100) * 20)) / \(goal)")
                        .foregroundColor(.white)
                    
                    Text("\(point)P")
                        .foregroundColor(.white)
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
                .foregroundColor(.white)
        }
        .frame(width: UIScreen.main.bounds.size.width - 20)
        .background {
            Color("CellBackgroundColor")
        }
        .clipShape(.rect(cornerRadius: 20))
        
        
    }
}

#Preview {
    ChallengeCell(challengeName: "미션", goal: 20, achiveNumber: 20, point: 2000)
}
