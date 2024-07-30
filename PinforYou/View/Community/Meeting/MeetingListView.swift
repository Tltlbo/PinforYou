//
//  MeetingListView.swift
//  PinforYou
//
//  Created by 박진성 on 5/31/24.
//

import SwiftUI

struct MeetingListView: View {
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        //
                    } label: {
                        Text("추가")
                    }
                    
                    Button {
                        //
                    } label: {
                        Text("관리")
                    }
                    .padding(.trailing, 10)
                }
                Rectangle()
                    .frame(height: 1)
                
                ScrollView {
                    ForEach(0 ..< 19) {_ in
                        HStack {
                            Text("모임")
                                .foregroundStyle(.white)
                ScrollView(.vertical) {
                    
                    VStack(spacing: 10) {
                        ForEach(0 ..< 19, id: \.self) { _ in
                            NavigationLink {
                                MeetingCardPaymentInfoView()
                            } label: {
                                MeetingCell()
                            }

                            
                        }
                        .frame(height: 50)
                        
                    }
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
    MeetingListView()
}
