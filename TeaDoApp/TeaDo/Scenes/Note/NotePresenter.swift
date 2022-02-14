//
//  NotePresenter.swift
//  TeaDo
//
//  Created by Utku Eray on 14.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol NotePresentationLogic {
    func presentSuccess(response: NoteScene.NoteFetch.Response)
    func presentNetworkError(error: Error)
}

// MARK: Presentation logic
class NotePresenter: NotePresentationLogic {
    weak var viewController: NoteDisplayLogic?

    func presentSuccess(response: NoteScene.NoteFetch.Response) {
        let viewModel = NoteScene.NoteFetch.ViewModel()
        viewController?.displaySuccess(viewModel: viewModel)
    }
    
    func presentNetworkError(error: Error) {
        viewController?.displayNetworkError(message: error.localizedDescription)
    }
}
