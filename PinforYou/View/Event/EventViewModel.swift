//
//  EventViewModel.swift
//  PinforYou
//
//  Created by 박진성 on 8/12/24.
//

import Foundation
import Combine

class EventViewModel : ObservableObject {
    
    enum Action {
        case getEventInfo
    }
    
    @Published var isFinished : Bool = false
    @Published var paymentEventList : [String] = []
    @Published var issuanceEventList : [String] = []
    
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action : Action) {
        switch action {
        case .getEventInfo:
            container.services.eventService.getEventInfo()
                .sink { [weak self] completion in
                    if case .failure = completion {
                        //
                    }
                } receiveValue: { [weak self] event in
                    self?.isFinished = true
                    self?.issuanceEventList = event.issuanceEvent
                    self?.paymentEventList = event.paymentEvent
                }
                .store(in: &subscriptions)

        }
    }
}
