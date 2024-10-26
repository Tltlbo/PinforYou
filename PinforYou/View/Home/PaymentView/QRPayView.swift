//
//  QRPayView.swift
//  PinforYou
//
//  Created by 박진성 on 5/20/24.
//

import SwiftUI
import UIKit
import Kingfisher

struct QRPayView: View {
    
    var card : PayCardModel.PayCard
    @StateObject var QRPayViewModel : QRPayViewModel
    
    var body: some View {
        
        if QRPayViewModel.isFinshed {
            if let url = QRPayViewModel.QRImage_url {
                Text(card.cardName)
                KFImage(URL(string: url))
            }
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
    QRPayView(card: .init(userID: "1", cardID: 1, cardName: "나라사랑카드", cardLastNum: "1234", discountPercent: 10, cardColor: "101010", description: ""), QRPayViewModel: .init(container: .init(services: StubService()), cardinfo: .init(userID: "1", cardID: 1, cardName: "나라사랑카드", cardLastNum: "1234", discountPercent: 10, cardColor: "101010", description: "")))
}
