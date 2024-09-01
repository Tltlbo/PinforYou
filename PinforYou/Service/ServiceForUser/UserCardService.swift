//
//  UserCardService.swift
//  PinforYou
//
//  Created by 박진성 on 8/24/24.
//

import Foundation
import Combine
import Alamofire

extension UserService {
    func cardAppend(userid: Int, cardNum:String, cardName: String) -> AnyPublisher<Bool, ServiceError> {
        Future { [weak self] promise in
            self?.cardAppend(userid: userid, cardNum: cardNum, cardName: cardName) { result in
                switch result {
                case let .success(iscomplete):
                    promise(.success(iscomplete))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
            
        }.eraseToAnyPublisher()
    }
    
    func cardDelete(userid: Int, cardid: Int) -> AnyPublisher<Bool, ServiceError> {
        Future { [weak self] promise in
            self?.cardDelete(userid: userid, cardid: cardid) { result in
                switch result {
                case let .success(iscomplete):
                    promise(.success(iscomplete))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
            
        }.eraseToAnyPublisher()
    }
}

//private 메서드
extension UserService {
    private func cardAppend(userid: Int, cardNum:String, cardName: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        struct cardAppendCheck: Decodable {
            let result: Bool
        }
        
        AF.request("https://pinforyou.online/userCard",
                   method: .post,
                   parameters: ["user_id": userid,
                                "card_number": cardNum,
                                "card_name": cardName],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: cardAppendCheck.self) { [weak self] response in
            debugPrint(response)
            guard case .success(let data) = response.result
            else {
                return completion(.failure(LocationError.APICallFailed))
            }
            
            completion(.success(data.result))
        }
    }
    
    private func cardDelete(userid: Int, cardid: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        struct cardDeleteCheck: Decodable {
            let result: Bool
        }
        
        AF.request("https://pinforyou.online/userCard",
                   method: .delete,
                   parameters: ["card_id": cardid,
                                "user_id": userid],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: cardDeleteCheck.self) { [weak self] response in
            debugPrint(response)
            guard case .success(let data) = response.result
            else {
                return completion(.failure(LocationError.APICallFailed))
            }
            
            completion(.success(data.result))
        }
    }
}

extension StubUserService {
    func cardAppend(userid: Int, cardNum: String, cardName: String) -> AnyPublisher<Bool, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func cardDelete(userid: Int, cardid: Int) -> AnyPublisher<Bool, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
