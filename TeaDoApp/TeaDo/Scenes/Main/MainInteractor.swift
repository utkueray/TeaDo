//
//  MainInteractor.swift
//  TeaDo
//
//  Created by Utku Eray on 10.02.2022.
//

protocol MainBusinessLogic {
    var someData: Array<String>? { get }
    func doSomething(request: MainScene.Main.Request)
}

protocol MainDataStore {
    var data: Array<String>? { get set }
}

// MARK: Business logic
class MainInteractor: MainBusinessLogic, MainDataStore {
    var presenter: MainPresentationLogic?
    var worker: MainWorker = MainWorker()
    var someData: Array<String>?
    var data: Array<String>?

    func doSomething(request: MainScene.Main.Request) {
        worker.sendMainRequest()
      
        let response = MainScene.Main.Response()
        presenter?.presentSomething(response: response)
    }
}
