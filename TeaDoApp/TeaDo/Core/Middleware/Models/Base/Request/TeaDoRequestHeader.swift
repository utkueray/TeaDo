//
//  TeaDoRequestHeader.swift
//  TeaDo
//
//  Created by Mehmet Utku Eray on 12.02.2022.
//

import Foundation

public class TeaDoRequestHeader: Codable {
    var headerDict = [String: String]()
    var contentType = "application/json"
    var apiVersion: String?
    var uiid: String?
    
    public init(uiid: String, apiVersion: String) {
        self.uiid = uiid
    }

    public func description() -> [String: String]{
        headerDict["Content-Type"] = self.contentType
        headerDict["X-UIID"] = self.uiid
        headerDict["api-version"] = self.apiVersion
        return headerDict
    }
}
