//
//  PurchaseViewModel.swift
//  PinforYou
//
//  Created by 박진성 on 8/4/24.
//

import Foundation
import Combine

class PurchaseViewModel : ObservableObject {
    
    enum Action {
        case getGifticonInfo
    }
    
    @Published var isFinished : Bool = false
    @Published var gifticonList : [PointShopGifticon] = []
    
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action : Action, category : gifticonCategory) {
        switch action {
        case .getGifticonInfo:
            container.services.pointShopService.getGifticonInfo(category: category)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        //
                    }
                } receiveValue: { [weak self] gifticon in
                    var list : [PointShopGifticon] = []
                    for i in gifticon {
                        print(i.category)
                        list.append(i)
                    }
                    self?.gifticonList = list
                    self?.isFinished = true
                }
                .store(in: &subscriptions)

        }
    }
}
