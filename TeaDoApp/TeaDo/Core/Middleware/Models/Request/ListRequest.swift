//
//  ListRequest.swift
//  TeaDo
//
//  Created by Utku Eray on 12.02.2022.
//

import Foundation

public class ListRequest: TeaDoRequestModel {
    public var uuid: String!

    public init(uuid: String!) {
        super.init()
        self.uuid = uuid
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
    }
}
