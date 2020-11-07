//
//  NetworkResponse.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 08.10.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

enum NetworkResponse: Error {
    case success
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
    case noNetwork
    case customError(textError: String?)
    
    var description: String {
        switch self {
        case .success:
            return "Success"
        case .authenticationError:
            return "You need to be authenticated first."
        case .badRequest:
            return "Bad request."
        case .outdated:
            return "The url you requested is outdated."
        case .failed:
            return "Network request failed."
        case .noData:
            return "Response returned with no data to decode."
        case .unableToDecode:
            return "We could not decode the response."
        case .noNetwork:
            return "Please check your network connection."
        case .customError(textError: let textError):
            return "\(textError ?? "Error")"
        }
    }
}
