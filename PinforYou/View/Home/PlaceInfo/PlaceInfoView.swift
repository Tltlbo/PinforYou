//
//  PlaceInfoView.swift
//  PinforYou
//
//  Created by 박진성 on 5/14/24.
//

import SwiftUI

struct PlaceInfoView: View {
    
    @Binding var Place : PlaceModel.Place
    
    //TEST
    var testCardList : [Card] = [Card.cardStub1, Card.cardStub2, Card.cardStub3, Card.cardStub4]
    
    
    var body: some View {
        
        VStack(spacing: 0){
            
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
                        
                        ForEach(testCardList, id: \.self) { card in
                            
                            NavigationLink {
                                QRPayView(card: card)
                            } label: {
                                CardCell()
                            }

                            
                            Rectangle()
                                .fill(Color.white)
                                .frame(height:1)
                        }
                        
                    }
                    
                }
            }
            .tint(.black)
        }
        .padding(.top, 10)
        
        HStack {
            withBtn(option: .with)
                .padding(.leading , 10)
            Spacer()
            withBtn(option: .game)
                .padding(.trailing, 10)
        }
    }
}

struct withBtn : View {
    
    enum selectOption {
        case game
        case with
    }
    
    var option : selectOption = .game
    
    var body: some View {
        Button {
            //바인딩 값에 따라 변경
        } label: {
            ZStack {
                Rectangle()
                    .frame(width: 150, height: 50)
                    .clipShape(.rect(cornerRadius: 10))
                
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
    PlaceInfoView(Place: .constant(PlaceModel.placestub1.PlaceList[0]))
        
}
