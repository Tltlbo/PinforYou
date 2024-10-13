//
//  SignUpUserInfoView.swift
//  PinforYou
//
//  Created by 박진성 on 6/11/24.
//

import SwiftUI

enum Gender: String, CaseIterable {
    case male = "남자"
    case female = "여자"
}

struct SignUpUserInfoView: View {
    
    @EnvironmentObject var authViewModel : AuthenticationViewModel
    @State var name: String = ""
    @State var phoneNumber: String = ""
    @State var gender: Gender = .male
    @State var age: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("""
                            사용자 정보를
                            입력해주세요!
                            """)
                        .font(.system(size: 26, weight: .bold))
                        
                        Spacer()
                    }
                    .padding(.top, 50)
                    
                    VStack(alignment: .leading) {
                        Text("이름")
                        TextField("이름을 입력해주세요", text: $name)
                            .autocorrectionDisabled(true)
                            .keyboardType(.namePhonePad)
                        Divider()
                    }
                    .padding(.top, 48)
                    
                    
                    VStack(alignment: .leading) {
                        Text("휴대폰 번호(-를 제외한)")
                        TextField("휴대폰 번호를 입력해주세요", text: $name)
                            .autocorrectionDisabled(true)
                            .keyboardType(.numberPad)
                        Divider()
                    }
                    .padding(.top, 52)
                    
                    VStack(alignment: .leading) {
                        Text("성별")
                        Picker("성별을 선택해주세요", selection: $gender) {
                            ForEach(Gender.allCases, id: \.self) { gender in
                                Text(gender.rawValue).tag(gender)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding(.top, 52)
                    
                    VStack(alignment: .leading) {
                        Text("나이")
                        TextField("나이를 입력해주세요", text: $name)
                            .autocorrectionDisabled(true)
                            .keyboardType(.numberPad)
                        Divider()
                    }
                    .padding(.top, 52)
                    
                    Spacer()
                    
                    Button {
                        //
                    } label: {
                        HStack(alignment: .center) {
                            Text("완료")
                        }
                        .frame(width: UIScreen.main.bounds.size.width - 20, height: 72)
                        .background(Color("CellBackgroundColor"))
                        .clipShape(.rect(cornerRadius: 20))
                    }
                }
                .padding(.leading, 10)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            authViewModel.authenticationState = .unauthenticated
                        } label: {
                            Image(systemName: "chevron.left")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SignUpUserInfoView()
}
