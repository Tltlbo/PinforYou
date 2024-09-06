//
//  CardListViewModel.swift
//  PinforYou
//
//  Created by 박진성 on 6/23/24.
//

import Foundation
import Combine

class CardListViewModel : ObservableObject {
    
    enum Action {
        case getCardInfo
        case deleteCard
    }
    
    @Published var isFinished : Bool = false
    @Published var isDeleted : Bool = false
    @Published var CardList : [CardInfo.Carda] = []
    
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action : Action, userid: Int = 1, cardid: Int = 1) {
        switch action {
        case .getCardInfo:
            container.services.userService.getCardInfo()
                .sink { [weak self] completion in
                    if case .failure = completion {
                        //
                    }
                    self?.isFinished = true
                } receiveValue: { [weak self] card in
                    self?.CardList = card.CardList
                }
                .store(in: &subscriptions)
        case .deleteCard:
            container.services.userService.cardDelete(userid: userid, cardid: cardid)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        //
                    }
                } receiveValue: { [weak self] isDelete in
                    self?.isDeleted = isDelete
                }
                .store(in: &subscriptions)
        }
    }
}

//MARK: 리스트 삭제 추가 관련 메서드
extension CardListViewModel {
    func cardDelete(card : CardInfo.Carda) {
        self.CardList = CardList.filter {mycard in
            mycard != card
            // TODO: 지웠다는 API 호출해서 작업 성공에 대한 처리 필요
        }
    }
    
    func inert(cardName: String, cardNum : String) {
        let card = CardInfo.Carda(cardID: Int.random(in: 0 ... 255), cardName: cardName, cardNum: cardNum)
        
        self.CardList.append(card)
    }
}
