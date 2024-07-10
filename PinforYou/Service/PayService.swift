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
    func getPayRecommendCardInfo(userid : Int, storeName : String, storeCategory : String) -> AnyPublisher<PayCardModel, ServiceError>
    func getCardQrCode(cardid : Int) -> AnyPublisher<UIImageView, ServiceError>
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
    
    func getCardQrCode(cardid: Int) -> AnyPublisher<UIImageView, ServiceError> {
        Future { [weak self] promise in
            self?.getCardQrCode(cardid: cardid){ result in
                switch result {
                case let .success(UIImageView):
                    promise(.success(UIImageView))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
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
    
    private func getCardQrCode(cardid: Int, completion: @escaping (Result<UIImageView, Error>) -> Void) {
        
        class Data : Decodable  {
            var body : String
            var statusCode : String
            var statusCodeValue : Int
            
            enum CodingKeys: String, CodingKey {
                case body = "body"
                case statusCode = "statusCode"
                case statusCodeValue = "statusCodeValue"
            }
        }
        
        AF.request("https://pinforyou.online/userCard/pay",
                   method: .get,
                   parameters: ["user_id" : 1,
                                "card_id" : cardid],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: Data.self) { [weak self] response in
            guard case .success(let data) = response.result
            else {
                return completion(.failure(LocationError.APICallFailed))
            }
            let provider = Base64ImageDataProvider(base64String: data.body, cacheKey: "QR")
            
            let imageView : UIImageView = UIImageView()
            
            imageView.kf.setImage(with: provider)
            
            return completion(.success(imageView))
        
        }
    }
    
    
}

class StubPayService : PayServiceType {
    
    func getPayRecommendCardInfo(userid : Int, storeName : String, storeCategory : String) -> AnyPublisher<PayCardModel, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func getCardQrCode(cardid: Int) -> AnyPublisher<UIImageView, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
