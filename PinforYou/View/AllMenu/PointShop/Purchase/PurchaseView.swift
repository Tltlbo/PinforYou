//
//  PurchaseView.swift
//  PinforYou
//
//  Created by 박진성 on 6/13/24.
//

import SwiftUI

struct PurchaseView: View {
    
    let categoryList : [gifticonCategory] = [
        .all,
        .coffee,
        .drink,
        .food,
        .goods,
        .other
    ]
    
    @State var currentCategory : gifticonCategory = .all
    @StateObject var purchaseViewModel : PurchaseViewModel
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(categoryList, id: \.self) { category in
                        
                        Button {
                            currentCategory = category
                            print(currentCategory.rawValue)
                        } label: {
                            VStack {
                                Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
                                    .cornerRadius(15)
                                    .frame(width: 110, height: 110)
                                Text(category.rawValue)
                            }
                        }
                        
                    }
                }
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.gray)
            
            ScrollView(.vertical) {
                VStack {
                    ForEach(purchaseViewModel.gifticonList, id: \.self) {
                        gifticon in
                        PurchaseCell(gifticon: gifticon)
                    }
                }
            }
            
            Spacer()
        }
        .background {
            Color("BackgroundColor")
                .ignoresSafeArea()
        }
        .onAppear {
            purchaseViewModel.send(action: .getGifticonInfo, category: currentCategory)
        }
        .onChange(of: currentCategory) { newCategory in
            print(currentCategory)
                purchaseViewModel.send(action: .getGifticonInfo, category: newCategory)
        }
    }
}

#Preview {
    PurchaseView(purchaseViewModel: .init(container: .init(services: StubService())))
}
