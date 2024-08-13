//
//  MyGifticonViewModel.swift
//  PinforYou
//
//  Created by 박진성 on 8/13/24.
//

import Foundation
import Combine

class MyGifticonViewModel : ObservableObject {
    
    enum Action {
        case getGifticonInfo
    }
    
    @Published var isFinished : Bool = false
    @Published var gifticonList : [Usergifticon.gifticon] = []
    
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action : Action, userid : Int) {
        switch action {
        case .getGifticonInfo:
            container.services.pointShopService.getUserGifticon(userid: userid)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        //
                    }
                } receiveValue: { [weak self] gifticon in
                    self?.gifticonList = gifticon.gifticonList
                    self?.isFinished = true
                }
                .store(in: &subscriptions)

        }
    }
}
