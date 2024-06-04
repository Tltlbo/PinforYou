//
//  EventView.swift
//  PinforYou
//
//  Created by 박진성 on 5/31/24.
//

import SwiftUI

struct EventView: View {
    var body: some View {
        
        
        VStack(alignment:.leading) {
            Section(header: Text("카드 이벤트").font(.title)) {
                ScrollView(.horizontal) {
                    HStack(spacing:0) {
                        ForEach(0 ..< 100) {_ in
                            Color(red: .random(in: 0...1),
                                  green: .random(in: 0...1),
                                  blue: .random(in: 0...1))
                                .frame(width: UIScreen.main.bounds.width, height:  200)
                        }
                    }
                }
                .onAppear {
                    UIScrollView.appearance().isPagingEnabled = true
                }
                .scrollIndicators(.hidden)
            }
            
            
            Section(header: Text("결제 이벤트").font(.title)) {
                ScrollView(.horizontal) {
                    HStack(spacing:0) {
                        ForEach(0 ..< 100) {_ in
                            Color(red: .random(in: 0...1),
                                  green: .random(in: 0...1),
                                  blue: .random(in: 0...1))
                                .frame(width: UIScreen.main.bounds.width, height:  200)
                        }
                    }
                }
                .onAppear {
                    UIScrollView.appearance().isPagingEnabled = true
                }
                .scrollIndicators(.hidden)
            }
        }
        .background {
            Color("BackgroundColor")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    EventView()
}
