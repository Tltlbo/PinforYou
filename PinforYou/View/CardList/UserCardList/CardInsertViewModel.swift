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
        case cardAppend
    }

    @Published var companyName : String = ""
    @Published var cardName : String = ""
    @Published var isAppend: Bool = false
    
    
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: Action, userid: Int, cardNum: String = "", cardName: String = "") {
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
            
        case .cardAppend:
            container.services.userService.cardAppend(userid: userid, cardNum: cardNum, cardName: cardName)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        
                    }
                } receiveValue: { [weak self] iscomplete in
                    self?.isAppend = iscomplete
                }.store(in: &subscriptions)
        }
    }
}
