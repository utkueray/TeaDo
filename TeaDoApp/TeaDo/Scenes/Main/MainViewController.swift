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
    func displayUpdate(viewModel: NoteScene.Update.ViewModel)
    func displayDeletion(viewModel: MainScene.Delete.ViewModel)
    func displayNetworkError(message: String)
}

// MARK: Initialize & view lifecycle
class MainViewController: TDViewController {
    var interactor: MainBusinessLogic?
    var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    var contentView: MainView?
    var isSearch: Bool = false
    var searchText: String?
    var filteredTableData:[Note]?

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
        view.backgroundColor = TDColor.whiteColor
        
        contentView?.addButton.addTarget(self, action: #selector(createNote(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.updateBackgroundColor(backgroundColor: TDColor.navigationBarColor)
        fetchList()
    }
}

// MARK: Display logic
extension MainViewController: MainDisplayLogic {
    
    // Successfully fetched
    func displaySuccess(viewModel: MainScene.Main.ViewModel) {
        hideHUD()
        
        if let count = viewModel.list?.count {
            contentView?.dataLabel.text = "\(count) " + NSLocalizedString("tea", comment: "")
        }
        
        if isSearch {
            filteredTableData = interactor?.list?.filter {
                $0.title?.range(of: searchText ?? "", options: .caseInsensitive, range: nil, locale: nil) != nil
            }
        }
        
        contentView?.tableView.reloadData()
    }
    
    // Successfully updated
    func displayUpdate(viewModel: NoteScene.Update.ViewModel) {
        hideHUD()
        fetchList()
        contentView?.tableView.reloadData()
    }
    
    // Successfully deleted
    func displayDeletion(viewModel: MainScene.Delete.ViewModel) {
        fetchList()
    }
    
    // Network error occured
    func displayNetworkError(message: String) {
        showError(message: message) {
            self.fetchList()
        }
    }
}

// MARK: Methods
extension MainViewController {
    // Start list request for objects
    func fetchList() {
        showHUD()
        let request = MainScene.Main.Request(uuid: UIDevice.current.identifierForVendor!.uuidString)
        interactor?.fetchList(request: request)
    }
    
    // Start delete request for the object
    func deleteNote(id:Int!) {
        let request = MainScene.Delete.Request(uuid: UIDevice.current.identifierForVendor!.uuidString,
                                               id: id)
        interactor?.deleteNote(request: request)
    }
    
    // Start update request for the object
    func markNote(note: Note!, isCompleted: Bool!) {
        note.isCompleted = isCompleted
        
        let request = NoteScene.Update.Request(note: note)
        interactor?.updateNote(request: request)
    }
    
    // Route to note creating screen
    @objc func createNote(_ sender: AnyObject) {
        router?.routeToNote(note: nil)
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
