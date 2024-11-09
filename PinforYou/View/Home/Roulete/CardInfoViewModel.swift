//
//  CardInfoViewModel.swift
//  PinforYou
//
//  Created by 박진성 on 11/7/24.
//

import Foundation
import Combine

class CardInfoViewModel : ObservableObject {
    enum Action {
        case getCard
    }
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var cards : [PayCardModel.PayCard] = []
    
    @Published var isFinshed : Bool = false
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action : Action, id: String, storeName: String, storeCategory: String) {
        print("iasdd: \(id)")
        switch action {
        case .getCard:
            container.services.payService.getPayRecommendCardInfo(userid: id, storeName: storeName, storeCategory: storeCategory)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        //
                    }
                    self?.isFinshed = true
                } receiveValue: { [weak self] card in
                    self?.cards = card.CardList
                }.store(in: &subscriptions)

        }
    }
    
}
