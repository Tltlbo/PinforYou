//
//  CardPaymentInfoView.swift
//  PinforYou
//
//  Created by 박진성 on 6/20/24.
//

import SwiftUI

struct CardPaymentInfoView: View {
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    
                    Color.gray
                        .frame(height: 100)
                    
                    HStack(alignment: .center) {
                        VStack(alignment:.leading) {
                            Text("The BEST-F")
                            Text("1736-6684-3090-2003")
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
                
                HStack {
                    Text("26")
                        .padding(.leading, 10)
                    Text("월요일")
                    Spacer()
                    Text("50000")
                        .padding(.trailing, 10)
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray)
                
                HStack {
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                    VStack(alignment:.leading) {
                        HStack {
                            Text("장군제육")
                            Spacer()
                            Text("24000")
                        }
                        .padding(.bottom, 5)
                        
                        HStack {
                            Text("식당 |")
                            Text("16:27")
                        }
                    }
                }
                .frame(height: 60)
                
                Spacer()
            }
            .navigationTitle("6월")
        }
    }
}

#Preview {
    CardPaymentInfoView()
}
