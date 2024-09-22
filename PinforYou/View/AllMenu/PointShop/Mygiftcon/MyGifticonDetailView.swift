//
//  MyGifticonDetailView.swift
//  PinforYou
//
//  Created by 박진성 on 7/28/24.
//

import SwiftUI
import Kingfisher

struct MyGifticonDetailView: View {
    
    @Binding var isScreenFullDetailView : Bool
    let gifticon : Usergifticon.gifticon
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    KFImage(URL(string: gifticon.imageURL))
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height: 300)
                    
                    VStack(alignment: .leading) {
                        Text(gifticon.place)
                            .foregroundColor(.secondary)
                        Text(gifticon.giftName)
                    }
                    .padding(.vertical, 25)
                    
                    KFImage(URL(string: gifticon.barcodeURL))
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
            }), trailing: Button(action: {
                <#code#>
            }, label: {
                Image(systemName: "trash")
            }))
        }
    }
}

#Preview {
    Text("HELLo")
}
