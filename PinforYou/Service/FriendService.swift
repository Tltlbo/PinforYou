//
//  FriendService.swift
//  PinforYou
//
//  Created by 박진성 on 8/4/24.
//

import Foundation
import Combine
import Alamofire

enum FriendError : Error {
    case FailedfetchFriend
}

protocol FriendServiceType {
    func getFriendInfo(userid : String) -> AnyPublisher<Friends, ServiceError>
    func getRequestFriendInfo(userid : String) -> AnyPublisher<RequestFriend, ServiceError>
    func deleteFriendInfo(userid: String, friendid: Int) -> AnyPublisher<Bool, ServiceError>
    func acceptRequestFriend(userid: String, friendid: Int) -> AnyPublisher<Bool, ServiceError>
}

class FriendService : FriendServiceType {
    
    func getFriendInfo(userid : String) -> AnyPublisher<Friends, ServiceError> {
        Future { [weak self] promise in
            self?.getFriendInfo(userid: userid) { result in
                switch result {
                case let .success(FriendInfo):
                    promise(.success(FriendInfo))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getRequestFriendInfo(userid : String) -> AnyPublisher<RequestFriend, ServiceError> {
        Future { [weak self] promise in
            self?.getRequestFriendInfo(userid: userid) { result in
                switch result {
                case let .success(FriendInfo):
                    promise(.success(FriendInfo))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteFriendInfo(userid : String, friendid: Int) -> AnyPublisher<Bool, ServiceError> {
        Future { [weak self] promise in
            self?.deleteFriendInfo(userid: userid, friendid: friendid) { result in
                switch result {
                case let .success(result):
                    promise(.success(result))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func acceptRequestFriend(userid: String, friendid: Int) -> AnyPublisher<Bool, ServiceError> {
        Future { [weak self] promise in
            self?.acceptRequestFriend(userid: userid, friendid: friendid) { result in
                switch result {
                case let .success(result):
                    promise(.success(result))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
}

extension FriendService {
    
    private func getFriendInfo(userid : String, completion: @escaping (Result<Friends, Error>) -> Void)  {
        AF.request("https://pinforyou.online/friend",
                   method: .get,
                   parameters: ["user_id" : userid],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: Friends.self) { [weak self] response in
            
            debugPrint(response)
            guard case .success(let data) = response.result
            else {
                return completion(.failure(FriendError.FailedfetchFriend))
            }
    
            completion(.success(data))
        }
    }
    
    private func getRequestFriendInfo(userid : String, completion: @escaping (Result<RequestFriend, Error>) -> Void) {
        AF.request("https://pinforyou.online/friend/request",
                   method: .get,
                   parameters: ["user_id" : userid],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: RequestFriend.self) { [weak self] response in
            guard case .success(let data) = response.result
            else {
                return completion(.failure(FriendError.FailedfetchFriend))
            }
    
            completion(.success(data))
        }
    }
    
    private func deleteFriendInfo(userid: String, friendid: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        struct Result: Decodable {
            let result: Bool
            let message: String
            
            enum CodingKeys: String, CodingKey {
                case result = "result"
                case message = "message"
            }
        }
        AF.request("https://pinforyou.online/friend/delete",
                   method: .get,
                   parameters: ["user_hashedId" : userid,
                                "friend_hashedId" : friendid],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: Result.self) { [weak self] response in
            debugPrint(response)
            guard case .success(let data) = response.result
            else {
                return completion(.failure(FriendError.FailedfetchFriend))
            }
    
            completion(.success(data.result))
        }
    }
    
    private func acceptRequestFriend(userid: String, friendid: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        struct Result: Decodable {
            let result: Bool
            let message: String
            
            enum CodingKeys: String, CodingKey {
                case result = "result"
                case message = "message"
            }
        }
        AF.request("https://pinforyou.online/friend/requestList/accept",
                   method: .get,
                   parameters: ["user_hashedId" : userid,
                                "friend_hashedId" : friendid],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: Result.self) { [weak self] response in
            debugPrint(response)
            guard case .success(let data) = response.result
            else {
                return completion(.failure(FriendError.FailedfetchFriend))
            }
    
            completion(.success(data.result))
        }
    }
}

class StubFriendService : FriendServiceType {
    func getRequestFriendInfo(userid: String) -> AnyPublisher<RequestFriend, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func getFriendInfo(userid: String) -> AnyPublisher<Friends, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func deleteFriendInfo(userid: String, friendid: Int) -> AnyPublisher<Bool, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func acceptRequestFriend(userid: String, friendid: Int) -> AnyPublisher<Bool, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
