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



