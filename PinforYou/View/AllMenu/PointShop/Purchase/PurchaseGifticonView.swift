//
//  PurchaseGifticonView.swift
//  PinforYou
//
//  Created by 박진성 on 6/13/24.
//

import SwiftUI

struct PurchaseGifticonView: View {
    var body: some View {
        VStack(alignment:.leading) {
            Image(systemName: "carrot.fill")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width, height: 300)
                .padding(.bottom, 30)
            
            Text("버거킹")
            Text("버거킹 치즈와퍼 주니어세트")
                .padding(.bottom, 10)
            
            Text("구매 후 30일 이내 사용")
            
            Text("7500P")
            
            Spacer()
            
            HStack(alignment:.center) {
                Spacer()
                Text("구매")
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width,height: 30)
            .background(Color.gray)
        }
    }
}

#Preview {
    PurchaseGifticonView()
}
