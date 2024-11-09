//
//  OwnerPayService.swift
//  PinforYou
//
//  Created by 박진성 on 6/18/24.
//

import Foundation
import Combine
import Alamofire

protocol OwnerPayServiceType {
    func storePaymentInfo(cardid: Int, amount : Int) -> AnyPublisher<String, ServiceError>
}

class OwnerPayService : OwnerPayServiceType {
    func storePaymentInfo(cardid: Int, amount : Int) -> AnyPublisher<String, ServiceError> {
        Future { [weak self] promise in
            self?.storePaymentInfo(cardid: cardid, amount: amount) { result in
                switch result {
                case let .success(String):
                    promise(.success(String))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
}

extension OwnerPayService {
    private func storePaymentInfo(cardid: Int, amount: Int, completion: @escaping (Result<String, Error>) -> Void) {
        AF.request("https://pinforyou.online/paymentHistory",
                   method: .post,
                   parameters: ["user_id" : 1,
                                "card_id" : cardid,
                                "pay_amount" : amount,
                                "store_name" : "CU 영남대점",
                                "category" : "편의점"],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: String.self) { [weak self] response in
            
            
            guard case .success(let data) = response.result
            else {
                return completion(.failure(LocationError.APICallFailed))
            }
            
            
            completion(.success(data))
        }
    }
}

class StubOwnerPayService : OwnerPayServiceType {
    func storePaymentInfo(cardid: Int, amount : Int) -> AnyPublisher<String, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
