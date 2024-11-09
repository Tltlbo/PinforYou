//
//  MeetingListViewModel.swift
//  PinforYou
//
//  Created by 김성훈 on 7/15/24.
//

import Foundation
import Combine

class MeetingListViewModel : ObservableObject {
    
    enum Action {
        case getCardInfo
    }
    
    @Published var isFinished : Bool = false
    var CardList : [CardInfo.Carda] = []
    
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action : Action) {
        switch action {
        case .getCardInfo:
            container.services.userService.getCardInfo(id: "8a2d0e95dbfc6f17f11672392b870b632377ab3c49582e311913df8fbd3548f2")
                .sink { [weak self] completion in
                    if case .failure = completion {
                        //
                    }
                    self?.isFinished = true
                } receiveValue: { [weak self] card in
                    self?.CardList = card.CardList
                }
                .store(in: &subscriptions)

        }
    }
}
