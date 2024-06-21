//
//  PaymentInfoCell.swift
//  PinforYou
//
//  Created by 박진성 on 6/21/24.
//

import SwiftUI

struct PaymentInfoCell: View {
    
    var Info : PaymentInfo.Payment
    
    var body: some View {
        HStack {
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
            VStack(alignment:.leading) {
                HStack {
                    Text("\(Info.StoreName)")
                    Spacer()
                    Text("\(Info.payAmount)")
                }
                .padding(.bottom, 5)
                
                HStack {
                    Text("\(Info.category) |")
                    Text("\(Info.Date)")
                }
            }
        }
        .frame(height: 60)
    }
}

#Preview {
    //PaymentInfoCell()
    Text("HELLO")
}
