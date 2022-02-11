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

        let splashController = UIViewController()
        splashController.view.backgroundColor = UIColor.black
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = splashController
        window?.makeKeyAndVisible()
        self.start()
    }
    

    public func start() {
        appViewController = TDNavigationController(rootViewController: MainViewController())
        setRootViewController(viewController: appViewController)
    }
    
    private func setRootViewController(viewController: UIViewController) {
        window?.rootViewController = viewController
    }
}

// MARK: Present ViewController
extension AppRouter {
    
    public func present(viewController: UIViewController) {
        DispatchQueue.main.async {
            self.window.rootViewController?.present(viewController, animated: true, completion: nil)
        }
    }
}
