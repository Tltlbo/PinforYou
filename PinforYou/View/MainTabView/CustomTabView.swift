//
//  CustomTabView.swift
//  PinforYou
//
//  Created by 박진성 on 7/10/24.
//

import SwiftUI

struct CustomTabView: View {
    
    @Binding var selectedTab : MainTabType
    
    var body: some View {
        ZStack {
            HStack {
                ForEach(MainTabType.allCases, id: \.self) { tab in
                    
                    if tab == .home {
                            
                        Rectangle()
                            .frame(height:10)
                            .opacity(0)
                            .padding(.horizontal, UIScreen.main.bounds.width/100 * 5 - 5)
                            
                    }
                    else {
                        Image(tab.imageName(selected: selectedTab == tab))
                            .frame(height: 70)
                            .padding(.horizontal, UIScreen.main.bounds.width/100 * 5 - 5)
                            .onTapGesture {
                                selectedTab = tab
                            }
            
                    }

                }
            }
            
            Button {
                selectedTab = .home
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(.white)
                        .shadow(radius: 10)
                    
                    Image("logo_main")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                }
            }
            .offset(y: -25)
        }
        .frame(width: UIScreen.main.bounds.width, height: 40)
        .background{
            Color("BackgroundColor")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    CustomTabView(selectedTab: .constant(.home))
}
