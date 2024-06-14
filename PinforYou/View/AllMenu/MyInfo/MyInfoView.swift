//
//  MyInfoView.swift
//  PinforYou
//
//  Created by 박진성 on 6/11/24.
//

import SwiftUI

struct MyInfoView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        VStack(alignment:.leading) {
                            HStack {
                                Text("이름")
                                    .font(.system(size: 20))
                                    .foregroundStyle(.white)
                            }
                            .padding(.bottom, 5)
                            .padding(.leading, 10)
                            
                            HStack {
                                Text("박진성")
                                    .font(.system(size: 20))
                                    .foregroundStyle(.white)
                            }
                            .padding(.leading, 10)
                        }
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.size.width - 25, height: 76)
                    .background {
                        Color("CellBackgroundColor")
                    }
                    .clipShape(.rect(cornerRadius: 20))
                }
                .navigationTitle("내 정보 수정")
                .background {
                    Color("BackgroundColor")
                        .ignoresSafeArea()
                }
            }
        }
    }
}

#Preview {
    MyInfoView()
}
