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
        
        VStack {
            HStack {
                PlaceCell(Place: Place)
                Spacer()
            }
            
            Rectangle()
                .fill(Color.blue)
                .frame(height: 2)
                .padding(.bottom, 0)
            
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 1)
                    
                    ForEach(testCardList, id: \.self) { card in
                        CardCell()
                        
                        Rectangle()
                            .fill(Color.white)
                            .frame(height:1)
                    }
                    
                }
            }
            
            
            Spacer()
        }
    }
}



#Preview {
    PlaceInfoView(Place: .constant(PlaceModel.placestub1.PlaceList[0]))
        
}
