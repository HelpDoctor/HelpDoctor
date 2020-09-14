//
//  HelpDoctorEndPoint.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 14.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

public enum HelpDoctorApi {
    case getProfile
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
        case .getProfile:
            return "public/api/profile/get"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getProfile:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getProfile:
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionHeaders: headers)
        }
    }
    
    var headers: HTTPHeaders? {
        guard let myToken = Auth_Info.instance.token else { return nil }
        switch self {
        case .getProfile:
            return ["Content-Type": "application/json",
                    "X-Auth-Token": myToken]
        }
    }
}
