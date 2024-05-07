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
}

class Services : ServiceType {
    var authService: AuthenticationServiceType
    var userService: UserServiceType
    var locationService : LocationServiceType
    
    init() {
        self.authService = AuthenticationService()
        self.userService = UserService(dbRepository: UserDBRepository())
        self.locationService = LocationService()
    }
}

class StubService : ServiceType {
    var authService: AuthenticationServiceType = StubAuthenticationService()
    var userService: UserServiceType = StubUserService()
    var locationService:  LocationServiceType = StubLocationService()
}
