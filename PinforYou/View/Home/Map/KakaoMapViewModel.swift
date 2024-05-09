//
//  KakaoMapViewModel.swift
//  PinforYou
//
//  Created by 박진성 on 5/8/24.
//

import Foundation
import Combine

class KakaoMapViewModel : ObservableObject {
    
    enum Action {
        case getLocation
    }
    
    @Published var Location : Location?
    @Published var isFinished : Bool = false
    
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action : Action) {
        switch action {
        case .getLocation:
            container.services.locationService.getLocation()
                .sink { [weak self] completion in
                    if case .failure = completion {
                    
                    }
                } receiveValue: { [weak self] Location in
                    self?.Location = Location
                    self?.isFinished = true
                    print("되고 있긴 함?")
                    print("HELLO \(Location.latitude), \(Location.longitude)")
                    
                }.store(in: &subscriptions)

        }
    }
    
}
