//
//  CardListView.swift
//  PinforYou
//
//  Created by 박진성 on 5/30/24.
//

import SwiftUI

struct CardListView: View {
    
    @StateObject var cardlistViewModel : CardListViewModel
    @EnvironmentObject var container : DIContainer
    
    @State var isTouched : Bool = false
    
    
    var testCardList : [Card] = [Card.cardStub1, Card.cardStub2, Card.cardStub3, Card.cardStub4]
    
    var body: some View {
        
        if cardlistViewModel.isFinished {
            NavigationStack {
                VStack {
                    HStack {
                        Spacer()
                        
                        Button {
                            isTouched = true
                        } label: {
                            Text("추가")
                                .font(.system(size: 15))
                        }
                        .padding(.trailing, 5)
                        .fullScreenCover(isPresented: $isTouched) {
                            CardInsertView(cardInsertViewModel: .init(container: container))
                                .environmentObject(cardlistViewModel)
                        }


                        
                        NavigationLink{
                            CardDeleteView()
                                .environmentObject(cardlistViewModel)
                        } label: {
                            Text("관리")
                                .font(.system(size: 15))
                        }
                        .padding(.trailing, 10)
                    }
                    
                    ScrollView(.vertical) {
                        VStack(spacing: 10) {
                            ForEach(cardlistViewModel.CardList, id: \.self) { card in
                                NavigationLink {
                                    CardPaymentInfoView(cardPaymentInfoViewModel: .init(container: container), cardID: card.cardID)
                                } label: {
                                    MyCardCell(card: card)
                                }

                            }
                            
                        }
                    }
                    
                    Spacer()
                }
                .background {
                    Color("BackgroundColor")
                        .ignoresSafeArea()
                }
            }
            
        }
        else {
            ProgressView()
                .onAppear {
                    cardlistViewModel.send(action: .getCardInfo)
                }
        }
        
        
    }
}

#Preview {
    CardListView(cardlistViewModel: .init(container: .init(services: StubService())))
}
