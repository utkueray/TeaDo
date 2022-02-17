//
//  TeaDoMiddlewareRouter.swift
//  TeaDo
//
//  Created by Mehmet Utku Eray on 12.02.2022.
//

import Foundation
import Alamofire

public enum ParameterType {
    case body(_:Parameters)
    case url(_:Parameters)
    
    public var description: [String: Any] {
        switch self {
        case .body(let parameters):
            return parameters
        case .url(let parameters):
            return parameters
        }
    }
}

public enum ServiceType {
    case apigateway
}

public enum TeaDoMiddlewareRouter: URLRequestConvertible {
    //MARK: Content Services API
    // Category
    case list(request: ListRequest)
    case create(request: CreateRequest)
    case update(request: UpdateRequest)
    case delete(request: DeleteRequest)

    // MARK: HTTPMethod
    public var method: HTTPMethod {
        switch self {
        default:
            return .post
        }
    }
    
    // MARK: Path
    public var path: String {
        switch self {
        case .list:
            return "list/"
        case .create:
            return "create/"
        case .update:
            return "update/"
        case .delete:
            return "remove/"
        }
        
    }
    
    // MARK: Parameters
    public var parameters: ParameterType {
        switch self {
        case .list(let listRequest):
            return .body(listRequest.parameters())
        case .create(let createRequest):
            return .body(createRequest.parameters())
        case .update(let updateRequest):
            return .body(updateRequest.parameters())
        case .delete(let deleteRequest):
            return .body(deleteRequest.parameters())
        // default:
        //    return .url([:])
        }
    }
    
    public var urlParametersRequired: Bool {
        switch self {
         default:
            return false
        }
    }
    
    // Authentication required
    public var authenticationRequired: Bool {
        switch self {
        default:
            return false
        }
    }
    
    // MARK: Service Type
    public var serviceType: ServiceType {
        switch self {
        default:
            return .apigateway
        }
    }
    
    // MARK: URLRequestConvertible
    public func asURLRequest() throws -> URLRequest {
        // Base Url
        var url: URL!
        
        switch serviceType {
        case .apigateway:
            url = try TeaDoMiddlewareClient.shared.configuration.apiGatewayUrl.asURL()
        }
        
        // URL Request
        var urlRequest = URLRequest(url: URL( string: url.appendingPathComponent(path).absoluteString.removingPercentEncoding!)!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = TeaDoMiddlewareClient.shared.configuration.timeOutInterval ?? 60
        
        // HTTPHeaders
         for headerItem in TeaDoMiddlewareClient.shared.configuration.headers.description() {
         urlRequest.setValue(headerItem.value, forHTTPHeaderField: headerItem.key)
         }
        
        // Parameters
        switch parameters {
        case .body(let params):
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        case .url(let params):
            if (self.urlParametersRequired) {
                let queryParams = params.map { pair  in
                    return URLQueryItem(name: pair.key, value: pair.value as? String ?? "")
                }
                var components = URLComponents(string:url.appendingPathComponent(path).absoluteString)
                components?.queryItems = queryParams
                urlRequest.url = components?.url
            }
        }
        
        return urlRequest
    }
}
