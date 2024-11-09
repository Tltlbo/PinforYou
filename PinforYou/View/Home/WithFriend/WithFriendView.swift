//
//  WithFriendView.swift
//  PinforYou
//
//  Created by 박진성 on 5/20/24.
//

import SwiftUI

struct WithFriendView: View {
    
    enum friendOption {
        case game
        case withRecommend
    }
    
    var checkOption : friendOption = .withRecommend
    let StoreName: String
    let StoreCategory: String
    @EnvironmentObject var container : DIContainer
    @StateObject var gameViewModel: GameViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment:.leading){
                if (checkOption == .game) {
                    
                    Text("""
                        함께 할 친구를
                        선택해주세요!
                        """)
                    .font(.system(size: 26, weight: .bold))
                    .padding(.leading, 15)
                    
                    
                }
                else {
                    
                    VStack(alignment:.leading) {
                        Text("""
                            함께 추천 받을 친구를
                            선택해주세요!
                            """)
                        .font(.system(size: 26, weight: .bold))
                        .padding(.leading, 15)
                    }
                }
                
                FriendGridView()
                    .environmentObject(gameViewModel)
                    .padding(.horizontal, 15)
            }
            
            NavigationLink {
                RouletteView(StoreName: StoreName, StoreCategory: StoreCategory)
                    .environmentObject(gameViewModel)
            } label: {
                ZStack(alignment: .center) {
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width - 25, height: 64)
                        .clipShape(.rect(cornerRadius: 10))
                        .foregroundStyle(.blue)
                    
                    if (checkOption == .game) {
                        
                        Text("시작하기")
                            .foregroundStyle(.white)
                        
                    }
                    else {
                        
                        Text("확인")
                            .foregroundStyle(.white)
                        
                    }
                }
            }
        }
        .onAppear {
            gameViewModel.send(action: .getFriendInfo)
        }
    }
}

struct testCheck : Hashable {
    var uuid : UUID = UUID()
    var check = false
}

struct FriendGridView : View {
    
    var columns : [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(gameViewModel.friends, id: \.self) { friend in
                    
                    
                    ZStack {
                        if !gameViewModel.selecedFriends.contains(where: { selectedfriend in
                            selectedfriend == friend
                        }) {
                            Button {
                                gameViewModel.selecedFriends.append(friend)
                            } label: {
                                VStack {
                                    Color(.blue)
                                        .cornerRadius(15)
                                        .frame(width: 100, height: 100)
                                        .padding()
                                    Text(friend.name)
                                        .foregroundStyle(.black)
                                }
                            }
                        }
                        else {
                            
                            Button {
                                gameViewModel.selecedFriends.remove(at: gameViewModel.selecedFriends.firstIndex(where: { selectedfriend in
                                    selectedfriend == friend
                                }) ?? 0)
                            } label: {
                                VStack {
                                    Color(.blue)
                                        .cornerRadius(15)
                                        .frame(width: 100, height: 100)
                                        .blur(radius: 2)
                                        .padding()
                                    Text(friend.name)
                                        .foregroundStyle(.black)
                                }
                            }
                            
                            Image(systemName: "checkmark.seal.fill")
                                .resizable()
                                .foregroundStyle(.white)
                                .frame(width: 40, height: 40)
                        }
                        
                    }
                    
                }
            }
        }
    }
}
