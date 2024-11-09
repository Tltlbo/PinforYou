//
//  FriendListView.swift
//  PinforYou
//
//  Created by 박진성 on 5/31/24.
//

import SwiftUI

struct FriendListView: View {
    
    @StateObject var friendListViewModel : FriendListViewModel
    @State var modifyTouched : Bool = false
    @State var addTouched: Bool = false
    @State var isDelete: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        addTouched = true
                    } label: {
                        Text("추가")
                            .font(.system(size: 15))
                    }
                    .padding(.trailing, 5)
                    .fullScreenCover(isPresented: $addTouched) {
                        FriendAddView()
                            .environmentObject(friendListViewModel)
                    }
                    
                    Button {
                        modifyTouched = true
                    } label: {
                        Text("관리")
                            .font(.system(size: 15))
                    }
                    .padding(.trailing, 10)
                    .fullScreenCover(isPresented: $modifyTouched) {
                        FriendModifyView(isDelete: $isDelete)
                            .environmentObject(friendListViewModel)
                    }
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
    @State var isDelete: Bool = false
    @State var deletedFriend: Friend?
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(friendListViewModel.FriendList, id: \.self) { friend in
                    Button {
                        deletedFriend = friend
                    } label: {
                        VStack(alignment: .center) {
                            Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
                                        .cornerRadius(15)
                                        .frame(width: 110, height: 110)
                            Text(friend.name ?? "")
                        }
                    }
                    .alert(item: $deletedFriend) { friend in
                        Alert(title: Text("삭제하시겠습니까?"), message: Text("\(friend.name)이 삭제됩니다."), primaryButton: .destructive(Text("삭제"), action: {
                            friendListViewModel.send(action: .deleteFriendInfo, friendid: friend.friendID)
                            deletedFriend = nil
                            isDelete = true
                        }), secondaryButton: .cancel(Text("취소"), action: {
                            deletedFriend = nil
                        }))
                    }
                }
            }
        }
        .onAppear {
            friendListViewModel.send(action: .getFriendInfo, friendid: nil)
        }
        .onChange(of: isDelete) { newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    friendListViewModel.send(action: .getFriendInfo, friendid: nil)
                    isDelete = false
                }
            }
        }
    }
}

#Preview {
    FriendListView(friendListViewModel: .init(container: .init(services: StubService())))
}
