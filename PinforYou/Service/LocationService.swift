//
//  LocationService.swift
//  PinforYou
//
//  Created by 박진성 on 5/7/24.
//

import Foundation
import Combine
import CoreLocation
import Alamofire

enum LocationError : Error {
    case locationReadFailed
    case APICallFailed
}

protocol LocationServiceType {
    func getLocation() -> AnyPublisher<Location, ServiceError>
    func getPlaceInfo(location : Location) -> AnyPublisher<PlaceModel, ServiceError>
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
    
    func getPlaceInfo(location : Location) -> AnyPublisher<PlaceModel, ServiceError> {
        Future { [weak self] promise in
            self?.getPlaceInfo(location: location) { result in
                switch result {
                case let .success(PlaceModel):
                    promise(.success(PlaceModel))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
}

extension LocationService {
    private func getLocation(completion: @escaping (Result<Location, Error>) -> Void) {
        let locationManager = CLLocationManager()
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
            location = .init(longitude: 128.75273864999835, latitude: 35.8368914751991)
        }
        
        if checkValue {
            completion(.success(location))
        }
        else {
            completion(.failure(LocationError.locationReadFailed))
        }
    }
    
    private func getPlaceInfo(location : Location, completion: @escaping (Result<PlaceModel, Error>) -> Void) {
        
        AF.request("\(APIURL.KakaoAPIUrl.rawValue)category_group_code=MT1,CS2,FD6,CE7,HP8,PM9&radius=300&x=\(location.longitude)&y=\(location.latitude)",
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Authorization" : "KakaoAK \(Key.KakaoApiKey.rawValue)"])
        .validate(statusCode: 200 ..< 300)
        .responseDecodable(of: PlaceModel.self) { [weak self] response in
            guard case .success(let data) = response.result
            else {
                print(response)
                return completion(.failure(LocationError.APICallFailed))
            }
            
            
            completion(.success(.init(PlaceList: data.PlaceList)))
            
            
        }
        
        
        
    }
    
}

class StubLocationService : LocationServiceType {
    
    func getLocation() -> AnyPublisher<Location, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func getPlaceInfo(location : Location) -> AnyPublisher<PlaceModel, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
