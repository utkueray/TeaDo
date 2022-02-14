//
//  MainViewController.swift
//  TeaDo
//
//  Created by Utku Eray on 10.02.2022.
//

import UIKit
import Alamofire

protocol MainDisplayLogic: AnyObject {
    func displaySuccess(viewModel: MainScene.Main.ViewModel)
    func displayNetworkError(message: String)
}

// MARK: Initialize & view lifecycle
class MainViewController: TDViewController {
    var interactor: MainBusinessLogic?
    var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    var contentView: MainView?
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        configure()
    }
    
    override func loadView() {
        super.loadView()
        contentView?.tableView.delegate = self
        contentView?.tableView.dataSource = self
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = TDColor.darkBackgroundColor
        fetchList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.updateBackgroundColor(backgroundColor: TDColor.darkBackgroundColor)
    }
}

// MARK: Display logic
extension MainViewController: MainDisplayLogic {
    
    func displaySuccess(viewModel: MainScene.Main.ViewModel) {
        successHUD()
        contentView?.tableView.reloadData()
    }
    
    func displayNetworkError(message: String) {
        errorHUD()
        showError(message: message)
    }
}

// MARK: Methods
extension MainViewController {
    func fetchList() {
        showHUD()
        let request = MainScene.Main.Request(uuid: UIDevice.current.identifierForVendor!.uuidString)
        interactor?.fetchList(request: request)
    }
    
}

// MARK: VIP Configuration
extension MainViewController {
    
    private func configure() {
        let viewController = self
        
        let presenter = MainPresenter()
        presenter.viewController = viewController
        
        let interactor = MainInteractor()
        interactor.presenter = presenter
        
        let router = MainRouter()
        router.viewController = viewController
        router.dataStore = interactor
        
        let view = MainView()

        viewController.interactor = interactor
        viewController.router = router
        viewController.contentView = view
    }
}
