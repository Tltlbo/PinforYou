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
    func getPaymentInfo() -> AnyPublisher<PaymentInfo, ServiceError>

    
}

class UserService : UserServiceType {
    
    func getPaymentInfo() -> AnyPublisher<PaymentInfo, ServiceError> {
        Future { [weak self] promise in
            self?.getPaymentInfo { result in
                switch result {
                case let .success(PaymentInfo):
                    promise(.success(PaymentInfo))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
            
        }.eraseToAnyPublisher()
    }
    
}

extension UserService {
    private func getPaymentInfo(completion: @escaping (Result<PaymentInfo, Error>) -> Void) {
        AF.request("https://pinforyou.online/paymentHistory",
                   method: .get,
                   parameters: ["user_id" : 1,
                                "card_id" : 14],
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
}

class StubUserService : UserServiceType {
    func getPaymentInfo() -> AnyPublisher<PaymentInfo, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    
    
}
