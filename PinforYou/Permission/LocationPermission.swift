//
//  LocationPermission.swift
//  PinforYou
//
//  Created by 박진성 on 5/7/24.
//

import Foundation
import Combine

func getLocationPermission() -> AnyPublisher<Location, ServiceError> {
    return Empty().eraseToAnyPublisher()
    
    //TODO: 여기서 위치 권한 확인 및 요청
}
