//
//  NotePresenter.swift
//  TeaDo
//
//  Created by Utku Eray on 14.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol NotePresentationLogic {
    func presentSuccess(response: NoteScene.NoteFetch.Response)
    func presentUpdate(response: NoteScene.Update.Response)
    func presentCreate(response: NoteScene.Create.Response)
    func presentNetworkError(error: Error)
}

// MARK: Presentation logic
class NotePresenter: NotePresentationLogic {
    weak var viewController: NoteDisplayLogic?

    func presentSuccess(response: NoteScene.NoteFetch.Response) {
        let viewModel = NoteScene.NoteFetch.ViewModel(note: response.note)
        viewController?.displaySuccess(viewModel: viewModel)
    }
    
    func presentUpdate(response: NoteScene.Update.Response) {
        let viewModel = NoteScene.Update.ViewModel(list: response.list)
        viewController?.displayUpdate(viewModel: viewModel)
    }
    
    func presentCreate(response: NoteScene.Create.Response) {
        let viewModel = NoteScene.Create.ViewModel(list: response.list)
        viewController?.displayCreate(viewModel: viewModel)
    }
    
    func presentNetworkError(error: Error) {
        viewController?.displayNetworkError(message: error.localizedDescription)
    }
}
