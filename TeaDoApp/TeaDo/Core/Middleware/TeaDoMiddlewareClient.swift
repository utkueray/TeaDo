//
//  TeaDoMiddlewareClient.swift
//  TeaDo
//
//  Created by Mehmet Utku Eray on 12.02.2022.
//

import Foundation
import Alamofire

public final class TeaDoMiddlewareClient {
    public static let  shared = TeaDoMiddlewareClient()
    public var configuration: TeaDoMiddlewareConfiguration!
    private let apiLogger = TeaDoMiddlewareLogger()

    private init() {}
    
    public func request<T: TeaDoResponseModel>(route: TeaDoMiddlewareRouter, responseType: T.Type?, completion: @escaping (T?, Error?, String?) -> Void) {
        
        if self.configuration.isConfigurationFilled() {
            do {
                let urlRequest = try route.asURLRequest()
                
                // Log request
                self.apiLogger.logHttpRequest(urlRequest: urlRequest.urlRequest!, parameters: route.parameters.description)
                
                // Send request
                AF.request(urlRequest).validate(statusCode: 200..<600)
                    .responseDecodable(of: T.self) { dataResponse in
                        // Log Response
                        self.apiLogger.logHttpResponse(urlRequest: urlRequest.urlRequest!, response: dataResponse.response)

                        switch(dataResponse.result){
                        case .success(let result):
                            completion(result, nil, nil)
                            
                        case .failure(let error):
                            // Log Error
                            self.apiLogger.logHttpError(urlRequest: urlRequest.urlRequest!, response: dataResponse.response, error: error, errorDescription: TeaDoMiddlewareError.error(error: error).localizedDescription)
                            
                            completion(nil, error, TeaDoMiddlewareError.error(error: error).localizedDescription)
                        }
                    }
            } catch {
                completion(nil, error, nil)
                // Log Error
                self.apiLogger.logHttpError(urlRequest: nil, response: nil, error: error, errorDescription: nil)
            }
        }
    }
}
