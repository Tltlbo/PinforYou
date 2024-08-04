//
//  ChallengeService.swift
//  PinforYou
//
//  Created by 박진성 on 8/3/24.
//

import Foundation
import Combine
import Alamofire

enum ChallengeError : Error {
    case FailedfetchChallenge
}

protocol ChallengeServiceType {
    func getChallengeInfo(userid : Int) -> AnyPublisher<[Challenge], ServiceError>
}

class ChallengeService : ChallengeServiceType {
    
    func getChallengeInfo(userid : Int = 1) -> AnyPublisher<[Challenge], ServiceError> {
        Future { [weak self] promise in
            self?.getChallengeInfo(userid: userid) { result in
                switch result {
                case let .success(Challenge):
                    promise(.success(Challenge))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
}

extension ChallengeService {
    
    private func getChallengeInfo(userid: Int = 1, completion: @escaping (Result<[Challenge], Error>) -> Void) {
        AF.request("https://pinforyou.online/Challenge/UserProgress",
                   method: .get,
                   parameters: ["user_id" : 1],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: [Challenge].self) { [weak self] response in
            
            guard case .success(let data) = response.result
            else {
                return completion(.failure(ChallengeError.FailedfetchChallenge))
            }
            
            
            completion(.success(data))
        }
    }
}

class StubChallengeService : ChallengeServiceType {
    
    func getChallengeInfo(userid: Int) -> AnyPublisher<[Challenge], ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
