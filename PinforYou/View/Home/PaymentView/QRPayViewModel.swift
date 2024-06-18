//
//  QRPayViewModel.swift
//  PinforYou
//
//  Created by 박진성 on 6/18/24.
//

import Foundation
import Combine

class QRPayViewModel : ObservableObject {
    enum Action {
        case getQrCode
    }
    
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action : Action) {
        switch action {
        case .getQrCode:
            container.services.payService.getCardQrCode()
                .sink { [weak self] completion in
                    if case .failure = completion {
                        //
                    }
                } receiveValue: { [weak self] image in
                    //
                }.store(in: &subscriptions)

        }
    }
}
