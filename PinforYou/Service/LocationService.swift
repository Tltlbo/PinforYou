//
//  LocationService.swift
//  PinforYou
//
//  Created by 박진성 on 5/7/24.
//

import Foundation
import Combine
import CoreLocation

enum LocationError : Error {
    case failed
}

protocol LocationServiceType {
    func getLocation() -> AnyPublisher<Location, ServiceError>
    
}

class LocationService : LocationServiceType {
    func getLocation() -> AnyPublisher<Location, ServiceError> {
        Future { [weak self] promise in
            self?.getLocation { result in
                switch result {
                case let .success(Location):
                    promise(.success(Location))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

extension LocationService {
    private func getLocation(completion: @escaping (Result<Location, Error>) -> Void) {
        var locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        let coordinate = locationManager.location?.coordinate
        let latitude = coordinate?.latitude
        let longitude = coordinate?.longitude
        
        var location : Location
        var checkValue : Bool = false
        
        
        if let latitude = latitude,
           let longitude = longitude {
            location = .init(longitude: longitude, latitude: latitude)
            checkValue.toggle()
        }
        else {
            location = .init(longitude: 126.978365, latitude: 37.566691)
        }
        
        if checkValue {
            completion(.success(location))
        }
        else {
            completion(.failure(LocationError.failed))
        }
    }
}

class StubLocationService : LocationServiceType {
    
    func getLocation() -> AnyPublisher<Location, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
