//
//  Delete.swift
//  TeaDo
//
//  Created by Utku Eray on 15.02.2022.
//

import Foundation

class Result: Codable {
    var listId: Int?
    var isDeleted: Bool?
    
    enum CodingKeys: String, CodingKey {
        case listId = "id"
        case isDeleted = "deleted"
    }
}
