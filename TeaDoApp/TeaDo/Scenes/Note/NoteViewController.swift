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
    func displayDeletion(viewModel: NoteScene.Delete.ViewModel)
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
        contentView?.titleTextField.pasteDelegate = self
        contentView?.bodyTextView.delegate = self
        contentView?.bodyTextView.pasteDelegate = self

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
    
    // Successfully displayed data
    func displaySuccess(viewModel: NoteScene.NoteFetch.ViewModel) {
        if let note = viewModel.note {
            contentView?.titleTextField.text = note.title
            contentView?.bodyTextView.text = note.body
            contentView?.toggle.isOn = !(note.isNote ?? true)
        }
    }
    
    // Successfully updated
    func displayUpdate(viewModel: NoteScene.Update.ViewModel) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Successfully created
    func displayCreate(viewModel: NoteScene.Create.ViewModel) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Successfully deleted
    func displayDeletion(viewModel: NoteScene.Delete.ViewModel) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Network error occured
    func displayNetworkError(message: String) {
        showError(message: message) {
        }
    }
}

// MARK: Methods
extension NoteViewController {
    
    // Start note presentation
    func fetchNote() {
        interactor?.fetchNote(note: self.note)
    }
    
    // Save changes if it's not an empty note, then delete it
    func saveChanges() {
        if checkIfNoteUpdated() {
            let titleText = contentView?.titleTextField.text ?? ""
            let bodyText = (contentView?.bodyTextView.text == NSLocalizedString("bodyPlaceHolder", comment: "") ? "" : contentView?.bodyTextView.text) ?? ""
            
            if self.note == nil {
                if !(titleText == "" && bodyText == "") {
                    createNote()
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                if (titleText == "" && bodyText == "") {
                    deleteNote(id: self.note.listId)
                }
                updateNote()
            }
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // Check if there have been any changes
    func checkIfNoteUpdated() -> Bool {
        // check if note updated
        let titleText = contentView?.titleTextField.text ?? ""
        let bodyText = (contentView?.bodyTextView.text == NSLocalizedString("bodyPlaceHolder", comment: "") ? "" : contentView?.bodyTextView.text) ?? ""
        
        if let contentView = contentView,
           self.note != nil,
           self.note.title == titleText,
           self.note.body == bodyText,
           self.note.isNote == !contentView.toggle.isOn {
                return false
            }
        return true
    }
    
    // Start update request for the note
    func updateNote() {
        if  let contentView = contentView {
            let note = Note(listId: self.note.listId,
                            title:contentView.titleTextField.text,
                            body:contentView.bodyTextView.text,
                            isNote: !contentView.toggle.isOn,
                            isComplete: self.note.isCompleted,
                            uuid: self.note.uuid)
            
            let request = NoteScene.Update.Request(note: note)
            interactor?.updateNote(request: request)
        }
    }
    
    // Start create request for the note
    func createNote() {
        if  let contentView = contentView,
            self.note == nil {
            let note = Note(listId: nil,
                            title:contentView.titleTextField.text,
                            body:contentView.bodyTextView.text,
                            isNote: !contentView.toggle.isOn,
                            isComplete: false,
                            uuid: UIDevice.current.identifierForVendor!.uuidString)
            
            let request = NoteScene.Create.Request(note: note)
            interactor?.createNote(request: request)
        }
    }
    
    // Start delete request for the note
    func deleteNote(id:Int!) {
        let request = NoteScene.Delete.Request(uuid: UIDevice.current.identifierForVendor!.uuidString,
                                               id: id)
        interactor?.deleteNote(request: request)
    }
    
    // Method for toggle button
    @objc func updateIsNote(_ sender: UISwitch) {

    }

    // Save changes on view dismiss
    @objc func dismissView(_ sender: AnyObject) {
        saveChanges()
    }
    
    // Dismiss keyboard if user touches somewhere else
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: UITextFieldDelegate
extension NoteViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}

// MARK: UITextViewDelegate
extension NoteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == NSLocalizedString("bodyPlaceHolder", comment: "") {
            textView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = NSLocalizedString("bodyPlaceHolder", comment: "")
        }
    }
}

// MARK: UITextPasteDelegate
extension NoteViewController: UITextPasteDelegate {
    func textPasteConfigurationSupporting(_ textPasteConfigurationSupporting: UITextPasteConfigurationSupporting, performPasteOf attributedString: NSAttributedString, to textRange: UITextRange) -> UITextRange {
        if let textView = textPasteConfigurationSupporting as? UITextView {
            let pasteBoard = UIPasteboard.general
            if pasteBoard.hasStrings {
                textView.insertText(pasteBoard.string ?? "")
            }
        }
        
        if let textView = textPasteConfigurationSupporting as? UITextField {
            let pasteBoard = UIPasteboard.general
            if pasteBoard.hasStrings {
                textView.insertText(pasteBoard.string ?? "")
            }
        }
        return textRange
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
