//
//  NoteInteractor.swift
//  TeaDo
//
//  Created by Utku Eray on 14.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol NoteBusinessLogic {
    var note: List? { get }
    func fetchNote(request: NoteScene.Note.Request)
}

protocol NoteDataStore {
    var note: List? { get }
}

// MARK: Business logic
class NoteInteractor: NoteBusinessLogic, NoteDataStore {
    var presenter: NotePresentationLogic?
    var worker: NoteWorker = NoteWorker()
    var note: List?

    func fetchNote(request: NoteScene.Note.Request) {
        worker.sendNoteRequest()
      
        let response = NoteScene.Note.Response()
        presenter?.presentSuccess(response: response)
    }
}
