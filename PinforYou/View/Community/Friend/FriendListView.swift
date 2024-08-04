//
//  FriendListView.swift
//  PinforYou
//
//  Created by 박진성 on 5/31/24.
//

import SwiftUI

struct FriendListView: View {
    
    @StateObject var friendListViewModel : FriendListViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        //
                    } label: {
                        Text("추가")
                            .font(.system(size: 15))
                    }
                    .padding(.trailing, 5)
                    
                    Button {
                        //
                    } label: {
                        Text("관리")
                            .font(.system(size: 15))
                    }
                    .padding(.trailing, 10)
                }
                Rectangle()
                    .frame(height: 1)
                
                ScrollView{
                    MyFriendGridView()
                        .environmentObject(friendListViewModel)
                }
                .scrollIndicators(.hidden)
                
                Spacer()
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
    
    @EnvironmentObject var friendListViewModel : FriendListViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(friendListViewModel.FriendList, id: \.self) { friend in
                    
                    NavigationLink {
                        //
                    } label: {
                        
                        VStack(alignment: .center) {
                            Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
                                        .cornerRadius(15)
                                        .frame(width: 110, height: 110)
                            Text(friend.name)
                        }
                       
                    }

                }
            }
        }
        .onAppear {
            friendListViewModel.send(action: .getFriendInfo, userid: 1)
        }
    }
}

#Preview {
    FriendListView(friendListViewModel: .init(container: .init(services: StubService())))
}
