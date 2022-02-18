//
//  NoteWorker.swift
//  TeaDo
//
//  Created by Utku Eray on 14.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

class NoteWorker {

    func sendUpdateRequest(request: NoteScene.Update.Request, completion: @escaping (NoteScene.Update.Response) -> Void) {
        
        let updateRequest = UpdateRequest(title: request.note?.title,
                                          body: request.note?.body,
                                          is_note: request.note?.isNote,
                                          is_completed: request.note?.isCompleted,
                                          id: request.note?.listId,
                                          uuid: request.note?.uuid)
        TeaDoMiddlewareClient.shared.request(route: .update(request: updateRequest), responseType: ListResponse.self) { (response, error, errorDescription) in
            let response = NoteScene.Update.Response(list: response?.data, error: error)
            completion(response)
        }
    }
    
    func sendCreateRequest(request: NoteScene.Create.Request, completion: @escaping (NoteScene.Create.Response) -> Void) {
        
        let createRequest = CreateRequest(title: request.note?.title,
                                          body: request.note?.body,
                                          is_note: request.note?.isNote,
                                          is_completed: request.note?.isCompleted,
                                          uuid: request.note?.uuid)
        TeaDoMiddlewareClient.shared.request(route: .create(request: createRequest), responseType: ListResponse.self) { (response, error, errorDescription) in
            let response = NoteScene.Create.Response(list: response?.data, error: error)
            completion(response)
        }
    }
    
    func sendDeleteRequest(request: NoteScene.Delete.Request, completion: @escaping (NoteScene.Delete.Response) -> Void) {
        
        let deleteRequest = DeleteRequest(id: request.id, uuid: request.uuid)
        TeaDoMiddlewareClient.shared.request(route: .delete(request: deleteRequest), responseType: DeleteResponse.self) { (response, error, errorDescription) in
            let response = NoteScene.Delete.Response(result: response?.data, error: error)
            completion(response)
        }
    }
}
