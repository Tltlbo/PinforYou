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
            friendListViewModel.send(action: .getRequestFriendInfo, userid: 1)
        }
            
            
    }
}

struct RequestFriendGridView : View {
    
    var columns : [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    @EnvironmentObject var friendListViewModel : FriendListViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(friendListViewModel.RequestFriendList, id: \.self) { friend in
                    
                    Button {
                        // 삭제하는 부분
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
        
    }
}
