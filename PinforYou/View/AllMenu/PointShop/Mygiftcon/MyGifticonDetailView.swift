//
//  MyGifticonDetailView.swift
//  PinforYou
//
//  Created by 박진성 on 7/28/24.
//

import SwiftUI

struct MyGifticonDetailView: View {
    
    @Binding var isScreenFullDetailView : Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Image(systemName: "creditcard")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height: 300)
                    
                    VStack(alignment: .leading) {
                        Text("투썸플레이스")
                            .foregroundColor(.secondary)
                        Text("투썸플레이스 3만원권")
                    }
                    .padding(.vertical, 25)
                    
                    Image(systemName: "creditcard")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height: 100)
                    
                    Spacer()
                    
                    Button {
                        //
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: UIScreen.main.bounds.width, height: 70)
                                .foregroundColor(.gray)
                            Text("이미지로 저장")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                        }
                    }

                }
            }
            .navigationBarItems(leading: Button(action: {
                isScreenFullDetailView = false
            }, label: {
                Image(systemName: "arrow.backward")
                    .foregroundColor(.white)
            }))
        }
    }
}

#Preview {
    Text("HELLo")
}
