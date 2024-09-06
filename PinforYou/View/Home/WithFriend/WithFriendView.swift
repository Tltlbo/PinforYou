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
                    .padding(.horizontal, 15)
            }
            
            NavigationLink {
<<<<<<< HEAD
                RouletteView()
=======
                RouletteView() // 룰렛 뷰 연결
>>>>>>> main
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
    }
}

struct testCheck : Hashable {
    var uuid : UUID = UUID()
    var check = false
}

struct FriendGridView : View {
    
    var columns : [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    @State var test : [testCheck] = [
        .init(),
        .init(),
        .init()
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach($test, id: \.self) { $test in
                    
                    
                    ZStack {
                        if !test.check {
                            
                            Button {
                                test.check = true
                            } label: {
                                Color(.blue)
                                    .cornerRadius(15)
                                    .frame(width: 110, height: 110)
                                    .padding()
                            }
                            
                            
                        }
                        else {
                            
                            Button {
                                test.check = false
                            } label: {
                                Color(.blue)
                                    .cornerRadius(15)
                                    .frame(width: 110, height: 110)
                                    .blur(radius: 2)
                                    .padding()
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

#Preview {
    WithFriendView()
}
