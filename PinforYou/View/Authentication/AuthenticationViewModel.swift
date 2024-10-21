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
    
    func send(action: Action, email: String? = nil, name: String? = nil) {
        switch action {
        case .checkAuthenticationState:
//            if let userID = container.services.authService.checkAuthenticationState() {
//                self.userId = userID
//                self.authenticationState = .authenticated
//            }
            print("checkAuthenticationState")
            
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
//                    .flatMap { user in
//                        self.container.services.userService.addUser(user)
//                    }
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
            } else if case let .failure(error) = result {
                isLoading = false
                print(error.localizedDescription)
            }
            
        case .logout:
//            container.services.authService.logout().sink { completion in
//                
//            } receiveValue: { [weak self] _ in
//                self?.authenticationState = .unauthenticated
//                self?.userId = nil
//            }.store(in: &subscriptions)
            print("logout")

        }
    }
}
