//
//  AuthenticationViewModel.swift
//  PinforYou
//
//  Created by 박진성 on 5/2/24.
//

import Foundation
import Combine
import AuthenticationServices

enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

class AuthenticationViewModel : ObservableObject {
    
    enum Action {
        case checkAuthenticationState
        case googleLogin
        case kakaoLogin
        case appleLogin(ASAuthorizationAppleIDRequest)
        case appleLoginCompletion(Result<ASAuthorization, Error>)
        case signUp
        case logout
    }
    
    @Published var authenticationState : AuthenticationState = .unauthenticated
    //임시로 authenticated로 변경
    
    @Published var isLoading : Bool = false
    
    var userId : String?
    
    private var currentNonce : String?
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: Action, email: String? = nil, name: String? = nil, userName: String? = nil, gender: Gender? = nil, phoneNumber: String? = nil, age: String? = nil, interest: String? = nil) {
        switch action {
        case .checkAuthenticationState:
            if let id = UserDefaults.standard.string(forKey: "hashedID") {
                self.userId = id
                self.authenticationState = .authenticated
            }
            
        case .kakaoLogin:
            isLoading = true
            container.services.authService.signInWithKakao(email: email!, name: name!)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.isLoading = false
                    }
                } receiveValue: { [weak self] user in
                    if user.result {
                        self?.isLoading = false
                        self?.userId = user.hashedID
                        self?.authenticationState = .authenticated
                    }
                    else {
                        self?.isLoading = false
                        self?.userId = user.hashedID
                        self?.authenticationState = .authenticating
                    }
                    
                }.store(in: &subscriptions)
            
        case .googleLogin:
            isLoading = true
            container.services.authService.signInWithGoogle()
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.isLoading = false
                        print("false?")
                    }
                } receiveValue: { [weak self] user in
                    print("false")
                    if user.result {
                        self?.isLoading = false
                        self?.userId = user.hashedID
                        self?.authenticationState = .authenticated
                    }
                    else {
                        self?.isLoading = false
                        self?.userId = user.hashedID
                        self?.authenticationState = .authenticating
                    }
                    
                }.store(in: &subscriptions)
            
            
        case let .appleLogin(request):
            let nonce = container.services.authService.handleSignInWithAppleRequest(request)
            currentNonce = nonce
            
        case let .appleLoginCompletion(result):
            if case let .success(authorizaition) = result {
                guard let nonce = currentNonce else {return}
                
                container.services.authService.handleSignInWithAppleCompletion(authorizaition, none: nonce)
                    .sink { [weak self] completion in
                        if case .failure = completion {
                            self?.isLoading = false
                        }
                    } receiveValue: { [weak self] user in
                        if user.result {
                            self?.isLoading = false
                            self?.userId = user.hashedID
                            UserDefaults.standard.set(user.hashedID, forKey: "hashedID")
                            self?.authenticationState = .authenticated
                        }
                        else {
                            self?.isLoading = false
                            self?.userId = user.hashedID
                            self?.authenticationState = .authenticating
                        }
                    }.store(in: &subscriptions)
            } else if case let .failure(error) = result {
                isLoading = false
                print(error.localizedDescription)
            }
            
        case .logout:
            self.authenticationState = .unauthenticated
            self.userId = nil
            if let _ = UserDefaults.standard.string(forKey: "hashedID") {
                UserDefaults.standard.removeObject(forKey: "hashedID")
            }
            
        case .signUp:
            container.services.authService.signUp(userName: userName!, gender: gender!, phoneNumber: phoneNumber!, age: age!, interest: interest!, hashedID: self.userId!)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.isLoading = false
                    }
                } receiveValue: { [weak self] result in
                    if result {
                        //여기다가 아이디 저장
                        UserDefaults.standard.set(self?.userId, forKey: "hashedID")
                        self?.authenticationState = .authenticated
                    }
                    else {
                        self?.userId = nil
                        self?.authenticationState = .unauthenticated
                    }
                }.store(in: &subscriptions)
        }
    }
}
