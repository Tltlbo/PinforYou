//
//  MyGifticonView.swift
//  PinforYou
//
//  Created by 박진성 on 7/28/24.
//

import SwiftUI

struct MyGifticonView: View {
    @State private var isScreenFullDetailView : Bool = false
    var body: some View {
    
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack {
                    ScrollView(.vertical) {
                        VStack {
                            ForEach(0 ..< 10, id: \.self) {
                                _ in
                                Button {
                                    isScreenFullDetailView = true
                                } label: {
                                    MygifticonCell()
                                }
                                .fullScreenCover(isPresented: $isScreenFullDetailView) {
                                    MyGifticonDetailView(isScreenFullDetailView: $isScreenFullDetailView)
                                }

                            }
                        }
                    }
                }
            }
            
        }
    }
}

#Preview {
    MyGifticonView()
}
