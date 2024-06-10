//
//  CardListView.swift
//  PinforYou
//
//  Created by 박진성 on 5/30/24.
//

import SwiftUI

struct CardListView: View {
    
    var testCardList : [Card] = [Card.cardStub1, Card.cardStub2, Card.cardStub3, Card.cardStub4]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        //
                    } label: {
                        Text("추가")
                            .font(.system(size: 15))
                    }
                    .padding(.trailing, 5)
                    
                    Button {
                        //
                    } label: {
                        Text("관리")
                            .font(.system(size: 15))
                    }
                    .padding(.trailing, 10)
                }
                
                ScrollView(.vertical) {
                    VStack(spacing: 10) {
                        ForEach(testCardList, id: \.self) { card in
                            NavigationLink {
                                //
                            } label: {
                                MyCardCell()
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
}

#Preview {
    CardListView()
}
