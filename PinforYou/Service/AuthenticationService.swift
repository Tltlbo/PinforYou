//
//  AuthenticationService.swift
//  PinforYou
//
//  Created by 박진성 on 5/2/24.
//

import Foundation
import Combine
import AuthenticationServices
import GoogleSignIn
import Alamofire



enum AuthenticationError : Error {
    case clientIDError
    case tokenError
    case invaildated
}

protocol AuthenticationServiceType {
    func checkAuthenticationState() /*-> String?*/
    func signInWithGoogle() -> AnyPublisher<(result: Bool, hashedID: String), ServiceError>
    func signInWithKakao(email: String, name: String) -> AnyPublisher<(result: Bool, hashedID: String), ServiceError>
    func handleSignInWithAppleRequest(_ request: ASAuthorizationAppleIDRequest) -> String
    func handleSignInWithAppleCompletion(_ authorization: ASAuthorization, none: String) -> AnyPublisher<(result: Bool, hashedID: String), ServiceError>
    func requestVerifyEmail(email: String) -> AnyPublisher<Bool, ServiceError>
    func logout() /*-> AnyPublisher<Void, ServiceError>*/
    func signUp(userName: String, gender: Gender, phoneNumber: String, age: String, interest: String, hashedID: String) -> AnyPublisher<Bool, ServiceError>
}

class AuthenticationService : AuthenticationServiceType {
    
    func checkAuthenticationState() /*-> String?*/ {
//        if let user = Auth.auth().currentUser {
//            return user.uid
//        } else {
//            return nil
//        }
    }
    
