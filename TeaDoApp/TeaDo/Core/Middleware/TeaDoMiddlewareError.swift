//
//  TeaDoMiddlewareError.swift
//  TeaDo
//
//  Created by Mehmet Utku Eray on 12.02.2022.
//

import Foundation
import Alamofire

enum TeaDoMiddlewareError {
    case error(error: AFError)
    
    public var localizedDescription: String {
        switch self {
        case .error(error: let error):
            switch error {
            case .sessionTaskFailed(error: let error):
                let description = ("Session Task Failed: \(error.localizedDescription)")
                return description
                
            case .createUploadableFailed(error: let error):
                let description = ("Create Uploadable Failed \(error.localizedDescription)")
                return description

            case .createURLRequestFailed(error: let error):
                let description = ("Create URL Request Failed \(error.localizedDescription)")
                return description
                
            case .downloadedFileMoveFailed(error: let error, source: let source, destination: let destination):
                let description = ("Downloaded File Move Failed \(error.localizedDescription)") + ("Source: \(source)") + ("Destination: \(destination)")
                return description
                
            case .explicitlyCancelled:
                let description = ("Explicitly Cancelled \(error.localizedDescription)")
                return description

            case .invalidURL(url: let url):
                let description = ("Invalid URL: \(url) - \(error.localizedDescription)")
                return description

            case .multipartEncodingFailed(reason: let reason):
                let description = ("Parameter encoding failed: \(error.localizedDescription)") + ("Failure Reason: \(reason)")
                return description

            case .parameterEncodingFailed(reason: let reason):
                let description = ("Parameter encoding failed: \(error.localizedDescription)") + ("Failure Reason: \(reason)")
                return description

            case .parameterEncoderFailed(reason: let reason):
                let description = ("Parameter encoder failed: \(error.localizedDescription)") + ("Failure Reason: \(reason)")
                return description

            case .requestAdaptationFailed(error: let error):
                let description = ("Request Adaptation Failed: \(error.localizedDescription)")
                return description

            case .requestRetryFailed(retryError: let retryError, originalError: let originalError):
                let description = ("Request Retry Failed: \(error.localizedDescription)") + ("Retry Error: \(retryError)") + ("Original Error: \(originalError)")
                return description

            case .responseValidationFailed(reason: let reason):
                let description = ("Response Validation Failed: \(error.localizedDescription)") + ("Failure Reason: \(reason)")
                return description

            case .responseSerializationFailed(reason: let reason):
                let description = ("Response Serialization Failed: \(error.localizedDescription)") + ("Failure Reason: \(reason)")
                return description

            case .serverTrustEvaluationFailed(reason: let reason):
                let description = ("Server Trust Evaluation Failed: \(error.localizedDescription)") + ("Failure Reason: \(reason)")
                return description

            case .sessionDeinitialized:
                let description = ("Session Deinitialized: \(error.localizedDescription)")
                return description

            case .sessionInvalidated(error: let error):
                let description = ("Session Invalidated: \(String(describing: error?.localizedDescription))")
                return description

            case .urlRequestValidationFailed(reason: let reason):
                let description = ("URL Request Validation Failed: \(error.localizedDescription)") + ("Failure Reason: \(reason)")
                return description
            }
        
        }
    }
    
    public var localizedMessage: String {
        switch self {
        case .error(error: let error):
            switch error {
            case .sessionTaskFailed(error: _):
                let message = NSLocalizedString("", comment: "")
                return message
                
            case .createUploadableFailed(error: _):
                let message = NSLocalizedString("", comment: "")
                return message

            case .createURLRequestFailed(error: _):
                let message = NSLocalizedString("", comment: "")
                return message
                
            case .downloadedFileMoveFailed(error: _, source: _, destination: _):
                let message = NSLocalizedString("", comment: "")
                return message
                
            case .explicitlyCancelled:
                let message = NSLocalizedString("", comment: "")
                return message

            case .invalidURL(url: _):
                let message = NSLocalizedString("", comment: "")
                return message

            case .multipartEncodingFailed(reason: _):
                let message = NSLocalizedString("", comment: "")
                return message

            case .parameterEncodingFailed(reason: _):
                let message = NSLocalizedString("", comment: "")
                return message

            case .parameterEncoderFailed(reason: _):
                let message = NSLocalizedString("", comment: "")
                return message

            case .requestAdaptationFailed(error: _):
                let message = NSLocalizedString("", comment: "")
                return message

            case .requestRetryFailed(retryError: _, originalError: _):
                let message = NSLocalizedString("", comment: "")
                return message

            case .responseValidationFailed(reason: _):
                let message = NSLocalizedString("", comment: "")
                return message

            case .responseSerializationFailed(reason: _):
                let message = NSLocalizedString("", comment: "")
                return message

            case .serverTrustEvaluationFailed(reason: _):
                let message = NSLocalizedString("", comment: "")
                return message

            case .sessionDeinitialized:
                let message = NSLocalizedString("", comment: "")
                return message

            case .sessionInvalidated(error: _):
                let message = NSLocalizedString("", comment: "")
                return message

            case .urlRequestValidationFailed(reason: _):
                let message = NSLocalizedString("", comment: "")
                return message
            }
        }
    }
}
