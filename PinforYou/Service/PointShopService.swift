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
    case FailedFetchUserPoint
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
    func getGifticonInfo(category : gifticonCategory) -> AnyPublisher<PointShopGifticon, ServiceError>
    func getUserGifticon(userid : Int) -> AnyPublisher<Usergifticon, ServiceError>
    func getUserPointInfo(userid: Int) -> AnyPublisher<Int, ServiceError>
    func deleteUserGifticon(itemid: Int) -> AnyPublisher<Int, ServiceError>
    func purchaseGifticon(itemid: Int) -> AnyPublisher<Bool, ServiceError>
}

class PointShopService : PointShopServiceType {
    
    func getGifticonInfo(category : gifticonCategory) -> AnyPublisher<PointShopGifticon, ServiceError> {
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
    
    func getUserPointInfo(userid: Int) -> AnyPublisher<Int, ServiceError> {
        Future { [weak self] promise in
            self?.getUserPointInfo(userid: userid) { result in
                switch result {
                case let .success(userPoint):
                    promise(.success(userPoint))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteUserGifticon(itemid: Int) -> AnyPublisher<Int, ServiceError> {
        Future { [weak self] promise in
            self?.deleteUserGifticon(itemid: itemid) { result in
                switch result {
                case let .success(result):
                    promise(.success(result))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func purchaseGifticon(itemid: Int) -> AnyPublisher<Bool, ServiceError> {
        Future { [weak self] promise in
            self?.purchaseGifticon(itemid: itemid) { result in
                switch result {
                case let .success(result):
                    promise(.success(result))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
}

extension PointShopService {
    
    private func getGifticonInfo(category: gifticonCategory, completion: @escaping (Result<PointShopGifticon, Error>) -> Void) {
        if category == .all {
            AF.request("https://pinforyou.online/pointShop/items",
                       method: .get,
                       encoding: URLEncoding.queryString,
                       headers: ["Content-Type" : "application/json"])
            .responseDecodable(of: PointShopGifticon.self) { [weak self] response in
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
            .responseDecodable(of: PointShopGifticon.self) { [weak self] response in
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
            guard case .success(let data) = response.result
            else {
                return completion(.failure(PointShopError.FailedfetchUserGifticon))
            }
            completion(.success(data))
        }
    }
    
    private func getUserPointInfo(userid: Int, completion : @escaping (Result<Int, Error>) -> Void) {
        
        struct Point: Decodable {
            let point: Int
            
            enum CodingKeys: String, CodingKey {
                case point = "point"
            }
        }
        
        AF.request("https://pinforyou.online/user/point",
                   method: .get,
                   parameters: ["user_id" : userid],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: Point.self) { [weak self] response in
            guard case .success(let data) = response.result
            else {
                return completion(.failure(PointShopError.FailedFetchUserPoint))
            }
            completion(.success(data.point))
        }
    }
    
    private func deleteUserGifticon(itemid: Int, completion : @escaping (Result<Int, Error>) -> Void) {
        struct result: Decodable {
            let result: Int
            
            enum CodingKeys: String, CodingKey {
                case result = "result"
            }
        }
        AF.request("https://pinforyou.online/itemList/delete",
                   method: .delete,
                   parameters: ["item_list_id" : itemid],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: result.self) { [weak self] response in
            guard case .success(let data) = response.result
            else {
                return completion(.failure(PointShopError.FailedfetchUserGifticon))
            }
            completion(.success(data.result))
        }
    }
    
    private func purchaseGifticon(itemid: Int, completion : @escaping (Result<Bool, Error>) -> Void) {
        struct result: Decodable {
            let result: Bool
        }
        
        AF.request("https://pinforyou.online/pointShop/purchaseItem",
                   method: .post,
                   parameters: ["hashed_id" : "8a2d0e95dbfc6f17f11672392b870b632377ab3c49582e311913df8fbd3548f2",
                                "item_id" : itemid],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: result.self) { [weak self] response in
            
            guard case .success(let data) = response.result
            else {
                return completion(.failure(PointShopError.FailedfetchUserGifticon))
            }
            completion(.success(data.result))
        }
    }
}

class StubPointShopService : PointShopServiceType {
    func getGifticonInfo(category : gifticonCategory) -> AnyPublisher<PointShopGifticon, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func getUserGifticon(userid: Int) -> AnyPublisher<Usergifticon, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func getUserPointInfo(userid: Int) -> AnyPublisher<Int, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func deleteUserGifticon(itemid: Int) -> AnyPublisher<Int, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func purchaseGifticon(itemid: Int) -> AnyPublisher<Bool, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