    func signInWithGoogle() -> AnyPublisher<(result: Bool, hashedID: String), ServiceError> {
        Future { [weak self] promise in
            self?.signInWithGoogle { result in
                switch result {
                case let .success(user):
                    promise(.success(user))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func signInWithKakao(email: String, name: String) -> AnyPublisher<(result: Bool, hashedID: String), ServiceError> {
        Future { [weak self] promise in
            self?.signInWithKakao(email: email, name: name) { result in
                switch result {
                case let .success(user):
                    promise(.success(user))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func handleSignInWithAppleRequest(_ request: ASAuthorizationAppleIDRequest) -> String {
        request.requestedScopes = [.fullName, .email]
        let nonce = randomNonceString()
        request.nonce = sha256(nonce)
        return nonce
    }
    
    func handleSignInWithAppleCompletion(_ authorization: ASAuthorization, none: String) -> AnyPublisher<(result: Bool, hashedID: String), ServiceError> {
        Future { [weak self] promise in
            self?.handleSignInWithAppleCompletion(authorization, nonce: none) { result in
                switch result {
                case let .success(user):
                    promise(.success(user))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func logout() /*-> AnyPublisher<Void, ServiceError>*/ {
        
        /*Future { promise in
            do {
                try Auth.auth().signOut()
                promise(.success(()))
            } catch {
                promise(.failure(.error(error)))
            }
        }
        .eraseToAnyPublisher()*/
    }
    
    func requestVerifyEmail(email: String) -> AnyPublisher<Bool, ServiceError> {
        Future { [weak self] promise in
            self?.requestVerifyEmail(email: email) { result in
                switch result {
                case let .success(result):
                    promise(.success(result))
                    
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func signUp(userName: String, gender: Gender, phoneNumber: String, age: String, interest: String, hashedID: String) -> AnyPublisher<Bool, ServiceError> {
        Future { [weak self] promise in
            self?.signUp(userName: userName, gender: gender, phoneNumber: phoneNumber, age: age, interest: interest, hashedID: hashedID) { result in
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

extension AuthenticationService {
    private func signInWithGoogle(completion: @escaping (Result<(result: Bool, hashedID: String), Error>) -> Void) {
        //구글 로그인이 진행 될 때 구글 로그인 창이 팝업 되어 나올 수 있게 하는 것
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            return
        }
        
        let config = GIDConfiguration(clientID: Key.googleClientID.rawValue)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                completion(.failure(AuthenticationError.tokenError))
                return
            }
            
            let accessToken = user.accessToken.tokenString
            
            guard let email = user.profile?.email,
                  let name = user.profile?.name else {return}
            //TODO: 서버에 던지기
            
            struct test : Decodable {
                let result: Bool
                let hashedId: String
            }
            
            AF.request("https://pinforyou.online/user/checkLogin",
                       method: .post,
                       parameters: ["username" : name,
                                    "email" : email],
                       encoding: URLEncoding.queryString,
                       headers: ["Content-Type" : "application/json"])
            .responseDecodable(of:test.self) { response in
                debugPrint(response)
                guard case .success(let data) = response.result
                else {
                    return completion(.failure(FriendError.FailedfetchFriend))
                }
        
                completion(.success((data.result, data.hashedId)))
            }
        }
    }
    
    private func signInWithKakao(email: String, name: String, completion: @escaping (Result<(result: Bool, hashedID: String), Error>) -> Void) {
        
        struct test : Decodable {
            let result: Bool
            let hashedId: String
        }
        
        AF.request("https://pinforyou.online/user/checkLogin",
                   method: .post,
                   parameters: ["username" : name,
                                "email" : email],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of:test.self) { response in
            debugPrint(response)
            guard case .success(let data) = response.result
            else {
                return completion(.failure(FriendError.FailedfetchFriend))
            }
    
            completion(.success((data.result, data.hashedId)))
        }
    }
    
    private func handleSignInWithAppleCompletion(_ authorization: ASAuthorization,
                                                 nonce: String,
                                                 completion: @escaping (Result<(result: Bool, hashedID: String), Error>) -> Void) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let appleIDToken = appleIDCredential.identityToken else {
            completion(.failure(AuthenticationError.tokenError))
            return
        }
        
        guard let authrizaitionCode = appleIDCredential.authorizationCode else {return}
        guard let data = String(data:authrizaitionCode, encoding: .utf8) else {return}
        
        struct test : Decodable {
            let hashed_ID: String
            let result: Bool
        
            enum CodingKeys : String, CodingKey {
                case hashed_ID = "hashed_id"
                case result = "result"
            }
        }
        
        AF.request("http://pinforyou-apiserver-main-env.eba-ixdz2ipf.ap-northeast-2.elasticbeanstalk.com/api/v1/apple/login",
                   method: .post,
                   parameters: ["authorizationCode" : data],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/x-www-form-urlencoded"])
        .responseDecodable(of:test.self) { response in
            debugPrint(response)
            guard case .success(let data) = response.result
            else {
                return completion(.failure(AuthenticationError.invaildated))
            }
    
            completion(.success((data.result, data.hashed_ID)))
        }
        
        
    }
    
    private func signUp(userName: String, gender: Gender, phoneNumber: String, age: String, interest: String, hashedID: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        struct Result: Decodable {
            let result: Bool
        }
        
        AF.request("https://pinforyou.online/social/join",
                   method: .post,
                   parameters: ["username" : userName,
                                "sex" : gender.rawValue,
                                "tel" : phoneNumber,
                                "age" : Int(age)!,
                                "interest" : interest,
                                "hashed_id" : hashedID],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/json"])
        .responseDecodable(of: Result.self) { response in
            debugPrint(response)
            guard case .success(let data) = response.result
            else {
                return completion(.failure(AuthenticationError.invaildated))
            }
    
            completion(.success((data.result)))
        }
    }
    
    private func requestVerifyEmail(email: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        AF.request("https://pinforyou.online/emails/verification-requests",
                   method: .post,
                   parameters: ["email" : email],
                   encoding: URLEncoding.queryString,
                   headers: ["Content-Type" : "application/x-www-form-urlencoded"])
        .responseDecodable(of: Bool.self) { response in
        }
    }
}


class StubAuthenticationService : AuthenticationServiceType {
    func checkAuthenticationState() /*-> String?*/ {
        //return nil
    }
    
    func signInWithGoogle() -> AnyPublisher<(result: Bool, hashedID: String), ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func signInWithKakao(email: String, name: String) -> AnyPublisher<(result: Bool, hashedID: String), ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func handleSignInWithAppleRequest(_ request: ASAuthorizationAppleIDRequest) -> String {
        return ""
    }
    func handleSignInWithAppleCompletion(_ authorization: ASAuthorization, none: String) -> AnyPublisher<(result: Bool, hashedID: String), ServiceError> {
        return Empty().eraseToAnyPublisher()
    }
    
    func logout() /*-> AnyPublisher<Void, ServiceError>*/ {
        //return Empty().eraseToAnyPublisher()
    }
    
    func requestVerifyEmail(email: String) -> AnyPublisher<Bool, ServiceError> {
        return Empty().eraseToAnyPublisher()
    }
    
    func signUp(userName: String, gender: Gender, phoneNumber: String, age: String, interest: String, hashedID: String) -> AnyPublisher<Bool, ServiceError> {
        return Empty().eraseToAnyPublisher()
    }
}

struct testID : Decodable {
    
        var userId : String
        
        
    
    enum CodingKeys : String, CodingKey {
        case userId = "userId"
    }
    
}
