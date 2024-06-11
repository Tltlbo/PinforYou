//
//  PinforYouApp.swift
//  PinforYou
//
//  Created by 박진성 on 4/15/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import GoogleSignIn
import KakaoMapsSDK

@main
struct PinforYouApp: App {
    
    @StateObject var container : DIContainer = .init(services: Services())
    
    init() {
        KakaoSDK.initSDK(appKey: Key.KakaoAppKey.rawValue)
        SDKInitializer.InitSDK(appKey: Key.KakaoAppKey.rawValue)
        
    } // appKey 숨겨야할듯?
    
    var body: some Scene {
        WindowGroup {
            AuthenticatedView(authViewModel: .init(container: container))
                .environmentObject(container)
                .onOpenURL { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        AuthController.handleOpenUrl(url: url)
                    }
                }
                .onOpenURL{ url in
                    GIDSignIn.sharedInstance.handle(url)
                }
                
        }
        
    }
}
