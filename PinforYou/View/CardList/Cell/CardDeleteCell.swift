//
//  CardDeleteCell.swift
//  PinforYou
//
//  Created by 박진성 on 7/28/24.
//

import SwiftUI

struct CardDeleteCell: View {
    
    @EnvironmentObject var cardlistViewModel : CardListViewModel
    @EnvironmentObject var container : DIContainer
    
    @State var isDelete : Bool = false
    
    let card : CardInfo.Carda
    
    var body: some View {
        HStack {
            Image(systemName: "creditcard")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .padding(.horizontal, 10)
                
            
            VStack(alignment:.leading) {
                HStack {
                    VStack(alignment:.leading) {
                        Text(card.cardName)
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                            .padding(.bottom, 25)
                        Text(card.cardNum)
                            .font(.system(size: 15))
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                    
                    Button {
                        isDelete = true
                    } label: {
                        Text("삭제")
                            .font(.system(size: 20))
                    }
                    .padding(.trailing, 10)
                    .alert(isPresented: $isDelete) {
                        Alert(title: Text("삭제하시겠습니까?"), message: Text("\(card.cardName)이 삭제됩니다."), primaryButton: .destructive(Text("삭제"), action: {
                            cardlistViewModel.cardDelete(card: card)
                            cardlistViewModel.send(action: .deleteCard, userid: "8a2d0e95dbfc6f17f11672392b870b632377ab3c49582e311913df8fbd3548f2", cardid: card.cardID)
                        }), secondaryButton: .cancel(Text("취소"), action: {
                            //
                        }))
                    }

                }
                
                
                
            }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.size.width - 20)
        .background {
            Color("CellBackgroundColor")
        }
        .clipShape(.rect(cornerRadius: 20))
        
    }
}

#Preview {
    CardDeleteCell(card: .init(cardID: 1, cardName: "test", cardNum: "test"))
}
