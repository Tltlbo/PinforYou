//
//  KakaoMapViewModel.swift
//  PinforYou
//
//  Created by 박진성 on 5/8/24.
//

import Foundation
import Combine

class KakaoMapViewModel : ObservableObject {
    
    enum Action {
        case getLocation
        case getPlaceInfo
    }
    
    @Published var Location : Location?
    @Published var PlaceList : [PlaceModel.Place]?
    @Published var isFinished : Bool = false
    @Published var PlaceFinshed : Bool = false
    
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action : Action, location : Location = .init(longitude: 0, latitude: 0)) {
        switch action {
        case .getLocation:
            container.services.locationService.getLocation()
                .sink { [weak self] completion in
                    if case .failure = completion {
                        // Alert 띄울까?
                    }
                } receiveValue: { [weak self] Location in
                    self?.Location = Location
                    self?.isFinished = true
                    
                }.store(in: &subscriptions)
            
        case .getPlaceInfo:
            container.services.locationService.getPlaceInfo(location: self.Location ?? .init(longitude: 128.75273864999835, latitude: 35.8368914751991))
                .sink { [weak self] completion in
                    if case .failure = completion {
                        print("실패")
                    }
                } receiveValue: { [weak self] PlaceModel in
                    self?.PlaceList = PlaceModel.PlaceList
                    self?.PlaceFinshed = true
                    //TODO: 여기 기다릴까? isFinished
                }.store(in: &subscriptions)


        }
    }
    
}
