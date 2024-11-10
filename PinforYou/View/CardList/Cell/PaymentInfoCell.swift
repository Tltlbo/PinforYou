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
            VStack(alignment:.leading) {
                HStack {
                    Text("\(Info.StoreName)")
                    Spacer()
                    Text("\(Info.payAmount)")
                }
                .padding(.bottom, 5)
                
                HStack {
                    Text("\(convertToCategory(from: Info.category)) |")
                    Text("\(Info.Date)")
                }
            }
        }
        .frame(height: 60)
    }
    
    private func convertToCategory(from input: String) -> String {
        switch input {
        case "conveniencestore":
            return "편의점"
        case "supermarket":
            return "마트"
        case "restaurant":
            return "음식점"
        case "cafe":
            return "카페"
        case "hospital":
            return "병원"
        case "pharmacy":
            return "약국"
        default:
            return "기타"
        }
    }
}

#Preview {
    //PaymentInfoCell()
    Text("HELLO")
}
