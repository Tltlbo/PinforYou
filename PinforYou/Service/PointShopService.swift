//
//  PointShopService.swift
//  PinforYou
//
//  Created by 박진성 on 8/4/24.
//

import Foundation
import Combine
import Alamofire

enum PointShopError : Error {
    case FailedfetchGifticon
    case FailedfetchUserGifticon
}

enum gifticonCategory : String {
    case drink = "음료"
    case coffee = "커피"
    case food = "음식"
    case goods = "굿즈"
    case other = "기타"
    case all = "전체"
    
    func description() -> String {
            switch self {
            case .drink:
                return "drink"
            case .coffee:
                return "coffee"
            case .food:
                return "food"
            case .goods:
                return "goods"
            case .other:
                return "other"
            case .all:
                return "all"
            }
        }
}

protocol PointShopServiceType {
    func getGifticonInfo(category : gifticonCategory) -> AnyPublisher<[PointShopGifticon], ServiceError>
    func getUserGifticon(userid : Int) -> AnyPublisher<Usergifticon, ServiceError>
}

class PointShopService : PointShopServiceType {
    
    func getGifticonInfo(category : gifticonCategory) -> AnyPublisher<[PointShopGifticon], ServiceError> {
        Future { [weak self] promise in
            self?.getGifticonInfo(category: category) { result in
                switch result {
                case let .success(gifticon):
                    promise(.success(gifticon))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getUserGifticon(userid: Int) -> AnyPublisher<Usergifticon, ServiceError> {
        Future { [weak self] promise in
            self?.getUserGifticon(userid: userid) { result in
                switch result {
                case let .success(usergifticon):
                    promise(.success(usergifticon))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
}

extension PointShopService {
    
    private func getGifticonInfo(category: gifticonCategory, completion: @escaping (Result<[PointShopGifticon], Error>) -> Void) {
        if category == .all {
            AF.request("https://pinforyou.online/pointShop/items",
                       method: .get,
                       encoding: URLEncoding.queryString,
                       headers: ["Content-Type" : "application/json"])
            .responseDecodable(of: [PointShopGifticon].self) { [weak self] response in
                
                guard case .success(let data) = response.result
                else {
                    return completion(.failure(PointShopError.FailedfetchGifticon))
                }
                
                completion(.success(data))
            }
        }
        else {
            AF.request("https://pinforyou.online/pointShop/items/category",
                       method: .get,
                       parameters: ["category" : category.description()],
                       encoding: URLEncoding.queryString,
                       headers: ["Content-Type" : "application/json"])
            .responseDecodable(of: [PointShopGifticon].self) { [weak self] response in
                guard case .success(let data) = response.result
                else {
                    return completion(.failure(PointShopError.FailedfetchGifticon))
                }
                
                
                completion(.success(data))
            }
        }
    }
    
    private func getUserGifticon(userid: Int, completion : @escaping (Result<Usergifticon, Error>) -> Void) {
        AF.request("https://pinforyou.online/itemList",
                   method: .get,
                   parameters: ["user_id" : userid],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: Usergifticon.self) { [weak self] response in
            debugPrint(response)
            guard case .success(let data) = response.result
            else {
                return completion(.failure(PointShopError.FailedfetchUserGifticon))
            }
            
            
            completion(.success(data))
        }
    }
}

class StubPointShopService : PointShopServiceType {
    
    func getGifticonInfo(category : gifticonCategory) -> AnyPublisher<[PointShopGifticon], ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func getUserGifticon(userid: Int) -> AnyPublisher<Usergifticon, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
