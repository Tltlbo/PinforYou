//
//  PurchaseView.swift
//  PinforYou
//
//  Created by 박진성 on 6/13/24.
//

import SwiftUI

enum gifticonCategory {
    case drink
    case Food
    case Voucher
}


struct PurchaseView: View {
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0 ..< 3, id: \.self) { _ in
                        
                        Button {
                            //State 써서 값 바꾸기
                        } label: {
                            VStack {
                                Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
                                    .cornerRadius(15)
                                    .frame(width: 110, height: 110)
                                Text("이름")
                            }
                        }
                        
                    }
                }
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.gray)
            
            ScrollView(.vertical) {
                VStack {
                    ForEach(0 ..< 10, id: \.self) {
                        _ in
                        PurchaseCell()
                    }
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    PurchaseView()
}
