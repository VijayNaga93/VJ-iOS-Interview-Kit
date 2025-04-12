//
//  SignupError.swift
//  PhotoAppUnitTesting
//
//  Created by NAGARAJAN, VIJAY (V.) on 05/11/24.
//

import Foundation

enum SignupError: LocalizedError, Equatable {

    case invalidResponseModel
    case invalidRequestURLString
    case failedRequest(description: String)
    
//    var errorDescription: String? {
//        switch self {
//        case .failedRequest(let description):
//            return description
//        case .invalidResponseModel, .invalidRequestURLString:
//            return ""
//        }
//    }
    
    
    var errorDescription: String? {
        switch self {
        case .failedRequest(description: let description):
            return description
        case .invalidResponseModel, .invalidRequestURLString:
            return ""
        }
    }
}
