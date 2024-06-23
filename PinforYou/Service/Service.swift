//
//  Service.swift
//  PinforYou
//
//  Created by 박진성 on 5/2/24.
//

import Foundation

protocol ServiceType {
    var authService : AuthenticationServiceType {get set}
    var userService : UserServiceType {get set}
    var locationService : LocationServiceType {get set}
    var payService : PayServiceType {get set}
    var ownerPayService : OwnerPayServiceType {get set}
}

class Services : ServiceType {
    var authService: AuthenticationServiceType
    var userService: UserServiceType
    var locationService : LocationServiceType
    var payService : PayServiceType
    var ownerPayService: OwnerPayServiceType
    
    init() {
        self.authService = AuthenticationService()
        self.userService = UserService()
        self.locationService = LocationService()
        self.payService = PayService()
        self.ownerPayService = OwnerPayService()
    }
}

class StubService : ServiceType {
    var authService: AuthenticationServiceType = StubAuthenticationService()
    var userService: UserServiceType = StubUserService()
    var locationService : LocationServiceType = StubLocationService()
    var payService : PayServiceType = StubPayService()
    var ownerPayService: OwnerPayServiceType = StubOwnerPayService()
}
