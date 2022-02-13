//
//  Serializable.swift
//  TeaDo
//
//  Created by Utku Eray on 12.02.2022.
//

import Foundation

public protocol Serializable {
    
    func toDictionary() -> NSDictionary
}

public extension Serializable {
    
    func toDictionary() -> NSDictionary {
        
        let dict = NSMutableDictionary()//[String: Any]()
        
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            guard let property = child.label else {
                continue
            }
            
            dict.setObject(child.value, forKey: property as NSCopying)
        }
        return dict as NSDictionary
    }
}
