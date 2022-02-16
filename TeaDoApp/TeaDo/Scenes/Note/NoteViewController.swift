//
//  NoteViewController.swift
//  TeaDo
//
//  Created by Utku Eray on 14.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NoteDisplayLogic: AnyObject {
    func displaySuccess(viewModel: NoteScene.NoteFetch.ViewModel)
    func displayUpdate(viewModel: NoteScene.Update.ViewModel)
    func displayCreate(viewModel: NoteScene.Create.ViewModel)
    func displayNetworkError(message: String)
}

// MARK: Initialize & view lifecycle
class NoteViewController: TDViewController {
    var interactor: NoteBusinessLogic?
    var router: (NSObjectProtocol & NoteRoutingLogic & NoteDataPassing)?
    var contentView: NoteView?
    var note: Note!
    
    convenience init(note: Note?) {
        self.init(nibName:nil, bundle:nil)
        if let note = note {
            self.note = note
        }

        configure()
    }
    
    override func loadView() {
        super.loadView()
        contentView?.bodyTextView.delegate = self
        
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = TDColor.darkBackgroundColor

        if let contentView = contentView {
            contentView.backButton.addTarget(self,
                                             action: #selector(dismissView(_:)),
                                             for: .touchUpInside)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
           view.addGestureRecognizer(tap)

        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.updateBackgroundColor(backgroundColor: TDColor.darkBackgroundColor)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        fetchNote()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: Display logic
extension NoteViewController: NoteDisplayLogic {
    
    func displaySuccess(viewModel: NoteScene.NoteFetch.ViewModel) {
        hideHUD()
        if let note = viewModel.note {
            contentView?.titleTextField.text = note.title
            contentView?.bodyTextView.text = note.body
        }
    }
    
    func displayUpdate(viewModel: NoteScene.Update.ViewModel) {
        hideHUD()
    }
    
    func displayCreate(viewModel: NoteScene.Create.ViewModel) {
        addHUD()
    }
    
    func displayNetworkError(message: String) {
        errorHUD()
        showError(message: message)
    }
}

// MARK: Methods
extension NoteViewController {
    
    func fetchNote() {
        interactor?.fetchNote(note: self.note)
    }
    
    func updateNote() {
        if  let contentView = contentView,
            let note = self.note {
            note.title = contentView.titleTextField.text
            note.body = contentView.bodyTextView.text
            
            let request = NoteScene.Update.Request(note: note)
            interactor?.updateNote(request: request)
        }
    }
    
    func createNote() {
        interactor?.fetchNote(note: self.note)
    }

    @objc func dismissView(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: UITextViewDelegate
extension NoteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "What's on your mind ..?" {
            textView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What's on your mind ..?"
        }
    }
}

// MARK: VIP Configuration
extension NoteViewController {
    
    private func configure() {
        let viewController = self
        
        let presenter = NotePresenter()
        presenter.viewController = viewController
        
        let interactor = NoteInteractor()
        interactor.presenter = presenter
        
        let router = NoteRouter()
        router.viewController = viewController
        router.dataStore = interactor
        
        let view = NoteView()

        viewController.interactor = interactor
        viewController.router = router
        viewController.contentView = view
    }
}
