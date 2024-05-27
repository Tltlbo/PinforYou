//
//  QRPayView.swift
//  PinforYou
//
//  Created by 박진성 on 5/20/24.
//

import SwiftUI

struct QRPayView: View {
    
    var card : Card
    
    var testImage : Image = Image("QR_test")
    
    var body: some View {
        Text(card.cardName)
        testImage
            .resizable()
            .scaledToFit()
            .frame(width: 250,height: 250)
    }
}

#Preview {
    QRPayView(card: Card.cardStub1)
}
