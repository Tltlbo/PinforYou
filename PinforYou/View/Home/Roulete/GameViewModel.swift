//
//  RoulleteViewModel.swift
//  PinforYou
//
//  Created by 박진성 on 11/6/24.
//

import Foundation
import SwiftUI
import Combine

class GameViewModel : ObservableObject {
    enum Action {
        case getFriendInfo
    }
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var friends : [Friend] = []
    @Published var selecedFriends: [Friend] = []
    @Published var colors: [Color] = []
    
    @Published var isFinshed : Bool = false
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action : Action) {
        guard let userid = UserID.shared.hashedID else {return}
        switch action {
        case .getFriendInfo:
            container.services.friendService.getFriendInfo(userid: userid)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        //
                    }
                    self?.isFinshed = true
                } receiveValue: { [weak self] friend in
                    friend.friendList.forEach { friend in
                        self?.friends.append(friend)
                    }
                    self?.friends = friend.friendList
                    for i in 0 ..< friend.friendList.count {
                        self?.colors.append(Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)))
                    }
                }.store(in: &subscriptions)

        }
    }
    
}
