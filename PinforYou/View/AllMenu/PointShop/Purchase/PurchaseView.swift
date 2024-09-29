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
    @State private var selectedGifticon: PointShopGifticon.Gifticon?
    @StateObject var purchaseViewModel : PurchaseViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(categoryList, id: \.self) { category in
                            
                            Button {
                                currentCategory = category
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
                            
                            Button {
                                selectedGifticon = gifticon
                            } label: {
                                PurchaseCell(gifticon: gifticon)
                            }
                            .fullScreenCover(item: $selectedGifticon) { gifticon in
                                PurchaseGifticonView(gifticon: gifticon)
                                    .environmentObject(purchaseViewModel)
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
            .onAppear {
                purchaseViewModel.send(action: .getGifticonInfo, category: currentCategory, itemid: nil)
            }
            .onChange(of: currentCategory) { newCategory in
                purchaseViewModel.send(action: .getGifticonInfo, category: newCategory, itemid: nil)
            }
        }
    }
}

#Preview {
    PurchaseView(purchaseViewModel: .init(container: .init(services: StubService())))
}
