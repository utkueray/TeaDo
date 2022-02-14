//
//  DeleteResponse.swift
//  TeaDo
//
//  Created by Utku Eray on 15.02.2022.
//

import Foundation

public class DeleteResponse: TeaDoResponseModel {
    var data: Result?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode(Result?.self, forKey: .data)
    }
}
