//
//  MyGifticonView.swift
//  PinforYou
//
//  Created by 박진성 on 7/28/24.
//

import SwiftUI

struct MyGifticonView: View {
    @State private var isScreenFullDetailView : Bool = false
    @State private var selectedGifticon: Usergifticon.gifticon?
    @StateObject var mygifticonViewModel : MyGifticonViewModel
    
    var body: some View {
    
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack {
                    ScrollView(.vertical) {
                        VStack {
                            ForEach(mygifticonViewModel.gifticonList, id: \.self) { gifticon in
                        
                                Button {
                                    selectedGifticon = gifticon
                                } label: {
                                    MygifticonCell(gifticon: gifticon)
                                }
                                .fullScreenCover(item: $selectedGifticon) { gifticon in
                                    MyGifticonDetailView(isScreenFullDetailView: $isScreenFullDetailView, gifticon: gifticon)
                                        .environmentObject(mygifticonViewModel)
                                }

                            }
                        }
                    }
                }
            }
            
        }
        .onAppear {
            mygifticonViewModel.send(action: .getGifticonInfo, userid: 1, itemid: nil)
        }
    }
}

#Preview {
    MyGifticonView(mygifticonViewModel: .init(container: .init(services: StubService())))
}
