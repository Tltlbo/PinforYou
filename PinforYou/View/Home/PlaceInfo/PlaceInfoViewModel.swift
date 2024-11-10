//
//  PlaceInfoViewModel.swift
//  PinforYou
//
//  Created by 박진성 on 6/14/24.
//

import Foundation
import Combine

class PlaceInfoViewModel : ObservableObject {
    
    enum Action {
        case getRecommendPayCardInfo
    }
    
    
    @Published var isFinished : Bool = false
    var CardList : [PayCardModel.PayCard] = []
    
    private var container : DIContainer
    var StoreName : String
    var StoreCategory : String
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer, storename : String, storecategory : String) {
        self.container = container
        self.StoreName = storename
        self.StoreCategory = PlaceInfoViewModel.convertToCategory(from: storecategory)
    }
    
    func send(action : Action, storeName: String, storeCategory: String) {
        guard let userid = UserID.shared.hashedID else {return}
        switch action {
        case .getRecommendPayCardInfo:
            container.services.payService.getPayRecommendCardInfo(userid: userid, storeName: storeName, storeCategory: storeCategory)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        //
                    }
                } receiveValue: { [weak self] card in
                    self?.isFinished = true
                    self?.CardList = card.CardList
                }.store(in: &subscriptions)
        }
    }
    
    static private func convertToCategory(from input: String) -> String {
        switch input {
        case "편의점":
            return "conveniencestore"
        case "마트":
            return "supermarket"
        case "음식점":
            return "restaurant"
        case "카페":
            return "cafe"
        case "병원":
            return "hospital"
        case "약국":
            return "pharmacy"
        default:
            return "other"
        }
    }
}
