//
//  QRPayView.swift
//  PinforYou
//
//  Created by 박진성 on 5/20/24.
//

import SwiftUI

struct QRPayView: View {
    
    var card : Card
    
    var body: some View {
        Text(card.cardName)
    }
}

#Preview {
    QRPayView(card: Card.cardStub1)
}
