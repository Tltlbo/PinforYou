//
//  ChallengeViewModel.swift
//  PinforYou
//
//  Created by 박진성 on 8/3/24.
//

import Foundation
import Combine

class ChallengeViewModel : ObservableObject {
    
    enum Action {
        case getChallengeInfo
    }
    
    @Published var isFinished : Bool = false
    @Published var ChallengeList : [Challenge] = []
    
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action : Action, userid: Int = 1) {
        switch action {
        case .getChallengeInfo:
            container.services.challengeService.getChallengeInfo(userid: userid)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        //
                    }
                } receiveValue: { [weak self] challenge in
                    for i in challenge {
                        self?.ChallengeList.append(i)
                    }
                    self?.isFinished = true
                }
                .store(in: &subscriptions)

        }
    }
}
