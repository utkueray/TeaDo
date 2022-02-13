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
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        let uuid = UIDevice.current.identifierForVendor!.uuidString
        
        let listRequest = ListRequest(uuid: uuid)
        TeaDoMiddlewareClient.shared.request(route: .list(request: listRequest), responseType: ListResponse.self) { (response, error, errorDescription) in
            print(response?.data?.count)

        }
        
//        let createRequest = CreateRequest(title: "Test",
//                                          body: "Body Test",
//                                          is_note: false,
//                                          is_completed: false,
//                                          uuid: uuid)
//
//        TeaDoMiddlewareClient.shared.request(route: .create(request: createRequest), responseType: ListResponse.self) { (response, error, errorDescription) in
//            print(response?.data?.count)
//
//        }
        
//        let params: [String: Any] = ["uuid": uuid]
//        let headers = HTTPHeaders([HTTPHeader(name: "Content-Type", value: "application/json")])
//
//        AF.request("http://localhost:8000/api/v1/teado/list/", method: .post, parameters: params, headers: headers)
//            .responseDecodable(of: ListResponse.self) { dataResponse in
//                print(dataResponse)
//            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.updateBackgroundColor(bacgroundColor: .gray)
        navigationItem.title = NSLocalizedString("TeaDo", comment: "")
    }
}

// MARK: Display logic
extension MainViewController: MainDisplayLogic {
    
    func displaySuccess(viewModel: MainScene.Main.ViewModel) {
        
    }
    
    func displayNetworkError(message: String) {
//        hideHud()
//        showError(message: message)
    }
}

// MARK: Methods
extension MainViewController {

    
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
