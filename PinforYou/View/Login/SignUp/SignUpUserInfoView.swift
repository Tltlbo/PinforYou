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
    @Binding var email: String
    @Binding var password: String
    @State var name: String = ""
    @State var phoneNumber: String = ""
    @State var gender: Gender = .male
    @State var age: String = ""
    let gridItems = Array(repeating: GridItem(.flexible()), count: 3)
    let categoryList: [String] = [
        "conveniencestore",
        "supermarket",
        "restaurant",
        "cafe",
        "hospital",
        "pharmacy", 
        "other"
    ]
    @State private var selectedIndex: Int? = nil
    
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
                        TextField("휴대폰 번호를 입력해주세요", text: $phoneNumber)
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
                        TextField("나이를 입력해주세요", text: $age)
                            .autocorrectionDisabled(true)
                            .keyboardType(.numberPad)
                        Divider()
                    }
                    .padding(.top, 52)
                    
                    VStack {
                                LazyVGrid(columns: gridItems) {
                                    ForEach(0..<7) { index in
                                        GridCellView(isSelected: selectedIndex == index, category: categoryList[index])
                                            .onTapGesture {
                                                selectCell(at: index)
                                            }
                                    }
                                }
                                .padding()
                            }
                    
                    Spacer()
                    
                    Button {
                        if let index = selectedIndex {
                            if email.isEmpty {
                                authViewModel.send(action: .signUp, userName: name, gender: gender, phoneNumber: phoneNumber, age: age, interest: categoryList[index])
                            }
                            else {
                                authViewModel.send(action: .signUpWithEmail, email: email, password: password,userName: name, gender: gender, phoneNumber: phoneNumber, age: age, interest: categoryList[index])
                            }
                        }
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
    
    private func selectCell(at index: Int) {
            if selectedIndex == index {
                selectedIndex = nil
            } else {
                selectedIndex = index
            }
        }
}

struct GridCellView: View {
    var isSelected: Bool
    let category: String
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .opacity(isSelected ? 0.0 : 5.0)
                .frame(width: 110, height: 110)
                .cornerRadius(10)
                .foregroundStyle(.white)
                .overlay(
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                        isSelected ? Image(systemName: "checkmark.seal.fill") : Image(systemName: "")
                        
                    }
                )
            Text(convertToCategory(from: category))
                .foregroundStyle(.black)
        }
    }
    
    private func convertToCategory(from input: String) -> String {
        switch input {
        case "conveniencestore":
            return "편의점"
        case "supermarket":
            return "마트"
        case "restaurant":
            return "음식점"
        case "cafe":
            return "카페"
        case "hospital":
            return "병원"
        case "pharmacy":
            return "약국"
        default:
            return "기타"
        }
    }
}

#Preview {
    SignUpUserInfoView(email: .constant(""), password: .constant("") )
}
