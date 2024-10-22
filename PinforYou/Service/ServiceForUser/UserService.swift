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
    func getCardInfo(id: String) -> AnyPublisher<CardInfo, ServiceError>
    func getPaymentInfo(userid: String, cardid : Int, year: Int, month: Int) -> AnyPublisher<PaymentInfo, ServiceError>
    func getRecommendCardInfo(userid : Int) -> AnyPublisher<RecommendCardInfo, ServiceError>
    func cardValidation(cardNum: String) -> AnyPublisher<ValidityCard, ServiceError>
    func cardAppend(userid: String, cardNum:String, cardName: String) -> AnyPublisher<Bool, ServiceError>
    func cardDelete(userid: String, cardid: Int) -> AnyPublisher<Bool, ServiceError>
}

class UserService : UserServiceType {
    
    func getCardInfo(id: String) -> AnyPublisher<CardInfo, ServiceError> {
        Future { [weak self] promise in
            self?.getCardInfo(id: id) { result in
                switch result {
                case let .success(CardInfo):
                    promise(.success(CardInfo))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
            
        }.eraseToAnyPublisher()
    }
    
    func getPaymentInfo(userid: String, cardid: Int, year: Int, month: Int) -> AnyPublisher<PaymentInfo, ServiceError> {
        Future { [weak self] promise in
            self?.getPaymentInfo(userid: userid, cardid: cardid, year: year, month: month) { result in
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
    
    private func getCardInfo(id: String, completion: @escaping (Result<CardInfo, Error>) -> Void) {
        AF.request("https://pinforyou.online/userCard",
                   method: .get,
                   parameters: ["hashed_id" : id],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: CardInfo.self) { [weak self] response in
            debugPrint(response)
            guard case .success(let data) = response.result
            else {
                return completion(.failure(LocationError.APICallFailed))
            }
            
            completion(.success(data))
        }
    }
    
    private func getPaymentInfo(userid: String, cardid: Int, year: Int, month: Int, completion: @escaping (Result<PaymentInfo, Error>) -> Void) {
        AF.request("https://pinforyou.online/paymentHistory",
                   method: .get,
                   parameters: ["hashed_id" : userid,
                                "card_id" : cardid,
                                "year" : 2024,
                                "month" : 7],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: PaymentInfo.self) { [weak self] response in
            debugPrint(response)
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
            guard case .success(let data) = response.result
            else {
                return completion(.failure(LocationError.APICallFailed))
            }
            
            completion(.success(data))
        }
    }
}

class StubUserService : UserServiceType {
    func getCardInfo(id: String) -> AnyPublisher<CardInfo, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func getPaymentInfo(userid: String, cardid: Int, year: Int, month: Int) -> AnyPublisher<PaymentInfo, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func getRecommendCardInfo(userid: Int) -> AnyPublisher<RecommendCardInfo, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func cardValidation(cardNum: String) -> AnyPublisher<ValidityCard, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
