//
//  ScannerViewModel.swift
//  PinforYou
//
//  Created by 박진성 on 6/19/24.
//

import Foundation
import Combine
import Alamofire

class ScannerViewModel : ObservableObject {
    
    enum Action {
        case storePayment
    }
    
    @Published var isFinshed : Bool = false
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    
    func send(action : Action, amount : Int, cardid : Int, hashed: String, storeName: String, category: String) {
        switch action {
        case .storePayment:
            container.services.ownerPayService.storePaymentInfo(cardid: cardid, amount: amount, userid: hashed, category: category, storeName: storeName)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        //
                    }
                    self?.isFinshed = true
                } receiveValue: { [weak self] result in
                    print(result)
                }
                .store(in: &subscriptions)

        }
    }
}
