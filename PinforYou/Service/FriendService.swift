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
    func getFriendInfo(userid : Int) -> AnyPublisher<Friends, ServiceError>
    func getRequestFriendInfo(userid : Int) -> AnyPublisher<RequestFriend, ServiceError>
}

class FriendService : FriendServiceType {
    
    func getFriendInfo(userid : Int) -> AnyPublisher<Friends, ServiceError> {
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
    
    func getRequestFriendInfo(userid : Int) -> AnyPublisher<RequestFriend, ServiceError> {
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
}

extension FriendService {
    
    private func getFriendInfo(userid : Int, completion: @escaping (Result<Friends, Error>) -> Void)  {
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
    
    private func getRequestFriendInfo(userid : Int, completion: @escaping (Result<RequestFriend, Error>) -> Void) {
        AF.request("https://pinforyou.online/friend/request",
                   method: .get,
                   parameters: ["user_id" : userid],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: RequestFriend.self) { [weak self] response in
            
            debugPrint(response)
            print("HO")
            guard case .success(let data) = response.result
            else {
                return completion(.failure(FriendError.FailedfetchFriend))
            }
    
            completion(.success(data))
        }
    }
    
    
}

class StubFriendService : FriendServiceType {
    func getRequestFriendInfo(userid: Int) -> AnyPublisher<RequestFriend, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func getFriendInfo(userid: Int) -> AnyPublisher<Friends, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
        
}
