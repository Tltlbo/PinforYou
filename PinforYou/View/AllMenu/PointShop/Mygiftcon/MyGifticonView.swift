//
//  MyGifticonView.swift
//  PinforYou
//
//  Created by 박진성 on 7/28/24.
//

import SwiftUI

struct MyGifticonView: View {
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
                                MygifticonCell()
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
