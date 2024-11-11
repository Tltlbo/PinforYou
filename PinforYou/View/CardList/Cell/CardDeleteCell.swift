//
//  CardDeleteCell.swift
//  PinforYou
//
//  Created by 박진성 on 7/28/24.
//

import SwiftUI
import Kingfisher

struct CardDeleteCell: View {
    
    @EnvironmentObject var cardlistViewModel : CardListViewModel
    @EnvironmentObject var container : DIContainer
    
    @State var isDelete : Bool = false
    
    let card : CardInfo.Carda
    
    var body: some View {
        HStack {
            
            KFImage(URL(string: card.card_image_url))
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 100)
                .padding(.horizontal, 30)
                .rotationEffect(.degrees(-90.0))
            
            VStack(alignment:.leading) {
                HStack {
                    VStack(alignment:.leading) {
                        Text(card.cardName)
                            .font(.system(size: 20))
                            .foregroundStyle(.black)
                            .padding(.bottom, 25)
                        Text(card.cardNum)
                            .font(.system(size: 15))
                            .foregroundStyle(.black)
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
                            cardlistViewModel.send(action: .deleteCard, cardid: card.cardID)
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
    CardDeleteCell(card: .init(cardID: 1, cardName: "test", cardNum: "test", card_image_url: ""))
}
