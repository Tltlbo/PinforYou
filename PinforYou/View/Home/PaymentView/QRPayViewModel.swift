//
//  QRPayViewModel.swift
//  PinforYou
//
//  Created by 박진성 on 6/18/24.
//

import Foundation
import Combine
import UIKit
import SwiftUI

class QRPayViewModel : ObservableObject {
    enum Action {
        case getQrCode
    }
    
    private var cardInfo : PayCardModel.PayCard
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var QRImage_url : String? = nil
    
    @Published var isFinshed : Bool = false
    
    init(container: DIContainer, cardinfo : PayCardModel.PayCard) {
        self.container = container
        self.cardInfo = cardinfo
    }
    
    func send(action : Action) {
        switch action {
        case .getQrCode:
            container.services.payService.getCardQrCode(cardid: cardInfo.cardID)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        //
                    }
                    self?.isFinshed = true
                } receiveValue: { [weak self] url in
                    self?.QRImage_url = url
                }.store(in: &subscriptions)

        }
    }
    
}
