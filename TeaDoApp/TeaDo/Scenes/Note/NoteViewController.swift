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
        contentView?.titleTextField.delegate = self
        contentView?.bodyTextView.delegate = self
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = TDColor.backgroundColor

        if let contentView = contentView {
            contentView.backButton.addTarget(self, action: #selector(dismissView(_:)), for: .touchUpInside)
            contentView.toggle.addTarget(self, action: #selector(updateIsNote(_:)), for: .valueChanged)

            let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
           contentView.addGestureRecognizer(tap)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.updateBackgroundColor(backgroundColor: TDColor.backgroundColor)
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
        if let note = viewModel.note {
            contentView?.titleTextField.text = note.title
            contentView?.bodyTextView.text = note.body
            contentView?.toggle.isOn = !(note.isNote ?? true)
        }
    }
    
    func displayUpdate(viewModel: NoteScene.Update.ViewModel) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func displayCreate(viewModel: NoteScene.Create.ViewModel) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func displayNetworkError(message: String) {
        showError(message: message) {
            self.saveChanges()
        }
    }
}

// MARK: Methods
extension NoteViewController {
    
    func fetchNote() {
        interactor?.fetchNote(note: self.note)
    }
    
    func saveChanges() {
        if !(contentView?.titleTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? false &&
            (contentView?.bodyTextView.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? false ||
             contentView?.bodyTextView.text == "What's on your mind ..?")) {
            if self.note == nil {
                createNote()
            } else {
                updateNote()
            }
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func updateNote() {
        if  let contentView = contentView {
            let note = Note(listId: self.note.listId,
                            title:
                                contentView.titleTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? false ? nil : contentView.titleTextField.text,
                            body:
                                contentView.bodyTextView.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? false ? nil : contentView.bodyTextView.text,
                            isNote: !contentView.toggle.isOn,
                            isComplete: self.note.isCompleted,
                            uuid: self.note.uuid)
            
            let request = NoteScene.Update.Request(note: note)
            interactor?.updateNote(request: request)
        }
    }
    
    func createNote() {
        if  let contentView = contentView,
            self.note == nil {
            let note = Note(listId: nil,
                            title:
                                contentView.titleTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? false ? nil : contentView.titleTextField.text,
                            body:
                                contentView.bodyTextView.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? false ? nil : contentView.bodyTextView.text,
                            isNote: !contentView.toggle.isOn,
                            isComplete: false,
                            uuid: UIDevice.current.identifierForVendor!.uuidString)
            
            let request = NoteScene.Create.Request(note: note)
            interactor?.createNote(request: request)
        }
    }
    
    @objc func updateIsNote(_ sender: UISwitch) {

    }

    @objc func dismissView(_ sender: AnyObject) {
        saveChanges()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: UITextFieldDelegate
extension NoteViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textPasteConfigurationSupporting(_ textPasteConfigurationSupporting: UITextPasteConfigurationSupporting, performPasteOf attributedString: NSAttributedString, to textRange: UITextRange) -> UITextRange {
        self.contentView?.titleTextField.replace(textRange, withText: attributedString.string)
        return textRange
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
