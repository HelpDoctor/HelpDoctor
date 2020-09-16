//
//  HelpDoctorEndPoint.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 14.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

public enum HelpDoctorApi {
    case registration(email: String)
    case getProfile
    case getListOFInterests(specCode: String?, addSpecCode: String?)
}

extension HelpDoctorApi: EndPointType {
    var environmentBaseURL: String {
        return "http://demo22.tmweb.ru/"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var path: String {
        switch self {
        case .registration:
            return "public/api/registration"
        case .getProfile:
            return "public/api/profile/get"
        case .getListOFInterests(specCode: let specCode, addSpecCode: let addSpecCode):
            guard let specCode = specCode else {
                return "public/api/profile/sc_interests/"
            }
            guard let addSpecCode = addSpecCode else {
                return "public/api/profile/sc_interests/\(specCode)"
            }
            return "public/api/profile/sc_interests/\(specCode)/\(addSpecCode)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .registration, .getProfile:
            return .post
        case .getListOFInterests:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .registration(email: let email):
            return .requestParameters(bodyParameters: ["email": email], urlParameters: nil)
        case .getProfile:
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionHeaders: headers)
        case .getListOFInterests:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        guard let myToken = Auth_Info.instance.token else { return nil }
        switch self {
        case .getProfile:
            return ["Content-Type": "application/json",
                    "X-Auth-Token": myToken]
        default:
            return nil
        }
    }
}
