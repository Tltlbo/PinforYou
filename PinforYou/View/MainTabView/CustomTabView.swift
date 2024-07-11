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
                        Button {
                            selectedTab = tab
                        } label: {
                            Image(tab.imageName(selected: selectedTab == tab))
                                .frame(height: 70)
                        }
                        .padding(.horizontal, UIScreen.main.bounds.width/100 * 5 - 5)
                    }

                }
            }
            
            Button {
                selectedTab = .home
            } label: {
                Image("Main")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
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
