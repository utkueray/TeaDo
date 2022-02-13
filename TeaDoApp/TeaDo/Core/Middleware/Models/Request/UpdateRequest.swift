//
//  UpdateRequest.swift
//  TeaDo
//
//  Created by Utku Eray on 12.02.2022.
//

import Foundation

public class UpdateRequest: TeaDoRequestModel {
    public var title: String?
    public var body: String?
    public var is_note: Bool?
    public var is_completed: Bool?
    public var uuid: String!
    public var id: Int!
    
    public init(title: String?, body: String?, is_note: Bool?, is_completed:Bool? = false, id: Int!, uuid: String!) {
        super.init()
        self.title = title
        self.body = body
        self.is_note = is_note
        self.is_completed = is_completed
        self.uuid = uuid
        self.id = id
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
    }
}
