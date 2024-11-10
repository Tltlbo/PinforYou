//
//  newRoulleteView.swift
//  PinforYou
//
//  Created by 박진성 on 11/10/24.
//

import SwiftUI

struct newRoulleteView: View {
    @State private var selectedIndex: Int?
    @State private var navigateToCardInfo = false  // 네비게이션 트리거
    @EnvironmentObject var roulleteViewModel: GameViewModel
    @EnvironmentObject var authViewModel : AuthenticationViewModel
    @EnvironmentObject var container: DIContainer
    var StoreName : String
    var StoreCategory : String
    
    @State private var displayedName = ""
    @State private var isScrolling = false
    @State private var timer: Timer?
    
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Text(displayedName)
                    .font(.largeTitle)
                    .padding()
                    .onAppear {
                        displayedName = roulleteViewModel.selecedFriends.randomElement()?.name ?? ""
                    }
                
                Button(action: startScrolling) {
                    Text("Start Scrolling")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                if let selectedIndex {
                    NavigationLink("", destination: CardInfoView(selectedFriend: roulleteViewModel.selecedFriends[selectedIndex], StoreName: StoreName, StoreCategory: StoreCategory, cardInfoViewModel: .init(container: container)), isActive: $navigateToCardInfo)
                }
            }
            .onAppear {
                roulleteViewModel.selecedFriends.append(Friend(friendID: UserID.shared.hashedID ?? "", name: authViewModel.userName))
                roulleteViewModel.colors.append(Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)))
            }
            .onChange(of: selectedIndex) { newValue in
                if newValue != nil {
                    navigateToCardInfo = true
                }
            }
        }
    }
    
    func startScrolling() {
        isScrolling = true
        timer?.invalidate() // 기존 타이머가 있으면 중지
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            withAnimation {
                displayedName = roulleteViewModel.selecedFriends.randomElement()?.name ?? ""
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            stopScrolling()
        }
    }
    
    func stopScrolling() {
        timer?.invalidate() // 타이머 중지
        isScrolling = false
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            selectedIndex = roulleteViewModel.selecedFriends.firstIndex {
                $0.name == displayedName
            }
        }
    }
}

