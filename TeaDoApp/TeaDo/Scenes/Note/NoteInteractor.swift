//
//  NoteInteractor.swift
//  TeaDo
//
//  Created by Utku Eray on 14.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol NoteBusinessLogic {
    var note: Note? { get set }
    func fetchNote(request: NoteScene.NoteFetch.Request)
    func updateNote(request: NoteScene.Update.Request)
    func createNote(request: NoteScene.Create.Request)
}

protocol NoteDataStore {
    var note: Note? { get }
}

// MARK: Business logic
class NoteInteractor: NoteBusinessLogic, NoteDataStore {
    var presenter: NotePresentationLogic?
    var worker: NoteWorker = NoteWorker()
    var note: Note?

    func fetchNote(request: NoteScene.NoteFetch.Request) {
        worker.sendNoteRequest()
      
        let response = NoteScene.NoteFetch.Response()
        presenter?.presentSuccess(response: response)
    }
    
    func updateNote(request: NoteScene.Update.Request) {
        
    }
    
    func createNote(request: NoteScene.Create.Request) {
        
    }
}
