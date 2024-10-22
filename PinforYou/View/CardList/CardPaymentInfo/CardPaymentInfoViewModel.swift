//
//  CardPaymentInfoViewModel.swift
//  PinforYou
//
//  Created by 박진성 on 6/21/24.
//

import Foundation
import Combine

class CardPaymentInfoViewModel : ObservableObject {
    
    enum Action {
        case getPaymentInfo
    }
    
    @Published var isFinished : Bool = false
    var paymentInfo : PaymentInfo? = nil
    
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action : Action, cardid : Int = 0) {
        switch action {
        case .getPaymentInfo:
            container.services.userService.getPaymentInfo(userid: "8a2d0e95dbfc6f17f11672392b870b632377ab3c49582e311913df8fbd3548f2", cardid: cardid, year: 2024, month: 10)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        //
                    }
                    self?.isFinished = true
                } receiveValue: { [weak self] info in
                    self?.paymentInfo = info
                }
                .store(in: &subscriptions)

        }
    }
}
