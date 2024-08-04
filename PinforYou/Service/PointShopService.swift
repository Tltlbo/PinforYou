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
}

enum gifticonCategory : String {
    case drink = "음료"
    case coffee = "커피"
    case food = "음식"
    case goods = "굿즈"
    case other = "기타"
    case all = "전체"
}

protocol PointShopServiceType {
    func getGifticonInfo(category : gifticonCategory) -> AnyPublisher<[PointShopGifticon], ServiceError>
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
            AF.request("https://pinforyou.online/pointShop/items",
                       method: .get,
                       parameters: ["category" : category.rawValue],
                       encoding: URLEncoding.queryString,
                       headers: ["Content-Type" : "application/json"])
            .responseDecodable(of: [PointShopGifticon].self) { [weak self] response in
                print("나 카테고리 호출")
                guard case .success(let data) = response.result
                else {
                    return completion(.failure(PointShopError.FailedfetchGifticon))
                }
                
                
                completion(.success(data))
            }
        }
        
        
    }
}

class StubPointShopService : PointShopServiceType {
    
    func getGifticonInfo(category : gifticonCategory) -> AnyPublisher<[PointShopGifticon], ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
