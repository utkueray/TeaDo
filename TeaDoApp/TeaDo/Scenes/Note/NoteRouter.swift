//
//  NoteRouter.swift
//  TeaDo
//
//  Created by Utku Eray on 14.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NoteRoutingLogic {
//    func routeTo<#Destination#>()
}

protocol NoteDataPassing {
    var dataStore: NoteDataStore? { get }
}

// MARK: Routing
class NoteRouter: NSObject, NoteRoutingLogic, NoteDataPassing {
    weak var viewController: NoteViewController?
    var dataStore: NoteDataStore?

//    func routeTo<#Destination#>() {
//        let destinationViewController = <#Destination#>ViewController()
//        var destinationDataStore = destinationViewController.router!.dataStore!
//        passDataTo<#Destination#>Scene(source: dataStore!, destination: &destinationDataStore)
//        navigateToScene(source: viewController!, destination: destinationViewController)
//    }
}

// MARK: Data passing
extension NoteRouter {
    
//    func passDataTo<#Destination#>Scene(source: NoteDataStore, destination: inout <#Destination#>DataStore) {
//        destination.data = source.data
//    }
}

// MARK: Navigation
extension NoteRouter {
    
    func navigateToScene(source: TDViewController, destination: TDViewController) {
        source.show(destination, sender: nil)
    }
}
