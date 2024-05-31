//
//  FriendListView.swift
//  PinforYou
//
//  Created by 박진성 on 5/31/24.
//

import SwiftUI

struct FriendListView: View {
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
                            Text("test")
                                .foregroundStyle(.black)
                        }
                        .frame(height: 50)
                        
                    }
                }
            }
        }
    }
}

#Preview {
    FriendListView()
}
