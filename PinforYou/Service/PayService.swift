//
//  PayService.swift
//  PinforYou
//
//  Created by 박진성 on 6/14/24.
//

import Foundation
import Alamofire
import Combine

protocol PayServiceType {
    func getPayRecommendCardInfo(userid : Int, storeName : String, storeCategory : String) -> AnyPublisher<PayCardModel, ServiceError>
    func getCardQrCode() -> AnyPublisher<UIImage, ServiceError>
}

class PayService : PayServiceType {
    func getPayRecommendCardInfo(userid : Int, storeName : String, storeCategory : String) -> AnyPublisher<PayCardModel, ServiceError> {
        Future { [weak self] promise in
            self?.getPayRecommendCardInfo(userid: userid, storeName: storeName, storeCategory: storeCategory) { result in
                switch result {
                case let .success(PayCardModel):
                    promise(.success(PayCardModel))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getCardQrCode() -> AnyPublisher<UIImage, ServiceError> {
        Future { [weak self] promise in
            self?.getCardQrCode(completion: { result in
                switch result {
                case let .success(UIImage):
                    promise(.success(UIImage))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            })
        }.eraseToAnyPublisher()
    }
}

extension PayService {
    private func getPayRecommendCardInfo(userid : Int, storeName : String, storeCategory : String, completion: @escaping (Result<PayCardModel, Error>) -> Void) {
        
        AF.request("https://pinforyou.online/userCard/payRecommend",
                   method: .get,
                   parameters: ["user_id" : userid,
                                "store_name" : storeName,
                                "category" : storeCategory],
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type" : "application/json"])
        //.validate(statusCode: 200 ..< 300)
        .responseDecodable(of: PayCardModel.self) { [weak self] response in
            guard case .success(let data) = response.result
            else {
                debugPrint(response)
                return completion(.failure(LocationError.APICallFailed))
            }
            
            
            completion(.success(.init(CardList: data.CardList)))
            
            
        }
    }
    
    private func getCardQrCode(completion: @escaping (Result<UIImage, Error>) -> Void) {
        AF.request("https://pinforyou.online/userCard/pay",
                   method: .get,
                   parameters: ["user_id" : 1,
                                "card_id" : 14],
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: String.self) { [weak self] response in
            debugPrint(response)
        }
    }
}

class StubPayService : PayServiceType {
    
    func getPayRecommendCardInfo(userid : Int, storeName : String, storeCategory : String) -> AnyPublisher<PayCardModel, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func getCardQrCode() -> AnyPublisher<UIImage, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
