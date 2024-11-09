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
    func getChallengeInfo(userid : String) -> AnyPublisher<Challenges, ServiceError>
}

class ChallengeService : ChallengeServiceType {
    
    func getChallengeInfo(userid : String) -> AnyPublisher<Challenges, ServiceError> {
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
    
    private func getChallengeInfo(userid: String, completion: @escaping (Result<Challenges, Error>) -> Void) {
        AF.request("https://pinforyou.online/Challenge/UserProgress",
                   method: .get,
                   parameters: ["hashed_id" : userid],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: Challenges.self) { [weak self] response in
            
            guard case .success(let data) = response.result
            else {
                return completion(.failure(ChallengeError.FailedfetchChallenge))
            }
            
            
            completion(.success(data))
        }
    }
}

class StubChallengeService : ChallengeServiceType {
    
    func getChallengeInfo(userid: String) -> AnyPublisher<Challenges, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
