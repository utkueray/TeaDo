//
//  MainPresenter.swift
//  TeaDo
//
//  Created by Utku Eray on 10.02.2022.
//

protocol MainPresentationLogic {
    func presentSomething(response: MainScene.Main.Response)
    func presentNetworkError(error: Error)
}

// MARK: Presentation logic
class MainPresenter: MainPresentationLogic {
    weak var viewController: MainDisplayLogic?

    func presentSomething(response: MainScene.Main.Response) {
        let viewModel = MainScene.Main.ViewModel()
        viewController?.displaySuccess(viewModel: viewModel)
    }
    
    func presentNetworkError(error: Error) {
        viewController?.displayNetworkError(message: error.localizedDescription)
    }
}
