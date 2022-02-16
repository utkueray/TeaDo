//
//  NoteInteractor.swift
//  TeaDo
//
//  Created by Utku Eray on 14.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol NoteBusinessLogic {
    var note: Note? { get set }
    func fetchNote(note: Note?)
    func updateNote(request: NoteScene.Update.Request)
    func createNote(request: NoteScene.Create.Request)
}

protocol NoteDataStore {
}

// MARK: Business logic
class NoteInteractor: NoteBusinessLogic, NoteDataStore {
    var presenter: NotePresentationLogic?
    var worker: NoteWorker = NoteWorker()
    var note: Note?

    func fetchNote(note: Note?) {
        let response = NoteScene.NoteFetch.Response(note: note)
        presenter?.presentSuccess(response: response)
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
    
    func createNote(request: NoteScene.Create.Request) {
        worker.sendCreateRequest(request: request) { (response) in
            if (response.error != nil) {
                self.presenter?.presentNetworkError(error: response.error!)
            } else {
                self.presenter?.presentCreate(response: response)
            }
        }
    }
}
