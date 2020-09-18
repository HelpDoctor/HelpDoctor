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
    case recovery(email: String)
    case deleteUser
    case login(email: String, password: String)
    case logout
    case checkProfile
    case getProfile
    case updateProfile(user: [String: Any]?, job: [[String: Any]]?, spec: [[String: Any]]?, interests: [Int]?)
    case getListOFInterests(specCode: String?, addSpecCode: String?)
    case getRegions
    case getCities(regionId: Int)
    case getMedicalOrganization(regionId: Int)
    case getMedicalSpecialization
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
        case .recovery:
            return "public/api/recovery"
        case .deleteUser:
            return "public/api/registration/del"
        case .login:
            return "public/api/auth/login"
        case .logout:
            return "public/api/auth/logout"
        case .checkProfile:
            return "public/api/profile/check"
        case .getProfile:
            return "public/api/profile/get"
        case .updateProfile:
            return "public/api/profile/update"
        case .getListOFInterests(specCode: let specCode, addSpecCode: let addSpecCode):
            guard let specCode = specCode else {
                return "public/api/profile/sc_interests/"
            }
            guard let addSpecCode = addSpecCode else {
                return "public/api/profile/sc_interests/\(specCode)"
            }
            return "public/api/profile/sc_interests/\(specCode)/\(addSpecCode)"
        case .getRegions:
            return "public/api/profile/regions"
        case .getCities(regionId: let regionId):
            return "public/api/profile/cities/\(regionId)"
        case .getMedicalOrganization(regionId: let regionId):
            return "public/api/profile/works/\(regionId)"
        case .getMedicalSpecialization:
            return "public/api/profile/specializations"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .registration, .recovery, .deleteUser, .login, .logout, .checkProfile, .getProfile, .updateProfile:
            return .post
        case .getListOFInterests, .getRegions, .getCities, .getMedicalOrganization, .getMedicalSpecialization:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .registration(email: let email), .recovery(email: let email):
            return .requestParameters(bodyParameters: ["email": email],
                                      urlParameters: nil)
        case .login(email: let email, password: let password):
            return .requestParameters(bodyParameters: ["email": email,
                                                       "password": password.toBase64()],
                                      urlParameters: nil)
        case .updateProfile(user: let user, job: let job, spec: let spec, interests: let interests):
            return .requestParametersAndHeaders(bodyParameters: ["user": user as Any,
                                                                 "job": job ?? [],
                                                                 "spec": spec ?? [],
                                                                 "interests": interests ?? []],
                                                urlParameters: nil,
                                                additionHeaders: headers)
        case .deleteUser, .logout, .checkProfile, .getProfile:
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionHeaders: headers)
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        guard let myToken = Auth_Info.instance.token else { return nil }
        switch self {
        case .deleteUser, .logout, .checkProfile, .getProfile, .updateProfile:
            return ["Content-Type": "application/json",
                    "X-Auth-Token": myToken]
        default:
            return nil
        }
    }
}
