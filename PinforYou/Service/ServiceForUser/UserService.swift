//
//  UserService.swift
//  PinforYou
//
//  Created by 박진성 on 5/2/24.
//

import Foundation
import Combine
import Alamofire

protocol UserServiceType {
    func getCardInfo() -> AnyPublisher<CardInfo, ServiceError>
    func getPaymentInfo(cardid : Int) -> AnyPublisher<PaymentInfo, ServiceError>
    func getRecommendCardInfo(userid : Int) -> AnyPublisher<RecommendCardInfo, ServiceError>
    func cardValidation(cardNum: String) -> AnyPublisher<ValidityCard, ServiceError>
    func cardAppend(userid: Int, cardNum:String, cardName: String) -> AnyPublisher<Bool, ServiceError>
}

class UserService : UserServiceType {
    
    func getCardInfo() -> AnyPublisher<CardInfo, ServiceError> {
        Future { [weak self] promise in
            self?.getCardInfo { result in
                switch result {
                case let .success(CardInfo):
                    promise(.success(CardInfo))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
            
        }.eraseToAnyPublisher()
    }
    
    func getPaymentInfo(cardid : Int) -> AnyPublisher<PaymentInfo, ServiceError> {
        Future { [weak self] promise in
            self?.getPaymentInfo(cardid: cardid) { result in
                switch result {
                case let .success(PaymentInfo):
                    promise(.success(PaymentInfo))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
            
        }.eraseToAnyPublisher()
    }
    
    func getRecommendCardInfo(userid: Int) -> AnyPublisher<RecommendCardInfo, ServiceError> {
        Future { [weak self] promise in
            self?.getRecommendCardInfo(userid: userid) { result in
                switch result {
                case let .success(RecommendCardInfo):
                    promise(.success(RecommendCardInfo))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
            
        }.eraseToAnyPublisher()
    }
    
    func cardValidation(cardNum: String) -> AnyPublisher<ValidityCard, ServiceError> {
        Future { [weak self] promise in
            self?.cardValidation(cardNum: cardNum) { result in
                switch result {
                case let .success(validityCard):
                    promise(.success(validityCard))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
            
        }.eraseToAnyPublisher()
    }
    
}

extension UserService {
    
    private func getCardInfo(completion: @escaping (Result<CardInfo, Error>) -> Void) {
        AF.request("https://pinforyou.online/userCard",
                   method: .get,
                   parameters: ["user_id" : 1],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: CardInfo.self) { [weak self] response in
            
            guard case .success(let data) = response.result
            else {
                return completion(.failure(LocationError.APICallFailed))
            }
            
            completion(.success(data))
        }
    }
    
    private func getPaymentInfo(cardid: Int, completion: @escaping (Result<PaymentInfo, Error>) -> Void) {
        AF.request("https://pinforyou.online/paymentHistory",
                   method: .get,
                   parameters: ["user_id" : 1,
                                "card_id" : cardid],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: PaymentInfo.self) { [weak self] response in
            
            guard case .success(let data) = response.result
            else {
                return completion(.failure(LocationError.APICallFailed))
            }
            
            
            completion(.success(data))
        }
    }
    
    private func getRecommendCardInfo(userid: Int, completion: @escaping (Result<RecommendCardInfo, Error>) -> Void) {
        AF.request("https://pinforyou.online/userCard/newCardRecommend",
                   method: .get,
                   parameters: ["user_id" : userid],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: RecommendCardInfo.self) { [weak self] response in
            
            debugPrint(response)
            guard case .success(let data) = response.result
            else {
                return completion(.failure(LocationError.APICallFailed))
            }
            
            completion(.success(data))
        }
    }
    
    private func cardValidation(cardNum: String, completion: @escaping (Result<ValidityCard, Error>) -> Void) {
        AF.request("https://pinforyou.online/userCard/classify",
                   method: .get,
                   parameters: ["number" : cardNum],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: ValidityCard.self) { [weak self] response in
            debugPrint(response)
            guard case .success(let data) = response.result
            else {
                return completion(.failure(LocationError.APICallFailed))
            }
            
            completion(.success(data))
        }
    }
}

class StubUserService : UserServiceType {
    
    func getCardInfo() -> AnyPublisher<CardInfo, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func getPaymentInfo(cardid : Int) -> AnyPublisher<PaymentInfo, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func getRecommendCardInfo(userid: Int) -> AnyPublisher<RecommendCardInfo, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func cardValidation(cardNum: String) -> AnyPublisher<ValidityCard, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
