//
//  SignupViewModel.swift
//  PinforYou
//
//  Created by 박진성 on 10/13/24.
//

import Foundation
import Combine

class SignupEmailViewModel: ObservableObject {
    enum action {
        case verifyEmail
    }
    
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: action) {
        
        switch action {
        case .verifyEmail:
            return
        }
        
    }
}
