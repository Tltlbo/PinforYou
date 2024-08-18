//
//  FriendListViewModel.swift
//  PinforYou
//
//  Created by 박진성 on 8/4/24.
//

import Foundation
import Combine

class FriendListViewModel : ObservableObject {
    
    enum Action {
        case getFriendInfo
    }
    
    @Published var isFinished : Bool = false
    @Published var FriendList : [Friend] = []
    
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action : Action, userid: Int = 1) {
        switch action {
        case .getFriendInfo:
            container.services.friendService.getFriendInfo(userid: userid)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        //
                    }
                } receiveValue: { [weak self] Friend in
                    self?.FriendList = Friend.friendList
                    self?.isFinished = true
                }
                .store(in: &subscriptions)

        }
    }
}
