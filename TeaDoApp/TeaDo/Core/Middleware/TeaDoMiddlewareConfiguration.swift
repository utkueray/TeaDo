//
//  TeaDoMiddlewareConfiguration.swift
//  TeaDo
//
//  Created by Mehmet Utku Eray on 12.02.2022.
//

import Foundation

public class TeaDoMiddlewareConfiguration {
    public var headers: TeaDoRequestHeader!
    public var apiGatewayUrl: String!
    public var enableLogger = false
    public var timeOutInterval: Double?
    
    public init() {}
    
    public func isConfigurationFilled() -> Bool {
        if apiGatewayUrl == nil {
            assertionFailure("TeaDoMiddlewareConfiguration is not set properly.")
            return false
        } else {
            return true
        }
    }
}
