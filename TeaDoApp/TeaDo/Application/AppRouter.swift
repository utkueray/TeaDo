//
//  AppRouter.swift
//  TeaDo
//
//  Created by Utku Eray on 10.02.2022.
//

import Foundation
import UIKit

final class AppRouter {
    static let shared = AppRouter()
    public var window: UIWindow!
    public var appViewController: TDNavigationController!

    private init() {
        // Setup window
        let splashController = UIViewController()
        splashController.view.backgroundColor = UIColor.black
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = TDColor.backgroundColor
        window?.rootViewController = splashController
        window?.makeKeyAndVisible()
        self.start()
    }
    

    public func start() {
        // Initialize TDNavigationController
        appViewController = TDNavigationController(rootViewController: MainViewController())
        setRootViewController(viewController: appViewController)
    }
    
    private func setRootViewController(viewController: UIViewController) {
        window?.rootViewController = viewController
    }
}
