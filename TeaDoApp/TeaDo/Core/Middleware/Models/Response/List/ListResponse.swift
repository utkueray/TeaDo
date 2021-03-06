//
//  ListResponse.swift
//  TeaDo
//
//  Created by Utku Eray on 13.02.2022.
//

import Foundation

public class ListResponse: TeaDoResponseModel {
    var data: [Note]?
    
    enum CodingKeys: String, CodingKey {
    case data
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode([Note]?.self, forKey: .data)
    }
}
