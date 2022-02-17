//
//  MainPresenter.swift
//  TeaDo
//
//  Created by Utku Eray on 10.02.2022.
//

protocol MainPresentationLogic {
    func presentSuccess(response: MainScene.Main.Response)
    func presentUpdate(response: NoteScene.Update.Response)
    func presentAfterDeletion(response: MainScene.Delete.Response)
    func presentNetworkError(error: Error)
}

// MARK: Presentation logic
class MainPresenter: MainPresentationLogic {
    weak var viewController: MainDisplayLogic?

    func presentSuccess(response: MainScene.Main.Response) {
        let viewModel = MainScene.Main.ViewModel(list: response.list)
        viewController?.displaySuccess(viewModel: viewModel)
    }
    
    func presentUpdate(response: NoteScene.Update.Response) {
        let viewModel = NoteScene.Update.ViewModel(list: response.list)
        viewController?.displayUpdate(viewModel: viewModel)
    }
    
    func presentAfterDeletion(response: MainScene.Delete.Response) {
        let viewModel = MainScene.Delete.ViewModel()
        viewController?.displayDeletion(viewModel: viewModel)
    }
    
    func presentNetworkError(error: Error) {
        viewController?.displayNetworkError(message: error.localizedDescription)
    }
}
