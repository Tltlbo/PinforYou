//
//  RecommendCardViewModel.swift
//  PinforYou
//
//  Created by 박진성 on 8/17/24.
//

import Foundation
import Combine

class RecommendCardViewModel : ObservableObject {
    
    enum Action {
        case getRecommendCard
    }

    @Published var category : String = ""
    @Published var name : String = ""
    @Published var image_url : String = ""
    @Published var benefits : [String] = []
    
    
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: Action) {
        switch action {
        
        case .getRecommendCard:
            container.services.userService.getRecommendCardInfo(userid: 1)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        
                    }
                } receiveValue: { [weak self] card in
                    self?.category = card.category
                    self?.name = card.name
                    self?.image_url = card.image_URL
                    self?.benefits = card.benefits
                }.store(in: &subscriptions)
  
        }
    }
}
