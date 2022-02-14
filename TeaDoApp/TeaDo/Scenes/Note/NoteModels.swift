//
//  NoteModels.swift
//  TeaDo
//
//  Created by Utku Eray on 14.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

struct NoteScene {
    
    // MARK: Use cases
    enum NoteFetch {
        struct Request {
            var note: Note?
        }

        struct Response {
            
        }

        struct ViewModel {
            
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
            
        }
    }
    
    enum Create {
        struct Request {
            var note: Note?
        }

        struct Response {
            var list: [Note]?
            var error: Error?
        }

        struct ViewModel {
        }
    }
}
