//
//  QRPayView.swift
//  PinforYou
//
//  Created by 박진성 on 5/20/24.
//

import SwiftUI
import UIKit

struct QRPayView: View {
    
    var card : PayCardModel.PayCard
    @StateObject var QRPayViewModel : QRPayViewModel
    
    var testImage : Image = Image("QR_test")
    
    var body: some View {
        
        if QRPayViewModel.isFinshed {
            Text(card.cardName)
            Image(uiImage: (QRPayViewModel.QRImageView.image ?? UIImage(systemName: "creditcard"))!)
        }
        else {
            ProgressView()
                .onAppear {
                    QRPayViewModel.send(action: .getQrCode)
                }
        }
        
    }
    
}



#Preview {
    QRPayView(card: .init(userID: 1, cardID: 1, cardName: "나라사랑카드", cardLastNum: "1234", discountPercent: 10, cardColor: "101010"), QRPayViewModel: .init(container: .init(services: StubService()), cardinfo: .init(userID: 1, cardID: 1, cardName: "나라사랑카드", cardLastNum: "1234", discountPercent: 10, cardColor: "101010")))
}
