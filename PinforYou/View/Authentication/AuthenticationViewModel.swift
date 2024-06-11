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
    case authenticated
}

class AuthenticationViewModel : ObservableObject {
    
    enum Action {
        case checkAuthenticationState
        case googleLogin
        case appleLogin(ASAuthorizationAppleIDRequest)
        case appleLoginCompletion(Result<ASAuthorization, Error>)
        case logout
    }
    
    @Published var authenticationState : AuthenticationState = .authenticated
    //임시로 authenticated로 변경
    
    @Published var isLoading : Bool = false
    
    var userId : String?
    
    private var currentNonce : String?
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: Action) {
        switch action {
        case .checkAuthenticationState:
//            if let userID = container.services.authService.checkAuthenticationState() {
//                self.userId = userID
//                self.authenticationState = .authenticated
//            }
            print("checkAuthenticationState")
            
        case .googleLogin:
            isLoading = true
            container.services.authService.signInWithGoogle()
//                .flatMap { user in
//                    self.container.services.userService.addUser(user)
//                }
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.isLoading = false
                    }
                } receiveValue: { [weak self] user in
                    self?.isLoading = false
                    self?.userId = user.id
                    self?.authenticationState = .authenticated
                }.store(in: &subscriptions)
            print("Google")
            
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
                        self?.isLoading = false
                        self?.userId = user.id
                        self?.authenticationState = .authenticated
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
