//
//  CardPaymentInfoView.swift
//  PinforYou
//
//  Created by 박진성 on 6/20/24.
//

import SwiftUI

struct CardPaymentInfoView: View {
    
    @StateObject var cardPaymentInfoViewModel : CardPaymentInfoViewModel
    var cardID : Int
    
    var body: some View {
        
        if cardPaymentInfoViewModel.isFinished {
            NavigationStack {
                VStack {
                    ZStack {
                        
                        Color.gray
                            .frame(height: 100)
                        
                        HStack(alignment: .center) {
                            VStack(alignment:.leading) {
                                Text(cardPaymentInfoViewModel.paymentInfo?.cardName ?? "")
                                Text(cardPaymentInfoViewModel.paymentInfo?.cardNum ?? "")
                            }
                            .padding(.trailing, 60)
                            
                            Image(systemName: "creditcard")
                                .resizable()
                                .scaledToFit()
                        }
                        .frame(width: UIScreen.main.bounds.width ,height: 100)
                    }
                    .padding(.bottom, 10)
                    
                    
                    HStack {
                        Text("일자")
                            .padding(.leading, 10)
                        Text("요일")
                        Spacer()
                        Text("일일 누적 금액")
                            .padding(.trailing, 10)
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                    
                    
                    ScrollView(.vertical) {
                        VStack(spacing: 10) {
                            ForEach(cardPaymentInfoViewModel.paymentInfo!.Payments, id: \.self) { info in
                                PaymentInfoCell(Info: info)
                            }
                            
                        }
                    }
                    
                    Spacer()
                }
                .navigationTitle("6월")
            }
        }
        else {
            ProgressView()
                .onAppear {
                    cardPaymentInfoViewModel.send(action: .getPaymentInfo, cardid: cardID)
                }
        }
        
    }
}

#Preview {
    //CardPaymentInfoView()
    Text("HELLO")
}
