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
    func storePaymentInfo() -> AnyPublisher<String, ServiceError>
}

class OwnerPayService : OwnerPayServiceType {
    func storePaymentInfo() -> AnyPublisher<String, ServiceError> {
        Future { [weak self] promise in
            self?.storePaymentInfo { result in
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
    private func storePaymentInfo(completion: @escaping (Result<String, Error>) -> Void) {
        AF.request("https://pinforyou.online/paymentHistory",
                   method: .post,
                   parameters: ["user_id" : 1,
                                "card_id" : 14,
                                "pay_amount" : 1000,
                                "store_name" : "CU 영남대점",
                                "category" : "편의점"],
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: String.self) { [weak self] response in
            debugPrint(response)
        }
    }
}

class StubOwnerPayService : OwnerPayServiceType {
    func storePaymentInfo() -> AnyPublisher<String, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
