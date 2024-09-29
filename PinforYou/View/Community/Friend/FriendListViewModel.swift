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
        case getRequestFriendInfo
        case deleteFriendInfo
        case acceptRequestFriend
    }
    
    @Published var isFinished : Bool = false
    @Published var isDelete: Bool = false
    @Published var isAccept: Bool = false
    @Published var FriendList : [Friend] = []
    @Published var RequestFriendList : [Friend] = []
    
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action : Action, userid: Int, friendid: Int?) {
        switch action {
        case .getFriendInfo:
            container.services.friendService.getFriendInfo(userid: userid)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        //
                    }
                } receiveValue: { [weak self] Friend in
                    self?.FriendList = Friend.friendList
                    self?.FriendList.forEach({ friend in
                        print(friend.name)
                    })
                    self?.isFinished = true
                }
                .store(in: &subscriptions)
            
        case .getRequestFriendInfo:
            container.services.friendService.getRequestFriendInfo(userid: userid)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        //
                    }
                } receiveValue: { [weak self] Friend in
                    self?.RequestFriendList = Friend.requestfriendList
                    self?.isFinished = true
                }
                .store(in: &subscriptions)
            
        case .deleteFriendInfo:
            container.services.friendService.deleteFriendInfo(userid: userid, friendid: friendid!)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        //
                    }
                } receiveValue: { [weak self] result in
                    if result {
                        self?.isDelete = true
                    }
                }
                .store(in: &subscriptions)
            
        case .acceptRequestFriend:
            container.services.friendService.acceptRequestFriend(userid: userid, friendid: friendid!)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        //
                    }
                } receiveValue: { [weak self] result in
                    if result {
                        self?.isAccept = true
                    }
                }
                .store(in: &subscriptions)
        }
    }
}
