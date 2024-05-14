//
//  HomeView.swift
//  PinforYou
//
//  Created by 박진성 on 5/6/24.
//

import SwiftUI


struct HomeView: View {
    @State var draw: Bool = false   //뷰의 appear 상태를 전달하기 위한 변수.
    @State var isTapped : Bool = false
    @State var TappedPlace : PlaceModel.Place = PlaceModel.placestub2.PlaceList[0]
    @State var modalDetent = PresentationDetent.medium
    
    @StateObject var kakaoMapViewModel : KakaoMapViewModel
    
    
        var body: some View {
            
            if kakaoMapViewModel.isFinished && kakaoMapViewModel.PlaceFinshed {
                KakaoMapView(draw: $draw, isTapped: $isTapped, tappedPlace: $TappedPlace)
                    .onAppear(perform: {
                        self.draw = true
                    }).onDisappear(perform: {
                        self.draw = false
                    })/*.frame(maxWidth: .infinity, maxHeight: .infinity)*/
                    .environmentObject(kakaoMapViewModel)
                    .sheet(isPresented: $isTapped) {
                        PlaceInfoView(Place: $TappedPlace)
                            .presentationDetents(
                                [.medium, .large],
                                selection: $modalDetent
                            )
                    }
                    
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
