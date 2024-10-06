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
    func handleSignInWithAppleRequest(_ request: ASAuthorizationAppleIDRequest) -> String
    func handleSignInWithAppleCompletion(_ authorization: ASAuthorization, none: String) -> AnyPublisher<User, ServiceError>
    func logout() /*-> AnyPublisher<Void, ServiceError>*/
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
    
    func handleSignInWithAppleRequest(_ request: ASAuthorizationAppleIDRequest) -> String {
        request.requestedScopes = [.fullName, .email]
        let nonce = randomNonceString()
        request.nonce = sha256(nonce)
        return nonce
    }
    
    func handleSignInWithAppleCompletion(_ authorization: ASAuthorization, none: String) -> AnyPublisher<User, ServiceError> {
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
    
    private func handleSignInWithAppleCompletion(_ authorization: ASAuthorization,
                                                 nonce: String,
                                                 completion: @escaping (Result<User, Error>) -> Void) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let appleIDToken = appleIDCredential.identityToken else {
            completion(.failure(AuthenticationError.tokenError))
            return
        }
        
        
        
        guard let authrizaitionCode = appleIDCredential.authorizationCode else {return}
        
        guard let data = String(data:authrizaitionCode, encoding: .utf8) else {return}
        
        struct test : Decodable {
            var ID : String
            
            enum CodingKeys : String, CodingKey {
                case ID = "userId"
            }
        }
        
        AF.request("http://pinforyou-apiserver-main-env.eba-ixdz2ipf.ap-northeast-2.elasticbeanstalk.com/api/v1/apple/login",
                   method: .post,
                   parameters: ["authorizationCode" : data],
                   encoding: URLEncoding.default,
                   headers: ["Content-Type" : "application/x-www-form-urlencoded"])
        .responseDecodable(of:test.self) { response in
            debugPrint(response)
        }
        
        
        
        
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            completion(.failure(AuthenticationError.tokenError))
            return
        }
        
        var check = true
        var checkuser : User = .init(id: "hi", name: "SD")
        
        if check {
            checkuser.name = [appleIDCredential.fullName?.givenName,
                        appleIDCredential.fullName?.familyName]
                .compactMap {$0}
                .joined(separator: " ")
            completion(.success(checkuser))
        }
        else {
            completion(.failure(AuthenticationError.invaildated))
        }
        
        //TODO: 서버에 appleIDCredential.authorizationCode 넘기기
        
//        let credential = OAuthProvider.credential(
//            withProviderID:"apple.com",
//                                                   idToken: idTokenString,
//                                                   rawNonce: nonce)
//        
//        authenticateUserWithFirebase(credential: credential) { result in
//            switch result {
//            case var .success(user):
//                user.name = [appleIDCredential.fullName?.givenName,
//                            appleIDCredential.fullName?.familyName]
//                    .compactMap { $0 }
//                    .joined(separator: " ")
//                completion(.success(user))
//            case let .failure(error):
//                completion(.failure(error))
//            }
//        }
        
    }
    
    //MARK: 서버에 ios 인가코드 전송
    private func authenticateUserWithApple(auth_code: String, completion: @escaping (Result<User, Error>) -> Void) {
        /*Auth.auth().signIn(with: credential) { result, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let result else {
                completion(.failure(AuthenticationError.invaildated))
                return
            }
            
            let firebaseUser = result.user
            let user : User = .init(id: firebaseUser.uid,
                                    name: firebaseUser.displayName ?? "",
                                    phoneNumber: firebaseUser.phoneNumber,
                                    profileURL: firebaseUser.photoURL?.absoluteString)
            completion(.success(user))
        }
         */
        
        
    }
    
    private func authenticateUserWithFirebase(auth_code: String/*AuthCredential*/, completion: @escaping (Result<User, Error>) -> Void) {
        /*Auth.auth().signIn(with: credential) { result, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let result else {
                completion(.failure(AuthenticationError.invaildated))
                return
            }
            
            let firebaseUser = result.user
            let user : User = .init(id: firebaseUser.uid,
                                    name: firebaseUser.displayName ?? "",
                                    phoneNumber: firebaseUser.phoneNumber,
                                    profileURL: firebaseUser.photoURL?.absoluteString)
            completion(.success(user))
        }
         */
    }
}


class StubAuthenticationService : AuthenticationServiceType {
    
    func checkAuthenticationState() /*-> String?*/ {
        //return nil
    }
    
    func signInWithGoogle() -> AnyPublisher<(result: Bool, hashedID: String), ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func handleSignInWithAppleRequest(_ request: ASAuthorizationAppleIDRequest) -> String {
        return ""
    }
    func handleSignInWithAppleCompletion(_ authorization: ASAuthorization, none: String) -> AnyPublisher<User, ServiceError> {
        return Empty().eraseToAnyPublisher()
    }
    
    func logout() /*-> AnyPublisher<Void, ServiceError>*/ {
        //return Empty().eraseToAnyPublisher()
    }
}

struct testID : Decodable {
    
        var userId : String
        
        
    
    enum CodingKeys : String, CodingKey {
        case userId = "userId"
    }
    
}
