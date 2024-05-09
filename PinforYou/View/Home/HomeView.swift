//
//  HomeView.swift
//  PinforYou
//
//  Created by 박진성 on 5/6/24.
//

import SwiftUI

struct HomeView: View {
    @State var draw: Bool = false   //뷰의 appear 상태를 전달하기 위한 변수.
    var Location : Location = .init(longitude: 126.978365, latitude: 37.566691)
    @StateObject var kakaoMapViewModel : KakaoMapViewModel
    // MainTabView가 되기 전 임시로 StateObject
    
        var body: some View {
            
            if kakaoMapViewModel.isFinished {
                KakaoMapView(draw: $draw, Location: kakaoMapViewModel.Location ?? Location).onAppear(perform: {
                        self.draw = true
                    }).onDisappear(perform: {
                        self.draw = false
                    }).frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ProgressView()
                    .onAppear {
                        getLocationPermission()
                        kakaoMapViewModel.send(action: .getLocation)
                    }
            }
            
            
                
        }
}

#Preview {
    HomeView(kakaoMapViewModel: .init(container: .init(services: StubService())))
}
