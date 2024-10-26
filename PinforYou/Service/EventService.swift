//
//  EventService.swift
//  PinforYou
//
//  Created by 박진성 on 8/12/24.
//

import Foundation
import Combine
import Alamofire

enum EventError : Error {
    case FailedfetchEvent
}

protocol EventServiceType {
    func getEventInfo() -> AnyPublisher<Event, ServiceError>
}

class EventService : EventServiceType {
    
    func getEventInfo() -> AnyPublisher<Event, ServiceError> {
        Future { [weak self] promise in
            self?.getEventInfo() { result in
                switch result {
                case let .success(Event):
                    promise(.success(Event))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
            
        }.eraseToAnyPublisher()
    }
    
}

extension EventService {
    
    private func getEventInfo(completion: @escaping (Result<Event, Error>) -> Void)  {
        AF.request("https://pinforyou.online/event",
                   method: .get,
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: Event.self) { [weak self] response in
            debugPrint(response)
            guard case .success(let data) = response.result
            else {
                return completion(.failure(FriendError.FailedfetchFriend))
            }
            
            completion(.success(data))
        }
    }
}

class StubEventService : EventServiceType {
    func getEventInfo() -> AnyPublisher<Event, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
        
}
