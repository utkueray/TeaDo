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
            var list: [Note]?
            var error: Error?
        }

        struct ViewModel {
            var list: [Note]?
        }
    }
    
    enum Update {
        struct Request {
            var note: Note?
        }

        struct Response {
            var list: [Note]?
            var error: Error?
        }

        struct ViewModel {
            var list: [Note]?
        }
    }
    
    enum Delete {
        struct Request {
            var uuid: String!
            var id: Int!
        }

        struct Response {
            var result: Result?
            var error: Error?
        }

        struct ViewModel {
        }
    }
}
