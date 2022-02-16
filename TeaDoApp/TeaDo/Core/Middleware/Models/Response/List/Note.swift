//
//  List.swift
//  TeaDo
//
//  Created by Utku Eray on 13.02.2022.
//

import Foundation

class Note: Codable {
    var listId: Int?
    var title: String?
    var body: String?
    var isNote: Bool?
    var isCompleted: Bool?
    var dateCreated: String?
    var lastModified: String?
    var uuid: String?
    
    enum CodingKeys: String, CodingKey {
        case listId = "id"
        case title
        case body
        case isNote = "is_note"
        case isCompleted = "is_completed"
        case dateCreated = "date_created"
        case lastModified = "last_modified"
        case uuid
    }
    
    public init(listId: Int?,
                title: String?,
                body: String?,
                isNote: Bool?,
                isComplete: Bool?,
                uuid: String?) {
        self.listId = listId
        self.title = title
        self.body = body
        self.isNote = isNote
        self.isCompleted = isComplete
        self.uuid = uuid
    }
}
