//
//  ChallengeView.swift
//  PinforYou
//
//  Created by 박진성 on 6/12/24.
//

import SwiftUI

struct ChallengeView: View {
    
    @StateObject var challengeViewModel : ChallengeViewModel
    
    var body: some View {
        
        if challengeViewModel.isFinished {
            NavigationStack {
                ZStack {
                    Color("BackgroundColor")
                        .ignoresSafeArea()
                    
                    VStack {
                        
                        Spacer()
                        
                        ScrollView(.vertical) {
                            VStack(spacing: 10) {
                                ForEach(challengeViewModel.ChallengeList, id: \.self) { challenge in
                                    NavigationLink {
                                        ChallengeDetailView()
                                    } label: {
                                        ChallengeCell(challengeName: challenge.challengeName, goal: challenge.goal, achiveNumber: challenge.percent, point: challenge.point)
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
        else {
            
            ZStack {
                Color("BackgroundColor")
                
                ProgressView()
                    .onAppear {
                        challengeViewModel.send(action: .getChallengeInfo)
                    }
            }
            
        }
    }
}

#Preview {
    ChallengeView(challengeViewModel: .init(container: .init(services: StubService())))
}
