//
//  PlaceInfoView.swift
//  PinforYou
//
//  Created by 박진성 on 5/14/24.
//

import SwiftUI

struct PlaceInfoView: View {
    
    @Binding var Place : PlaceModel.Place
    
    @StateObject var placeInfoViewModel : PlaceInfoViewModel
    
    @EnvironmentObject var container : DIContainer
    
    //TEST
    var testCardList : [Card] = [Card.cardStub1, Card.cardStub2, Card.cardStub3, Card.cardStub4]
    
    
    
    var body: some View {
        
        VStack(spacing: 0) {
            if placeInfoViewModel.CardList.isEmpty {
                Text("등록된 카드가 존재하지 않습니다.")
            }
            else {
                NavigationStack {
                    
                    HStack {
                        PlaceCell(Place: Place)
                        Spacer()
                    }
                    
                    ScrollView(.vertical) {
                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(height: 1)
                            
                            ForEach(placeInfoViewModel.CardList, id: \.self) { card in
                                
                                NavigationLink {
                                    QRPayView(card: card, QRPayViewModel: .init(container: container, cardinfo: card))
                                } label: {
                                    CardCell(cardInfo: card)
                                }
                                
                                
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(height:1)
                            }
                            
                        }
                        
                    }
                    HStack {
                        withBtn(option: .with)
                            .padding(.leading , 10)
                            .environmentObject(placeInfoViewModel)
                        Spacer()
                        withBtn(option: .game)
                            .padding(.trailing, 10)
                            .environmentObject(placeInfoViewModel)
                    }
                }
                .tint(.black)
            }
        }
        .padding(.top, 10)
        .onAppear {
            placeInfoViewModel.send(action: .getRecommendPayCardInfo)
        } 
    }
}

struct withBtn : View {
    enum selectOption {
        case game
        case with
    }
    
    var option : selectOption = .game
    @EnvironmentObject var container : DIContainer
    @EnvironmentObject var placeInfoViewModel: PlaceInfoViewModel
    
    var body: some View {
        NavigationLink {
            //바인딩 값에 따라 변경
            WithFriendView(StoreName:placeInfoViewModel.StoreName,StoreCategory: placeInfoViewModel.StoreCategory , gameViewModel: .init(container: container))
        } label: {
            ZStack {
                Rectangle()
                    .frame(width: 150, height: 50)
                    .clipShape(.rect(cornerRadius: 10))
                    .foregroundStyle(.blue)
                
                switch option {
                case .game:
                    Text("게임 결제")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 25))
                case .with:
                    Text("함께 결제")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 25))
                }
                
            }
        }
        
        
    }
}



#Preview {
    PlaceInfoView(Place: .constant(PlaceModel.placestub1.PlaceList[0]), placeInfoViewModel: .init(container: .init(services: StubService()), storename: "hello", storecategory: "HELLO"))
    
}
