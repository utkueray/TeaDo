//
//  MainInteractor.swift
//  TeaDo
//
//  Created by Utku Eray on 10.02.2022.
//

protocol MainBusinessLogic {
    var list: [Note]? { get set }
    func fetchList(request: MainScene.Main.Request)
    func updateNote(request: NoteScene.Update.Request)
    func deleteNote(request: MainScene.Delete.Request)
}

protocol MainDataStore {
}

// MARK: Business logic
class MainInteractor: MainBusinessLogic, MainDataStore {
    var presenter: MainPresentationLogic?
    var worker: MainWorker = MainWorker()
    var list: [Note]? = []

    func fetchList(request: MainScene.Main.Request) {
        worker.sendListRequest(request: request) { (response) in
            if (response.error != nil) {
                self.presenter?.presentNetworkError(error: response.error!)
            } else {
                self.list?.removeAll()
                self.list = response.list
                self.presenter?.presentSuccess(response: response)
            }
        }
    }
    
    func updateNote(request: NoteScene.Update.Request) {
        worker.sendUpdateRequest(request: request) { (response) in
            if (response.error != nil) {
                self.presenter?.presentNetworkError(error: response.error!)
            } else {
                self.presenter?.presentUpdate(response: response)
            }
        }
    }
    
    func deleteNote(request: MainScene.Delete.Request) {
        worker.sendDeleteRequest(request: request) { (response) in
            if (response.error != nil) {
                self.presenter?.presentNetworkError(error: response.error!)
            } else {
                self.presenter?.presentAfterDeletion(response: response)
            }
        }
    }
}
