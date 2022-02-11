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
        
        AppRouter.shared.start()
               
        return true
    }
    
}

// MARK: Methods
extension AppDelegate {
    
    
}
