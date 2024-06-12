//
//  ChallengeView.swift
//  PinforYou
//
//  Created by 박진성 on 6/12/24.
//

import SwiftUI

struct ChallengeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack {
                    
                    Spacer()
                    
                    ScrollView(.vertical) {
                        VStack(spacing: 10) {
                            ForEach(0 ..< 15, id: \.self) { _ in
                                NavigationLink {
                                    ChallengeDetailView()
                                } label: {
                                    ChallengeCell()
                                }


                            }
                            
                        }
                    }
                    
                    Spacer()
                }
                
            }
            .navigationTitle("챌린지 진행 정보")
        }
    }
}

#Preview {
    ChallengeView()
}
