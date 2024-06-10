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
                
                ScrollView{
                    MyFriendGridView()
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

struct MyFriendGridView : View {
    
    var columns : [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach((0...19), id: \.self) { _ in
                    
                    NavigationLink {
                        //
                    } label: {
                        
                        VStack(alignment: .center) {
                            Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
                                        .cornerRadius(15)
                                        .frame(width: 110, height: 110)
                            Text("이름")
                        }
                       
                    }

                }
            }
        }
    }
}

#Preview {
    FriendListView()
}
