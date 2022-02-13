//
//  TeaDoMiddlewareLogger.swift
//  TeaDo
//
//  Created by Mehmet Utku Eray on 12.02.2022.
//

import Foundation
import Alamofire

final class TeaDoMiddlewareLogger {
    var startTime: Date?
    
    init() {}
    
    func logHttpRequest(urlRequest: URLRequest, parameters: [String: Any]?) {
        if TeaDoMiddlewareClient.shared.configuration!.enableLogger {
            let url = urlRequest.url!
            let urlPath = url.path
            let httpMethod = urlRequest.method!.rawValue
            let headerFields = urlRequest.allHTTPHeaderFields as AnyObject
            let parameters = parameters as AnyObject
            
            self.startTime = Date()
            
            print("\n<-------------------------------", urlPath, "REQUEST -------------------------------\n")
            
            print("ENDPOINT               : ", urlPath)
            print("REQUEST METHOD         : ", httpMethod)
            print("REQUEST URL            : ", url)
            print("REQUEST HEADER FIELDS  : ", headerFields)
            print("REQUEST PARAMETERS     : ", parameters)
            
            print("---------------------------------------------------------------------->")
            
        }
    }

    func logHttpResponse(urlRequest: URLRequest?, response: HTTPURLResponse?) {
        if TeaDoMiddlewareClient.shared.configuration!.enableLogger {
            let url = urlRequest?.url!
            let urlPath = url?.path
            let statusCode = response?.statusCode
            let headerFields = response?.allHeaderFields as AnyObject
            let responseTime = Date().timeIntervalSince(self.startTime!)
            let responseTimeString = String(format: "[%.4f s]", responseTime)
            
            print("\n<-------------------------------", urlPath ?? "", "RESPONSE -------------------------------\n")
            
            print("ENDPOINT               : ", urlPath ?? "")
            print("REQUEST URL            : ", url ?? "")
            print("STATUS CODE            : ", statusCode ?? "")
            print("RESPONSE TIME          : ", responseTimeString)
            print("RESPONSE HEADER FIELDS : ", headerFields)
            print("RESPONSE               : ", response ?? "")
            
            print("---------------------------------------------------------------------->")
        }
    }
    
    func logHttpError(urlRequest: URLRequest?, response: HTTPURLResponse?, error: Error, errorDescription: String?) {
        if TeaDoMiddlewareClient.shared.configuration!.enableLogger {
            let url = urlRequest?.url!
            let urlPath = url?.path
            let statusCode = response?.statusCode
            let responseTime = Date().timeIntervalSince(self.startTime!)
            let responseTimeString = String(format: "[%.4f s]", responseTime)
            let headerFields = response?.allHeaderFields as AnyObject
            let httpMethod = urlRequest?.method!.rawValue

            print("\n<-------------------------------", urlPath ?? "", "ERROR -------------------------------\n")
            
            print("ENDPOINT               : ", urlPath ?? "")
            print("REQUEST METHOD         : ", httpMethod ?? "")
            print("REQUEST URL            : ", url ?? "")
            print("STATUS CODE            : ", statusCode ?? "")
            print("RESPONSE TIME          : ", responseTimeString)
            print("RESPONSE HEADER FIELDS : ", headerFields)
            print("RESPONSE               : ", response ?? "")
            print("ERROR                  : ", error)
            print("ERROR DESCRIPTION      : ", errorDescription ?? "")
            print("---------------------------------------------------------------------->")
            
        }
    }
}
