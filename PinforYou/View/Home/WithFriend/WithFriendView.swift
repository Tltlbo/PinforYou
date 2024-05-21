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
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading){
                if (checkOption == .game) {
                    
                    Text("""
                        함께 할 친구를
                        선택해주세요!
                        """)
                    .font(.system(size: 26, weight: .bold))
                    .padding(.leading, 15)
                    
                }
                else {
                    Text("""
                        함께 추천 받을 친구를
                        선택해주세요!
                        """)
                    .font(.system(size: 26, weight: .bold))
                    .padding(.leading, 15)
                }
                
                FriendGridView()
                    .padding(.horizontal, 15)
                
                    NavigationLink {
                        //
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 150, height: 50)
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
        }
    }
}

struct FriendGridView : View {
    
    var columns : [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach((0...19), id: \.self) { _ in
                    
                    NavigationLink {
                        //
                    } label: {
                        Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
                                    .cornerRadius(15)
                                    .frame(width: 110, height: 110)
                                    .padding()
                    }

                }
            }
        }
    }
}

#Preview {
    WithFriendView()
}
