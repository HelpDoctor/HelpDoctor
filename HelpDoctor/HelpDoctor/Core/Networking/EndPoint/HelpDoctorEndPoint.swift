//
//  HelpDoctorEndPoint.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 14.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

enum HelpDoctorApi {
    case registration(email: String)
    case recovery(email: String)
    case deleteUser
    case login(email: String, password: String)
    case logout
    case getUserStatus
    case checkProfile
    case getProfile
    case updateProfile(user: [String: Any]?, job: [[String: Any]]?, spec: [[String: Any]]?, interests: [Int]?)
    case getListOFInterests(specCode: String?, addSpecCode: String?)
    case getRegions
    case getCities(regionId: Int)
    case getMedicalOrganization(regionId: Int)
    case getMedicalSpecialization
    case getContactList
    case setEvent(event: Event)
    case getEventForDate(date: String)
    case getEvenyForId(id: Int)
    case deleteEvent(id: Int)
    case feedback(feedback: String)
    case invite(email: String, firstName: String, lastName: String?)
    case changePassword(password: String, newPassword: String)
    case getSettings
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
        case .registration, .invite:
            return "public/api/registration"
        case .recovery:
            return "public/api/recovery"
        case .deleteUser:
            return "public/api/registration/del"
        case .login:
            return "public/api/auth/login"
        case .logout:
            return "public/api/auth/logout"
        case .getUserStatus:
            return "public/api/profile/user_status"
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
        case .getContactList:
            return "public/api/contact_list/get"
        case .setEvent:
            return "public/api/event/set"
        case .getEventForDate(date: let date):
            return "public/api/event/date/\(date)"
        case .getEvenyForId(id: let id):
            return "public/api/event/get/\(id)"
        case .deleteEvent(id: let id):
            return "public/api/event/del/\(id)"
        case .feedback:
            return "public/api/support/feedback"
        case .changePassword:
            return "public/api/profile/change_password"
        case .getSettings:
            return "public/api/profile/settings"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .registration,
             .recovery,
             .deleteUser,
             .login,
             .logout,
             .checkProfile,
             .getProfile,
             .updateProfile,
             .setEvent,
             .feedback,
             .invite,
             .changePassword:
            return .post
        case .getUserStatus,
             .getListOFInterests,
             .getRegions,
             .getCities,
             .getMedicalOrganization,
             .getMedicalSpecialization,
             .getContactList,
             .getEventForDate,
             .getEvenyForId,
             .deleteEvent,
             .getSettings:
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
        case .setEvent(event: let event):
            let participants: [Int]? = event.participants?.compactMap({ $0.id })
            return .requestParametersAndHeaders(bodyParameters: ["event": [
                                                                    "id": event.id as Any,
                                                                    "start_date": event.startDate as String,
                                                                    "end_date": event.endDate as String,
                                                                    "notify_date": event.notifyDate as Any,
                                                                    "title": event.title as Any,
                                                                    "description": event.description as Any,
                                                                    "primary_consultation": true,
                                                                    "is_major": event.isMajor as Any,
                                                                    "event_place": event.eventPlace as Any,
                                                                    "event_type": event.eventType?.rawValue as Any],
                                                                 "participants": participants as Any],
                                                urlParameters: nil,
                                                additionHeaders: headers)
        case .feedback(feedback: let feedback):
            return .requestParametersAndHeaders(bodyParameters: ["feedback": feedback],
                                                urlParameters: nil,
                                                additionHeaders: headers)
        case .invite(email: let email, firstName: let firstName, lastName: let lastName):
            return .requestParameters(bodyParameters: ["email": email,
                                                       "first_name": firstName,
                                                       "last_name": lastName as Any],
                                      urlParameters: nil)
        case .changePassword(password: let password, newPassword: let newPassword):
            return .requestParametersAndHeaders(bodyParameters: ["password": password.toBase64(),
                                                                 "new_password": newPassword.toBase64()],
                                                urlParameters: nil,
                                                additionHeaders: headers)
        case .deleteUser,
             .logout,
             .getUserStatus,
             .checkProfile,
             .getProfile,
             .getContactList,
             .getEventForDate,
             .getEvenyForId,
             .deleteEvent,
             .getSettings:
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionHeaders: headers)
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        guard let myToken = Auth_Info.instance.token else { return nil }
        switch self {
        case .deleteUser,
             .logout,
             .getUserStatus,
             .checkProfile,
             .getProfile,
             .updateProfile,
             .getContactList,
             .setEvent,
             .getEventForDate,
             .getEvenyForId,
             .deleteEvent,
             .feedback,
             .changePassword,
             .getSettings:
            return ["Content-Type": "application/json",
                    "X-Auth-Token": myToken]
        default:
            return nil
        }
    }
}
