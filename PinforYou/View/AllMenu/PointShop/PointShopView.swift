//
//  PointShopView.swift
//  PinforYou
//
//  Created by 박진성 on 6/13/24.
//

import SwiftUI

enum ShopOption {
    case PointShop
    case MyGifticon
}

struct PointShopView: View {
    
    @State var selectOption : ShopOption = .PointShop
    @EnvironmentObject var container : DIContainer
    @StateObject var pointshopViewModel : PointShopViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Button  {
                            selectOption = .PointShop
                        } label: {
                            Text("구매하기")
                        }
                        .padding(.leading, UIScreen.main.bounds.width/6)
                        
                        Spacer()
                        
                        Button {
                            selectOption = .MyGifticon
                        } label: {
                            Text("내 기프티콘")
                        }
                        .padding(.trailing, UIScreen.main.bounds.width/6)
                    }
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.secondary)
                    
                    HStack {
                        Spacer()
                        Text("포인트 잔액 \(pointshopViewModel.point)")
                    }
                    .onAppear {
                        pointshopViewModel.send(action: .getUserPointInfo, userid: 1)
                    }
                    
                    switch selectOption {
                    case .PointShop:
                        PurchaseView(purchaseViewModel: .init(container: container))
                    case .MyGifticon:
                        MyGifticonView(mygifticonViewModel: .init(container: container))
                    }
                    
                    
                    
                    
                }
            }
        }
    }
}

#Preview {
    PointShopView(pointshopViewModel: .init(container: .init(services: StubService())))
}
