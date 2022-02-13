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

    func logHttpResponse(jsonResponse: AFDataResponse<String>) {
            if TeaDoMiddlewareClient.shared.configuration!.enableLogger {
                switch jsonResponse.result {
                case .success(let jsonResult):
                    let url = jsonResponse.response!.url!
                    let urlPath = url.path
                    let statusCode = jsonResponse.response!.statusCode
                    let headerFields = jsonResponse.response?.headers as AnyObject
                    let responseTime = Date().timeIntervalSince(self.startTime!)
                    let responseTimeString = String(format: "[%.4f s]", responseTime)
                    var jsonDict:NSDictionary?
                    
                    if let data = jsonResult.data(using: String.Encoding.utf8) {
                        do {
                            jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as NSDictionary?
                        } catch let error as NSError {
                            print(error)
                        }
                    }
                    
                    print("\n<-------------------------------", urlPath ,"RESPONSE -------------------------------\n")
                    
                    print("ENDPOINT               : ", urlPath)
                    print("REQUEST URL            : ", url)
                    print("STATUS CODE            : ", statusCode)
                    print("RESPONSE TIME          : ", responseTimeString)
                    print("RESPONSE HEADER FIELDS : ", headerFields)
                    print("RESPONSE               : ", jsonDict as AnyObject)
                    print("---------------------------------------------------------------------->")
                    
                case .failure( _):
                    break
                }
                
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
    
     func getJSONStringFromObject(object: Any?) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: object ?? "DUMMY_STRING", options: [])
            return String(data: jsonData, encoding: .utf8) ?? "DUMMY_STRING"
        } catch {
            print(error.localizedDescription)
        }
        return "DUMMY_STRING"
    }
}
