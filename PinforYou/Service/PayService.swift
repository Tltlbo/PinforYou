//
//  PayService.swift
//  PinforYou
//
//  Created by 박진성 on 6/14/24.
//

import Foundation
import Alamofire
import Combine
import SwiftUI
import Kingfisher

protocol PayServiceType {
    func getPayRecommendCardInfo(userid : String, storeName : String, storeCategory : String) -> AnyPublisher<PayCardModel, ServiceError>
    func getCardQrCode(userid: String, cardid : Int) -> AnyPublisher<String, ServiceError>
}

class PayService : PayServiceType {
    func getPayRecommendCardInfo(userid : String, storeName : String, storeCategory : String) -> AnyPublisher<PayCardModel, ServiceError> {
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
    
    func getCardQrCode(userid: String, cardid: Int) -> AnyPublisher<String, ServiceError> {
        Future { [weak self] promise in
            self?.getCardQrCode(userid: userid, cardid: cardid){ result in
                switch result {
                case let .success(image_url):
                    promise(.success(image_url))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
}

extension PayService {
    private func getPayRecommendCardInfo(userid : String, storeName : String, storeCategory : String, completion: @escaping (Result<PayCardModel, Error>) -> Void) {
        
        AF.request("https://pinforyou.online/userCard/payRecommend",
                   method: .get,
                   parameters: ["hashed_id" : userid,
                                "store_name" : storeName,
                                "category" : storeCategory],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: PayCardModel.self) { [weak self] response in
            
            guard case .success(let data) = response.result
            else {
                return completion(.failure(LocationError.APICallFailed))
            }
            
            
            completion(.success(.init(CardList: data.CardList)))
            
        }
    }
    
    private func getCardQrCode(userid: String, cardid: Int, completion: @escaping (Result<String, Error>) -> Void) {
        
        class Data : Decodable  {
            let result: Bool
            let image_url: String
        }
        
        AF.request("https://pinforyou.online/userCard/pay",
                   method: .get,
                   parameters: ["hashed_id" : userid,
                                "card_id" : cardid],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: Data.self) { [weak self] response in
            guard case .success(let data) = response.result
            else {
                return completion(.failure(LocationError.APICallFailed))
            }
            
            return completion(.success(data.image_url))
        
        }
    }
    
    
}

class StubPayService : PayServiceType {
    
    func getPayRecommendCardInfo(userid : String, storeName : String, storeCategory : String) -> AnyPublisher<PayCardModel, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func getCardQrCode(userid: String, cardid: Int) -> AnyPublisher<String, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
