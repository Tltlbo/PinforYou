//
//  CardInsertViewViewModel.swift
//  PinforYou
//
//  Created by 박진성 on 8/17/24.
//

import Foundation
import Combine

class CardInsertViewModel : ObservableObject {
    
    enum Action {
        case cardValidate
    }

    @Published var companyName : String = ""
    @Published var cardName : String = ""
    
    
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: Action, cardNum: String) {
        switch action {
        
        case .cardValidate:
            container.services.userService.cardValidation(cardNum: cardNum)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        
                    }
                } receiveValue: { [weak self] validate in
                    self?.companyName = validate.company
                    self?.cardName = validate.card
                    
                }.store(in: &subscriptions)
  
        }
    }
}
