//
//  AppDelegate.swift
//  TeaDo
//
//  Created by Utku Eray on 10.02.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var appWorker: AppWorker? = AppWorker()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupMiddleware()
        AppRouter.shared.start()
        
        return true
    }
    
}

// MARK: Methods
extension AppDelegate {
    func setupMiddleware() {
        let configuration = TeaDoMiddlewareConfiguration()
        configuration.apiGatewayUrl = "http://localhost:8000/api/v1/teado/"
        configuration.enableLogger = true
        configuration.timeOutInterval = 30
        
        let headers = TeaDoRequestHeader(uiid: UIDevice.current.identifierForVendor!.uuidString,
                                         apiVersion: "v1")
        
        configuration.headers = headers
        TeaDoMiddlewareClient.shared.configuration = configuration
    }
}
