//
//  ChallengeDetailView.swift
//  PinforYou
//
//  Created by 박진성 on 6/12/24.
//

import SwiftUI
import Kingfisher

struct ChallengeDetailView: View {
    let challenge: Challenge
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack(alignment:.leading) {
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
                                    
                                    Rectangle()
                                        .frame(width: (Double(challenge.percent)/100) * 230, height: 2)
                                        .foregroundStyle(Color.blue)
                                }
                                
                                Text("\(Int((Double(challenge.percent)/100) * 20)) / \(challenge.goal)")
                                
                                Text("\(challenge.point)P")
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
                    }
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(Color("CellBackgroundColor"))
                    
                    Text(challenge.description1)
                        .padding(.top, 10)
                        .padding(.leading, 5)
                    
                    Text(challenge.description2)
                        .padding(.top, 5)
                        .padding(.leading, 5)
                        .padding(.bottom, 10)
                    
                    Text(challenge.description3)
                        .padding(.leading, 10)
                    
                    
                    Text(challenge.description4)
                        .padding(.top, 10)
                        .padding(.leading, 5)
                    Spacer()
                }
                
            }
            .navigationTitle("챌린지 진행 정보")
        }
    }
    
}

