//
//  CommunityView.swift
//  PinforYou
//
//  Created by 박진성 on 5/31/24.
//

import SwiftUI

enum Community {
    case friend
    case meeting
}

struct CommunityView: View {
    
    @State var communitySelect : Community = .friend
    @EnvironmentObject var container : DIContainer
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    communitySelect = .friend
                } label: {
                    
                    HStack {
                        Text("친구")
                            .font(.system(size: 17))
                    }
                    .frame(width: 70, height: 35)
                    .background(Color("CellBackgroundColor"))
                    .clipShape(.rect(cornerRadius: 12))
                    
                }
                .padding(.leading, 10)
                
                Button {
                    communitySelect = .meeting
                } label: {
                    HStack {
                        Text("모임")
                            .font(.system(size: 17))
                    }
                    .frame(width: 70, height: 35)
                    .background(Color("CellBackgroundColor"))
                    .clipShape(.rect(cornerRadius: 12))
                    
                }
                Spacer()
            }
            
            switch communitySelect {
            case .friend:
                FriendListView(friendListViewModel: .init(container: container))
            case .meeting:
                MeetingListView()
            }
            
        }
        .background {
            Color("BackgroundColor")
                .ignoresSafeArea()
        }
        
    }
}

#Preview {
    CommunityView()
}
