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
    var challengeService : ChallengeServiceType {get set}
    var pointShopService : PointShopServiceType {get set}
}

class Services : ServiceType {
    
    var authService: AuthenticationServiceType
    var userService: UserServiceType
    var locationService : LocationServiceType
    var payService : PayServiceType
    var ownerPayService: OwnerPayServiceType
    var challengeService : ChallengeServiceType
    var pointShopService : PointShopServiceType
    
    init() {
        self.authService = AuthenticationService()
        self.userService = UserService()
        self.locationService = LocationService()
        self.payService = PayService()
        self.ownerPayService = OwnerPayService()
        self.challengeService = ChallengeService()
        self.pointShopService = PointShopService()
    }
}

class StubService : ServiceType {
    var authService: AuthenticationServiceType = StubAuthenticationService()
    var userService: UserServiceType = StubUserService()
    var locationService : LocationServiceType = StubLocationService()
    var payService : PayServiceType = StubPayService()
    var ownerPayService: OwnerPayServiceType = StubOwnerPayService()
    var challengeService : ChallengeServiceType = StubChallengeService()
    var pointShopService : PointShopServiceType = StubPointShopService()
}
