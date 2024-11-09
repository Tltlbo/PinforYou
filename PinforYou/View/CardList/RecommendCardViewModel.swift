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
        guard let userid = UserID.shared.hashedID else {return}
        switch action {
        case .getRecommendCard:
            container.services.userService.getRecommendCardInfo(userid: userid)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        
                    }
                } receiveValue: { [weak self] card in
                    self?.category = (self?.convertToCategory(from: card.category))!
                    self?.name = card.name
                    self?.image_url = card.image_URL
                    self?.benefits = card.benefits
                }.store(in: &subscriptions)
  
        }
    }
    
    private func convertToCategory(from input: String) -> String {
        switch input {
        case "conveniencestore":
            return "편의점"
        case "supermarket":
            return "마트"
        case "restaurant":
            return "음식점"
        case "cafe":
            return "카페"
        case "hospital":
            return "병원"
        case "pharmacy":
            return "약국"
        default:
            return "기타"
        }
    }
}
