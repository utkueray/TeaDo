//
//  MainRouter.swift
//  TeaDo
//
//  Created by Utku Eray on 10.02.2022.
//

import UIKit

protocol MainRoutingLogic {
//    func routeTo<#Destination#>()
}

protocol MainDataPassing {
    var dataStore: MainDataStore? { get }
}

// MARK: Routing
class MainRouter: NSObject, MainRoutingLogic, MainDataPassing {
    weak var viewController: MainViewController?
    var dataStore: MainDataStore?

//    func routeTo<#Destination#>() {
//        let destinationViewController = <#Destination#>ViewController()
//        var destinationDataStore = destinationViewController.router!.dataStore!
//        passDataTo<#Destination#>Scene(source: dataStore!, destination: &destinationDataStore)
//        navigateToScene(source: viewController!, destination: destinationViewController)
//    }
}

// MARK: Data passing
extension MainRouter {
    
//    func passDataTo<#Destination#>Scene(source: MainDataStore, destination: inout <#Destination#>DataStore) {
//        destination.data = source.data
//    }
}

// MARK: Navigation
extension MainRouter {
    
    func navigateToScene(source: TDViewController, destination: TDViewController) {
        source.show(destination, sender: nil)
    }
}
