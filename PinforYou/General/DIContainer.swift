//
//  DIContainer.swift
//  PinforYou
//
//  Created by 박진성 on 5/2/24.
//

import Foundation

class DIContainer : ObservableObject {
    var services : ServiceType
    
    init(services: ServiceType) {
        self.services = services
    }
}
