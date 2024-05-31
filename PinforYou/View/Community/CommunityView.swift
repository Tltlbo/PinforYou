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
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    communitySelect = .friend
                } label: {
                    Text("친구")
                }
                .padding(.leading, 10)
                
                Button {
                    communitySelect = .meeting
                } label: {
                    Text("모임")
                }
                Spacer()
            }
            
            switch communitySelect {
            case .friend:
                FriendListView()
            case .meeting:
                MeetingListView()
            }
        }
    }
}

#Preview {
    CommunityView()
}
