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
    case getProfileById(id: Int)
    case updateProfile(user: [String: Any]?,
                       job: [[String: Any]]?,
                       spec: [[String: Any]]?,
                       interests: [Int]?,
                       education: [[String: Any]]?)
    case getListOFInterests(specCode: [String])
    case getRegions
    case getCities(regionId: Int)
    case getUniversities
    case getMedicalOrganization(regionId: Int)
    case getMedicalSpecialization
    case getContactList
    case getBlockedUsers
    case setEvent(event: Event)
    case getEventForDate(date: String)
    case getEventForId(id: Int)
    case getEvents(startDate: String, endDate: String)
    case deleteEvent(id: Int)
    case feedback(feedback: String)
    case invite(email: String, firstName: String, lastName: String?)
    case changePassword(password: String, newPassword: String)
    case getSettings
    case updateSettings(settings: Settings)
    case findUsers(query: Profiles)
    case verification(source: URL)
    case removeFromBlockList(id: Int)
    case searchUsers(searchString: String, limit: Int, page: Int)
    case searchUsersWithFilters(query: SearchQuery, limit: Int, page: Int)
    case addContact(id: Int)
    case addToBlockList(id: Int)
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
        case .getProfileById(id: let id):
            return "public/api/profile/get/\(id)"
        case .updateProfile:
            return "public/api/profile/update"
        case .getListOFInterests:
            return "public/api/profile/sc_interests"
        case .getRegions:
            return "public/api/profile/regions"
        case .getCities(regionId: let regionId):
            return "public/api/profile/cities/\(regionId)"
        case .getUniversities:
            return "public/api/profile/educations"
        case .getMedicalOrganization(regionId: let regionId):
            return "public/api/profile/works/\(regionId)"
        case .getMedicalSpecialization:
            return "public/api/profile/specializations"
        case .getContactList:
            return "public/api/contact_list/get"
        case .getBlockedUsers:
            return "public/api/block_list/get"
        case .setEvent:
            return "public/api/event/set"
        case .getEventForDate(date: let date):
            return "public/api/event/date/\(date)"
        case .getEventForId(id: let id):
            return "public/api/event/get/\(id)"
        case .getEvents:
            return "public/api/event/date/range"
        case .deleteEvent(id: let id):
            return "public/api/event/del/\(id)"
        case .feedback:
            return "public/api/support/feedback"
        case .changePassword:
            return "public/api/profile/change_password"
        case .getSettings:
            return "public/api/profile/settings"
        case .updateSettings:
            return "public/api/profile/settings/update"
        case .findUsers:
            return "public/api/seach/users"
        case .verification:
            return "public/api/profile/verification"
        case .addToBlockList(id: let id):
            return "public/api/block_list/add/\(id)"
        case .removeFromBlockList(id: let id):
            return "public/api/block_list/del/\(id)"
        case .searchUsers:
            return "public/api/seach/users"
        case .searchUsersWithFilters:
            return "public/api/seach/users/filters"
        case .addContact(id: let id):
            return "public/api/contact_list/add/\(id)"
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
             .getProfileById,
             .updateProfile,
             .setEvent,
             .feedback,
             .invite,
             .changePassword,
             .updateSettings,
             .findUsers,
             .verification,
             .searchUsers,
             .searchUsersWithFilters:
            return .post
        case .getUserStatus,
             .getListOFInterests,
             .getRegions,
             .getCities,
             .getUniversities,
             .getMedicalOrganization,
             .getMedicalSpecialization,
             .getContactList,
             .getEventForDate,
             .getEventForId,
             .getEvents,
             .deleteEvent,
             .getSettings,
             .getBlockedUsers,
             .removeFromBlockList,
             .addContact,
             .addToBlockList:
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
        case .updateProfile(user: let user,
                            job: let job,
                            spec: let spec,
                            interests: let interests,
                            education: let education):
            return .requestParametersAndHeaders(bodyParameters: ["user": user as Any,
                                                                 "job": job ?? [],
                                                                 "spec": spec ?? [],
                                                                 "interests": interests ?? [],
                                                                 "education": education ?? []],
                                                urlParameters: nil,
                                                additionHeaders: headers)
        case .getListOFInterests(specCode: let specCode):
            var urlParameters = ""
            switch specCode.count {
            case 1:
                urlParameters = "\(specCode[0])"
            case 2:
                urlParameters = "\(specCode[0])&sc_interests[]=\(specCode[1])"
            case 3:
                urlParameters = "\(specCode[0])&sc_interests[]=\(specCode[1])&sc_interests[]=\(specCode[2])"
            case 4:
                urlParameters = "\(specCode[0])&sc_interests[]=\(specCode[1])&sc_interests[]=\(specCode[2])&sc_interests[]=\(specCode[3])"
            case 5:
                urlParameters = "\(specCode[0])&sc_interests[]=\(specCode[1])&sc_interests[]=\(specCode[2])&sc_interests[]=\(specCode[3])&sc_interests[]=\(specCode[4])"
            default:
                urlParameters = ""
            }
            return .requestParameters(bodyParameters: nil, urlParameters: ["sc_interests[]": urlParameters])
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
                                                                    "event_type": event.eventType?.rawValue as Any,
                                                                    "replay": [
                                                                        "period": event.replay?.period as Any,
                                                                        "datetime": event.replay?.replayDateTime as Any,
                                                                        "parent_id": event.replay?.parentId as Any]],
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
        case .updateSettings(settings: let settings):
            return .requestParametersAndHeaders(bodyParameters: ["settings": [
                                                                    "add_friend": settings.addFriend,
                                                                    "consultation": settings.consultation,
                                                                    "email_notification": settings.emailNotification,
                                                                    "invite_pharmcompany": settings.invitePharmcompany,
                                                                    "message_friend": settings.messageFriend,
                                                                    "message_group": settings.messageGroup,
                                                                    "periodicity": settings.periodicity,
                                                                    "push_notification": settings.pushNotification,
                                                                    "vacancy": settings.vacancy]],
                                                urlParameters: nil,
                                                additionHeaders: headers)
        case .findUsers(query: let profile):
            let jobs = profile.job.compactMap({ $0.organization?.oid })
            let specializations = profile.specializations.compactMap({ $0.specialization?.id })
            return .requestParametersAndHeaders(bodyParameters: ["first_name": profile.user.firstName as Any,
                                                                 "middle_name": profile.user.middleName as Any,
                                                                 "last_name": profile.user.lastName as Any,
                                                                 "city_id": profile.user.cityId as Any,
                                                                 "job_places": jobs,
                                                                 "specializations": specializations,
                                                                 "page": 1,
                                                                 "limit": 20],
                                                urlParameters: nil,
                                                additionHeaders: headers)
        case .searchUsers(searchString: let searchString, limit: let limit, page: let page):
            return .requestParametersAndHeaders(bodyParameters: ["search_string": searchString,
                                                                 "limit": limit,
                                                                 "page": page],
                                                urlParameters: nil,
                                                additionHeaders: headers)
        case .searchUsersWithFilters(query: let query, limit: let limit, page: let page):
            return .requestParametersAndHeaders(bodyParameters: ["first_name": query.firstName ?? "",
                                                                 "middle_name": query.middleName ?? "",
                                                                 "last_name": query.lastName ?? "",
                                                                 "age_from": query.ageFrom as Any,
                                                                 "age_to": query.ageTo as Any,
                                                                 "city_id": query.cityId as Any,
                                                                 "job": query.job ?? "",
                                                                 "specialization": query.specialization as Any,
                                                                 "education": query.education as Any,
                                                                 "education_year_ending": query.yearEnding as Any,
                                                                 "interest": query.interest as Any,
                                                                 "page": page,
                                                                 "limit": limit],
                                                urlParameters: nil,
                                                additionHeaders: headers)
        case .getEvents(startDate: let startDate, endDate: let endDate):
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                urlParameters: ["start_date": startDate,
                                                                "end_date": endDate],
                                                additionHeaders: headers)
        case .deleteUser,
             .logout,
             .getUserStatus,
             .checkProfile,
             .getProfile,
             .getProfileById,
             .getContactList,
             .getEventForDate,
             .getEventForId,
             .deleteEvent,
             .getSettings,
             .verification,
             .getBlockedUsers,
             .removeFromBlockList,
             .addContact,
             .addToBlockList:
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
             .getProfileById,
             .updateProfile,
             .getContactList,
             .setEvent,
             .getEventForDate,
             .getEventForId,
             .getEvents,
             .deleteEvent,
             .feedback,
             .changePassword,
             .getSettings,
             .updateSettings,
             .findUsers,
             .getBlockedUsers,
             .removeFromBlockList,
             .searchUsers,
             .searchUsersWithFilters,
             .addContact,
             .addToBlockList:
            return ["Content-Type": "application/json",
                    "X-Auth-Token": myToken]
        case .verification:
            return ["Content-Type": "multipart/form-data; boundary=\(Session.instance.boundary)",
                    "X-Auth-Token": myToken]
        default:
            return nil
        }
    }
    
    var taskMethod: TaskMethods {
        switch self {
        case .verification(source: let source):
            return .upload(source: source)
        default:
            return .data
        }
    }
}

enum TaskMethods {
    case data
    case upload(source: URL)
    case download
}
