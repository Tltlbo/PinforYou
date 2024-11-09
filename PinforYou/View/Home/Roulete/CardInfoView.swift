//
//  CardInfoView.swift
//  PinforYou
//
//  Created by 김성훈 on 9/2/24.
//

import SwiftUI
import Combine
import Kingfisher

struct CardInfoView: View {
    var selectedFriend: Friend  // RouletteView에서 전달 받은 이름
    var StoreName : String
    var StoreCategory : String
    @EnvironmentObject var container: DIContainer
    @StateObject var cardInfoViewModel: CardInfoViewModel
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("""
                             \(selectedFriend.name)님이 등록한 카드 중
                             이 카드로 결제하는 게
                             가장 좋아요!
                             
                             """
                    )
                    .font(.title)
                    .padding()
                    
                    KFImage(URL(string: cardInfoViewModel.cards.first?.card_image_url ?? ""))
                        .resizable()
                        .scaledToFit()
                        .frame(width:300, height: 200)
                        .rotationEffect(.degrees(-90.0))
                        .padding()
                    
                    
                    Text(cardInfoViewModel.cards.first?.cardName ?? "")
                        .font(.title2)
                        .padding(.bottom, 1)
                    
                    VStack(alignment: .leading) {
                        Text("• \(String(format: "%.1f", cardInfoViewModel.cards.first?.discountPercent ?? 0)) % 할인")
                    }
                    .font(.headline)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    
                    Spacer()
                }
                .navigationBarBackButtonHidden()
            }
            .padding()
        }
        .onAppear {
            cardInfoViewModel.send(action: .getCard, id: selectedFriend.friendID, storeName: StoreName, storeCategory: StoreCategory)
        }
    }
}

