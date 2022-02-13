//
//  DeleteRequest.swift
//  TeaDo
//
//  Created by Utku Eray on 12.02.2022.
//
import Foundation

public class DeleteRequest: TeaDoRequestModel {
    public var uuid: String!
    public var id: Int!
    
    public init(id: Int!, uuid: String!) {
        super.init()
        self.uuid = uuid
        self.id = id
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
    }
}
