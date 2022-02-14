//
//  MainRouter.swift
//  TeaDo
//
//  Created by Utku Eray on 10.02.2022.
//

import UIKit

protocol MainRoutingLogic {
    func routeToNote(note: List!)
}

protocol MainDataPassing {
    var dataStore: MainDataStore? { get }
}

// MARK: Routing
class MainRouter: NSObject, MainRoutingLogic, MainDataPassing {
    weak var viewController: MainViewController?
    var dataStore: MainDataStore?

    func routeToNote(note: List!) {
        let destinationViewController = NoteViewController(note: note)
//        var destinationDataStore = destinationViewController.router!.dataStore!
//        passDataToNoteScene(source: dataStore!, destination: &destinationDataStore)
        navigateToScene(source: viewController!, destination: destinationViewController)
    }
}

// MARK: Data passing
extension MainRouter {
    
//    func passDataToNoteScene(source: MainDataStore, destination: inout NoteDataStore) {
//        destination.data = source.data
//    }
}

// MARK: Navigation
extension MainRouter {
    
    func navigateToScene(source: TDViewController, destination: TDViewController) {
        source.show(destination, sender: nil)
    }
}
