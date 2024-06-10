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
                            .font(.system(size: 20))
                    }
                    
                    Button {
                        //
                    } label: {
                        Text("관리")
                            .font(.system(size: 20))
                    }
                    .padding(.trailing, 10)
                }
                Rectangle()
                    .frame(height: 1)
                
                ScrollView(.vertical) {
                    
                    VStack(spacing: 10) {
                        ForEach(0 ..< 19, id: \.self) { _ in
                            HStack {
                                Text("모임")
                                    .foregroundStyle(.white)
                            }
                            .frame(height: 50)
                            
                        }
                        
                    }
                }
                .scrollIndicators(.hidden)
                
            }
            .background {
                Color("BackgroundColor")
                    .ignoresSafeArea()
            }
        }
        
    }
    
    
}

#Preview {
    MeetingListView()
}
