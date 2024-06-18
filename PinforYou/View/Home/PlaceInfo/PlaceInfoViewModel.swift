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
    private var userID : Int
    private var StoreName : String
    private var StoreCategory : String
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer, userid : Int, storename : String, storecategory : String) {
        self.container = container
        self.userID = userid
        self.StoreName = storename
        self.StoreCategory = storecategory
    }
    
    func send(action : Action) {
        switch action {
        case .getRecommendPayCardInfo:
            container.services.payService.getPayRecommendCardInfo(userid: userID, storeName: StoreName, storeCategory: StoreCategory)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        //
                    }
                } receiveValue: { [weak self] card in
                    self?.isFinished = true
                    print(card)
                    
                }.store(in: &subscriptions)

        }
    }
}
