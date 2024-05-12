//
//  HomeView.swift
//  PinforYou
//
//  Created by 박진성 on 5/6/24.
//

import SwiftUI

struct HomeView: View {
    @State var draw: Bool = false   //뷰의 appear 상태를 전달하기 위한 변수.
    @StateObject var kakaoMapViewModel : KakaoMapViewModel
    
        var body: some View {
            
            if kakaoMapViewModel.isFinished && kakaoMapViewModel.PlaceFinshed {
                KakaoMapView(draw: $draw)
                    .onAppear(perform: {
                        self.draw = true
                    }).onDisappear(perform: {
                        self.draw = false
                    })/*.frame(maxWidth: .infinity, maxHeight: .infinity)*/
                    .environmentObject(kakaoMapViewModel)
            } else {
                ProgressView()
                    .onAppear {
                        getLocationPermission()
                        kakaoMapViewModel.send(action: .getLocation)
                        kakaoMapViewModel
                            .send(action: .getPlaceInfo)
                    }
            }
            
            
                
        }
}

#Preview {
    HomeView(kakaoMapViewModel: .init(container: .init(services: StubService())))
}
