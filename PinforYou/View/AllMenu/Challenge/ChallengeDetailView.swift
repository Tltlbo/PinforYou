//
//  ChallengeDetailView.swift
//  PinforYou
//
//  Created by 박진성 on 6/12/24.
//

import SwiftUI

struct ChallengeDetailView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack(alignment:.leading) {
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
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(Color("CellBackgroundColor"))
                    
                    Text("우리가 어떤 민족입니까")
                        .padding(.top, 10)
                        .padding(.leading, 5)
                    
                    Text("앱에 등록된 카드로 아래 배달음식 플랫폼에서 20회 이상 주문 시 달성")
                        .padding(.top, 5)
                        .padding(.leading, 5)
                        .padding(.bottom, 10)
                    
                    Text("* 배달의 민족")
                        .padding(.leading, 10)
                    Text("* 요기요")
                        .padding(.leading, 10)
                    Text("* 쿠팡이츠")
                        .padding(.leading, 10)
                    
                    Text("* 주문 후 주문취소 시 인정되지 않음")
                        .padding(.top, 10)
                        .padding(.leading, 5)
                    Spacer()
                }
                
            }
            .navigationTitle("챌린지 진행 정보")
        }
    }
    
}

#Preview {
    ChallengeDetailView()
}
