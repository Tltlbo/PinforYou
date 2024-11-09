//
//  MyGifticonDetailView.swift
//  PinforYou
//
//  Created by 박진성 on 7/28/24.
//

import SwiftUI
import Kingfisher

struct MyGifticonDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var mygifticonViewModel : MyGifticonViewModel
    let gifticon : Usergifticon.gifticon
    @State var isDelete: Bool = false
    
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
                dismiss()
            }, label: {
                Image(systemName: "arrow.backward")
                    .foregroundColor(.black)
            }), trailing: Button(action: {
                isDelete = true
            }, label: {
                Image(systemName: "trash")
            })
                .alert(isPresented: $isDelete) {
                    Alert(title: Text("삭제하시겠습니까?"), message: Text("\(gifticon.giftName)이 삭제됩니다."), primaryButton: .destructive(Text("삭제"), action: {
                        mygifticonViewModel.send(action: .deleteGifticon, userid: nil, itemid: gifticon.list_id)
                    }), secondaryButton: .cancel(Text("취소"), action: {
                        //
                    }))
                }
            )
        }
        .onChange(of: mygifticonViewModel.isDelete) { isDelete in
            if isDelete {
                mygifticonViewModel.isDelete = false
                dismiss()
            }
        }
    }
}

#Preview {
    Text("HELLo")
}
