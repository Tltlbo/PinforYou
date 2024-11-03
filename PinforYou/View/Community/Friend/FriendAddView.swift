//
//  FriendAddView.swift
//  PinforYou
//
//  Created by 박진성 on 11/4/24.
//

import SwiftUI

struct FriendAddView: View {
    @State var friendName: String = ""
    @State var tel: String = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var friendListViewModel : FriendListViewModel
    
    var body: some View {
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
        
        ScrollView {
            VStack (alignment: .leading){
                HStack {
                    Text("""
                친구 정보를
                입력해주세요!
                """)
                    .font(.system(size: 30, weight: .bold))
                    
                    Spacer()
                }
                .padding(.top, 50)
                
                VStack(alignment: .leading) {
                    Text("이름")
                    TextField("이름을 입력해주세요", text: $friendName)
                        .autocorrectionDisabled(true)
                        .keyboardType(.default)
                    Divider()
                }
                .padding(.top, 48)
                
                VStack(alignment: .leading) {
                    Text("전화번호")
                    TextField("전화번호를 입력해주세요(-를 제외)", text: $tel)
                        .autocorrectionDisabled(true)
                        .keyboardType(.default)
                    Divider()
                }
                .padding(.top, 52)
        
                Spacer()
                
                Button {
                    friendListViewModel.send(action: .requestFriend, friendid: nil, name: friendName, tel: tel)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack(alignment: .center) {
                        Text("완료")
                    }
                    .frame(width: UIScreen.main.bounds.size.width - 20, height: 72)
                    .background(Color("CellBackgroundColor"))
                    .clipShape(.rect(cornerRadius: 20))
                }
                .disabled(friendName.isEmpty || tel.isEmpty)
            }
            .padding(.leading, 10)
        }
    }
}

#Preview {
    FriendAddView()
}
