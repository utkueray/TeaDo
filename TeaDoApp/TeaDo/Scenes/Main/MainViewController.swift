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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.updateBackgroundColor(backgroundColor: TDColor.darkBackgroundColor)
        addNavigationButton()
        fetchList()
    }
}

// MARK: Display logic
extension MainViewController: MainDisplayLogic {
    
    func displaySuccess(viewModel: MainScene.Main.ViewModel) {
        hideHUD()
        contentView?.tableView.reloadData()
    }
    
    func displayUpdate(viewModel: NoteScene.Update.ViewModel) {
        hideHUD()
        fetchList()
        contentView?.tableView.reloadData()
    }
    
    func displayDeletion(viewModel: MainScene.Delete.ViewModel) {
        fetchList()
    }
    
    func displayNetworkError(message: String) {
        showError(message: message) {
            self.fetchList()
        }
    }
}

// MARK: Methods
extension MainViewController {
    func fetchList() {
        showHUD()        
        let request = MainScene.Main.Request(uuid: UIDevice.current.identifierForVendor!.uuidString)
        interactor?.fetchList(request: request)
    }
    
    func deleteNote(id:Int!) {
        let request = MainScene.Delete.Request(uuid: UIDevice.current.identifierForVendor!.uuidString,
                                               id: id)
        interactor?.deleteNote(request: request)
    }
    
    func markNote(note: Note!) {
        // Get Cell Reference to Change uploadedImageView
        let note = Note(listId: note.listId,
                        title:note.title,
                        body:note.body,
                        isNote: note.isNote,
                        isComplete: true,
                        uuid: note.uuid)
        
        let request = NoteScene.Update.Request(note: note)
        interactor?.updateNote(request: request)
    }
    
    func addNavigationButton() {
        let addButton = UIBarButtonItem(image: TDImage.addButton, style: .plain, target: self, action: #selector(createNote(_:)))
        addButton.tintColor = TDColor.logoColor
        
        self.navigationItem.rightBarButtonItem = addButton
    }
    
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
