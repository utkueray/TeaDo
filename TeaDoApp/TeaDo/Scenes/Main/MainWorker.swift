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
            print(response?.data?.count as Any)
            let response = MainScene.Main.Response(list: response?.data, error: error)
            completion(response)
        }
    }
}
