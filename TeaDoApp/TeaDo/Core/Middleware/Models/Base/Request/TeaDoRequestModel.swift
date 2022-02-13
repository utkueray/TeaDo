//
//  TeaDoRequestModel.swift
//  TeaDo
//
//  Created by Mehmet Utku Eray on 12.02.2022.
//

import Foundation

public class TeaDoRequestModel: Codable {
    public init() {}
      
      public func parameters() -> [String: Any] {
          var dict = [String: Any]()
          
          let mirror = Mirror(reflecting: self)
          for child in mirror.children {
              guard let property = child.label else {
                  continue
              }
              dict[property] = child.value
          }
          
          var parameters = [String:Any]()
          for item in dict where String(describing: item.value) != "nil" {
              parameters[item.key] = item.value
          }
          
          return parameters
      }
}
