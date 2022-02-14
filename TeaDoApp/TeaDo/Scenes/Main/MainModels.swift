//
//  MainModels.swift
//  TeaDo
//
//  Created by Utku Eray on 10.02.2022.
//

struct MainScene {
    
    // MARK: Use cases
    enum Main {
        struct Request {
            var uuid: String!
        }

        struct Response {
            var list: [List]?
            var error: Error?
        }

        struct ViewModel {
            var list: [List]?
        }
    }
}
