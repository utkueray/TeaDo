//
//  MainWorker.swift
//  TeaDo
//
//  Created by Utku Eray on 10.02.2022.
//
import Foundation
import UIKit

class MainWorker {

    func sendListRequest(request: MainScene.Main.Request, completion: @escaping (MainScene.Main.Response) -> Void) {
        
        let listRequest = ListRequest(uuid: request.uuid)
        TeaDoMiddlewareClient.shared.request(route: .list(request: listRequest), responseType: ListResponse.self) { (response, error, errorDescription) in
            let response = MainScene.Main.Response(list: response?.data, error: error)
            completion(response)
        }
    }
    
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
    
    func sendDeleteRequest(request: MainScene.Delete.Request, completion: @escaping (MainScene.Delete.Response) -> Void) {
        
        let deleteRequest = DeleteRequest(id: request.id, uuid: request.uuid)
        TeaDoMiddlewareClient.shared.request(route: .delete(request: deleteRequest), responseType: DeleteResponse.self) { (response, error, errorDescription) in
            let response = MainScene.Delete.Response(result: response?.data, error: error)
            completion(response)
        }
    }
}
