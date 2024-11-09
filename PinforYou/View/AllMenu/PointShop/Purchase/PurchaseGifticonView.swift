//
//  PurchaseGifticonView.swift
//  PinforYou
//
//  Created by 박진성 on 6/13/24.
//

import SwiftUI
import Kingfisher

struct PurchaseGifticonView: View {
    
    @Environment(\.dismiss) private var dismiss
    let gifticon: PointShopGifticon.Gifticon
    @EnvironmentObject var purchaseViewModel : PurchaseViewModel
    @State var isPurchase: Bool = false
    
    var body: some View {
        
        NavigationView {
            VStack(alignment:.leading) {
                
                KFImage(URL(string: gifticon.imageURL))
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width, height: 300)
                    .padding(.bottom, 30)
                
                
                Text(gifticon.place)
                Text(gifticon.giftName)
                    .padding(.bottom, 10)
                
                Text("구매 후 30일 이내 사용")
                
                Text("\(gifticon.price)P")
                
                Spacer()
                
                Button {
                    isPurchase = true
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width, height: 70)
                            .foregroundColor(.gray)
                        Text("구매")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    }
                }
                .alert(isPresented: $isPurchase) {
                    Alert(title: Text("구매하시겠습니까?"), message: Text("\(gifticon.giftName)을 구매합니다."), primaryButton: .destructive(Text("구매"), action: {
                        purchaseViewModel.send(action: .purchaseGifticon, category: nil, itemid: gifticon.id)
                    }), secondaryButton: .cancel(Text("취소"), action: {
                        //
                    }))
                }
            }
            .navigationBarItems(leading: Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "arrow.backward")
                    .foregroundColor(.white)
            }))
            .onChange(of: purchaseViewModel.isPurchase) { _ in
                if purchaseViewModel.isPurchase {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
//    PurchaseGifticonView(isScreenFullDetailView: false, gifticon: .init(id: 1, giftName: "", place: "", price: 200, category: "", imageURL: ""))
}
