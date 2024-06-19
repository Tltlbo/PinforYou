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
    
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    
    func send(action : Action) {
        switch action {
        case .storePayment:
            container.services.ownerPayService.storePaymentInfo()
                .sink { [weak self] completion in
                    if case .failure = completion {
                        //
                    }
                } receiveValue: { [weak self] result in
                    //
                }

        }
    }
}
