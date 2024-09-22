//
//  FriendModifyView.swift
//  PinforYou
//
//  Created by 박진성 on 8/18/24.
//

import SwiftUI

struct FriendModifyView : View {
    @EnvironmentObject var container : DIContainer
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var friendListViewModel : FriendListViewModel
    
    @State var isInsert : Bool = false
    @State var cardName : String = ""
    @State var cardNum : String = ""
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                        }
                        Spacer()
                    }
                    
                    if friendListViewModel.RequestFriendList.isEmpty {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("요청한 친구가 없습니다.")
                            Spacer()
                        }
                        Spacer()
                        
                    }
                    else {
                        RequestFriendGridView()
                            .environmentObject(friendListViewModel)
                    }
                    

                    
                }
                .padding(.leading, 10)
            }
        }
        .onAppear {
            friendListViewModel.send(action: .getRequestFriendInfo, userid: 1, friendid: nil)
        }
            
            
    }
}

struct RequestFriendGridView : View {
    
    var columns : [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    @EnvironmentObject var friendListViewModel : FriendListViewModel
    @State var isAccept: Bool = false
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(friendListViewModel.RequestFriendList, id: \.self) { friend in
                    
                    Button {
                        isAccept = true
                    } label: {
                        VStack(alignment: .center) {
                            Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
                                        .cornerRadius(15)
                                        .frame(width: 110, height: 110)
                            Text(friend.name)
                        }
                    }
                    .alert(isPresented: $isAccept) {
                        Alert(title: Text("수락하시겠습니까?"), message: Text("\(friend.name)이 추가됩니다."), primaryButton: .destructive(Text("추가"), action: {
                            friendListViewModel.send(action: .acceptRequestFriend, userid: 1, friendid: friend.friendID)
                            isAccept = false
                        }), secondaryButton: .cancel(Text("취소"), action: {
                            isAccept = false
                        }))
                    }

                }
            }
        }
        
    }
}
