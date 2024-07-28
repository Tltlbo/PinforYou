//
//  CardDeleteView.swift
//  PinforYou
//
//  Created by 박진성 on 7/28/24.
//

import SwiftUI

struct CardDeleteView: View {
    
    @EnvironmentObject var cardlistViewModel : CardListViewModel
    @EnvironmentObject var container : DIContainer
    
    var body: some View {
        NavigationStack {
            VStack {
                
                ScrollView(.vertical) {
                    VStack(spacing: 10) {
                        ForEach(cardlistViewModel.CardList, id: \.self) { card in
                            CardDeleteCell(card: card)
                            
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
    CardDeleteView()
}
