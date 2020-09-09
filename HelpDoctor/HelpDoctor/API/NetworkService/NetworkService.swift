//
//  NetworkService.swift
//  HelpDoctor
//
//  Created by Anton Fomkin on 14/10/2019.
//  Copyright © 2019 Anton Fomkin. All rights reserved.
//

import UIKit
//swiftlint:disable type_name
//swiftlint:disable force_cast
//swiftlint:disable function_body_length
//swiftlint:disable cyclomatic_complexity
class Auth_Info {
    
    static let instance = Auth_Info()
    
    private init() {
        self.token = KeychainWrapper.standard.string(forKey: "myToken")
    }
    var token: String?
}

var myToken: String? {
    let getToken = Auth_Info.instance
    return getToken.token
}

func getCurrentDate(dateFormat: TypeOfDate) -> String {
    let date = NSDate()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat.rawValue
    return dateFormatter.string(from: date as Date)
}

enum TypeOfDate: String {
    case long =  "yyyy-MM-dd HH:mm:ss"
    case short = "yyyy-MM-dd"
}

enum TypeOfRequest: String {
    /*Регистрация*/
    case registrationMail = "/registration"
    case recoveryMail = "/recovery"
    case deleteMail = "/registration/del"
    
    /* Получение токена*/
    case getToken = "/auth/login"
    
    /* Разлогиниться */
    case logout = "/auth/logout"
    
    case getRegions = "/profile/regions"
    case getListCities = "/profile/cities/"
    case getMedicalOrganization = "/profile/works/"
    case getMedicalSpecialization = "/profile/specializations"
    case getListOfInterests = "/profile/sc_interests/"
    case getListOfInterestsExtOne = "/profile/sc_interests_speccode1/"
    case getListOfInterestsExtTwo = "/profile/sc_interests_speccode2/"
    case getUniversities = "/profile/educations"
    case checkProfile = "/profile/check"
    case updateProfile = "/profile/update"
    case getDataFromProfile = "/profile/get"
    case addProfileInterest = "/profile/sc_interests/add"
    case schedule_CreateOrUpdateEvent = "/event/set"
    case schedule_getEventsForCurrentDate = "/event/date/"
    case schedule_getEventsForCurrentId = "/event/get/"
    case schedule_deleteForCurrentEvent = "/event/del/"
    case findUsers = "/seach/users"
    case userStatus = "/profile/user_status"
    case getSettings = "/profile/settings"
    case updateSettings = "/profile/settings/update"
    case changePassword = "/profile/change_password"
    case feedback = "/support/feedback"
    case invite = "/registration/invite"
    case getContactList = "/contact_list/get"
}

enum NetworkMimeType: String {
    
    case jpeg, jpg = "image/jpeg"
    case png = "image/png"
    case heic = "image/heic"
    case pdf = "application/pdf"
    
}

func uploadImage<T>(source: URL,
                    returning: T.Type,
                    completionBlock: @escaping (T?) -> Void) {
    var replyReturn: T?
    guard let url = URL(string: "http://demo22.tmweb.ru/public/api/profile/verification") else { return }
    let fileName = source.path
    var mimeType: NetworkMimeType?
    switch source.pathExtension.lowercased() {
    case "heic":
        mimeType = .heic
    case "jpeg":
        mimeType = .jpeg
    case "jpg":
        mimeType = .jpg
    case "png":
        mimeType = .png
    case "pdf":
        mimeType = .pdf
    default:
        break
    }

    let boundary = "Boundary-\(UUID().uuidString)"
    let session = URLSession.shared
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"

    urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    urlRequest.setValue(myToken, forHTTPHeaderField: "X-Auth-Token")

    var body = Data()
    let encoding: UInt = String.Encoding.utf8.rawValue
    guard let fileType = mimeType?.rawValue else { return }
    if let boundaryStartData = "--\(boundary)\r\n".data(using: String.Encoding(rawValue: encoding)),
        let fileNameData = "Content-Disposition:form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: String.Encoding(rawValue: encoding)),
        let contentTypeData = "Content-Type: \(fileType)\r\n\r\n".data(using: String.Encoding(rawValue: encoding)),
        let endLineData = "\r\n".data(using: String.Encoding(rawValue: encoding)),
        let boundaryEndData = "--\(boundary)--\r\n".data(using: String.Encoding(rawValue: encoding)) {
        body.append(boundaryStartData)
        body.append(fileNameData)
        body.append(contentTypeData)
        body.append(endLineData)
        body.append(boundaryEndData)

    }
    
    session.uploadTask(with: urlRequest, from: body) { (data: Data?, response: URLResponse?, error: Error?) in
        guard let data = data, error == nil else { return }
        
        guard let json = try? JSONSerialization.jsonObject(with: data,
                                                           options: .allowFragments)
            else { return }
        
        print(json)
        guard let startPoint = json as? [String: AnyObject] else { return }
        replyReturn = (parseJSONPublicMethod(for: startPoint, response: response) as? T)
        DispatchQueue.main.async {
            completionBlock(replyReturn)
        }
    }.resume()
    
}

func getCurrentSession (typeOfContent: TypeOfRequest,
                        requestParams: [String: Any]) -> (URLSession, URLRequest) {
    
    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration)
    var urlConstructor = URLComponents()
    
    urlConstructor.scheme = "http"
    urlConstructor.host = "demo22.tmweb.ru"//"helpdoctor.tmweb.ru"
    urlConstructor.path = "/public/api" + typeOfContent.rawValue
    
    if typeOfContent == .getListCities || typeOfContent == .getMedicalOrganization {
        urlConstructor.path = "/public/api" + typeOfContent.rawValue + (requestParams["region"] as! String)
    }
    
    if typeOfContent == .getListOfInterestsExtOne || typeOfContent == .getListOfInterestsExtTwo {
        urlConstructor.path = "/public/api" + typeOfContent.rawValue + (requestParams["spec_code"] as! String)
    }
    
    if typeOfContent == .schedule_getEventsForCurrentDate {
        if requestParams["AnyDate"] != nil {
            urlConstructor.path = "/public/api" + typeOfContent.rawValue + (requestParams["AnyDate"] as! String)
        } else {
            urlConstructor.path = "/public/api" + typeOfContent.rawValue + getCurrentDate(dateFormat: .short)
        }
    }
    
    if typeOfContent == .schedule_getEventsForCurrentId {
        urlConstructor.path = "/public/api" + typeOfContent.rawValue + (requestParams["event_id"] as! String)
    }
    
    if typeOfContent == .schedule_deleteForCurrentEvent {
        urlConstructor.path = "/public/api" + typeOfContent.rawValue + (requestParams["event_id"] as! String)
    }
    
    if (typeOfContent == .getDataFromProfile) && (requestParams.count > 0) {
        urlConstructor.path = "/public/api" + typeOfContent.rawValue + "/" + (requestParams["user_id"] as! String)
    }
    var request = URLRequest(url: urlConstructor.url!)
    
    switch typeOfContent {
    case .registrationMail, .recoveryMail, .getToken, .logout, .checkProfile, .getDataFromProfile, .deleteMail:
        
        let jsonData = serializationJSON(obj: requestParams as! [String: String])
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if typeOfContent == .logout ||
            typeOfContent == .checkProfile ||
            typeOfContent == .getDataFromProfile ||
            typeOfContent == .deleteMail {
            request.setValue(myToken, forHTTPHeaderField: "X-Auth-Token")
        } else {
            request.httpBody = jsonData
        }
        
    case .changePassword, .invite:
        let jsonData = serializationJSON(obj: requestParams as! [String: String])
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(myToken, forHTTPHeaderField: "X-Auth-Token")
        request.httpBody = jsonData
        
    case .addProfileInterest:
        let jsonData = serializationJSON(obj: requestParams as! [String: String])
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(myToken, forHTTPHeaderField: "X-Auth-Token")
        request.httpBody = jsonData
        
    case .updateProfile, .schedule_CreateOrUpdateEvent, .findUsers, .updateSettings:
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(myToken, forHTTPHeaderField: "X-Auth-Token")
        request.httpBody = requestParams["json"] as? Data
        
    case .schedule_getEventsForCurrentDate, .schedule_getEventsForCurrentId, .schedule_deleteForCurrentEvent:
        
        request.setValue(myToken, forHTTPHeaderField: "X-Auth-Token")
        
    case .userStatus, .getSettings, .getContactList:
        request.httpMethod = "GET"
        request.setValue(myToken, forHTTPHeaderField: "X-Auth-Token")
        
    case .feedback:
        let jsonData = serializationJSON(obj: requestParams as! [String: String])
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(myToken, forHTTPHeaderField: "X-Auth-Token")
        request.httpBody = jsonData
        
    default:
        break
    }
    
    return (session, request)
}

private func serializationJSON(obj: [String: String]) -> Data? {
    return try? JSONSerialization.data(withJSONObject: obj)
}

func getData<T>(typeOfContent: TypeOfRequest,
                returning: T.Type,
                requestParams: [String: Any],
                completionBlock: @escaping (T?) -> Void) {
    
    let currentSession = getCurrentSession(typeOfContent: typeOfContent, requestParams: requestParams)
    let session = currentSession.0
    let request = currentSession.1
    var replyReturn: T?
    
    _ = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
        guard let data = data, error == nil else { return }
        
        DispatchQueue.global().async {
            
            guard let json = try? JSONSerialization.jsonObject(with: data,
                                                               options: JSONSerialization.ReadingOptions.allowFragments)
                else { return }
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            let responceTrueResult = responceCode(code: httpResponse.statusCode)
            
            switch typeOfContent {
            case .registrationMail,
                 .recoveryMail,
                 .deleteMail,
                 .logout,
                 .checkProfile,
                 .updateProfile,
                 .schedule_CreateOrUpdateEvent,
                 .schedule_deleteForCurrentEvent,
                 .updateSettings,
                 .changePassword,
                 .feedback:
                guard let startPoint = json as? [String: AnyObject] else { return }
                replyReturn = (parseJSONPublicMethod(for: startPoint, response: response) as? T)
                
            case .getToken:
                guard let startPoint = json as? [String: AnyObject] else { return }
                replyReturn = (parseJSON_getToken(for: startPoint, response: response) as? T)
                
            case .getRegions :
                
                if responceTrueResult {
                    guard let startPoint = json as? [AnyObject] else { return }
                    replyReturn = (parseJSON_getRegions(for: startPoint, response: response) as? T)
                } else {
                    replyReturn = (([], 500, "Данные недоступны") as? T)
                }
            case .getUniversities :
                
                if responceTrueResult {
                    guard let startPoint = json as? [AnyObject] else { return }
                    replyReturn = (parseJSON_getRegions(for: startPoint, response: response) as? T)
                } else {
                    replyReturn = (([], 500, "Данные недоступны") as? T)
                }
            case .getListCities :
                
                if responceTrueResult {
                    guard let startPoint = json as? [AnyObject] else { return }
                    replyReturn = (parseJSON_getCities(for: startPoint, response: response) as? T)
                } else {
                    replyReturn = (([], 500, "Данные недоступны") as? T)
                }
                
            case .getMedicalOrganization:
                
                if responceTrueResult {
                    guard let startPoint = json as? [AnyObject] else { return }
                    replyReturn = (parseJSON_getMedicalOrganization(for: startPoint, response: response) as? T)
                } else {
                    replyReturn = (([], 500, "Данные недоступны") as? T)
                }
            case .getMedicalSpecialization:
                
                if responceTrueResult {
                    guard let startPoint = json as? [AnyObject] else { return }
                    replyReturn = (parseJSON_getMedicalSpecialization(for: startPoint, response: response) as? T)
                } else {
                    replyReturn = (([], 500, "Данные недоступны") as? T)
                }
            case .getListOfInterests, .getListOfInterestsExtOne, .getListOfInterestsExtTwo:
                
                if responceTrueResult {
                    guard let startPoint = json as? [String: AnyObject] else { return }
                    replyReturn = (parseJSON_getListOfInterests(for: startPoint, response: response) as? T)
                } else {
                    replyReturn = (([], 500, "Данные недоступны") as? T)
                }
                
            case .getDataFromProfile:
                
                if responceTrueResult {
                    guard let startPoint = json as? [String: AnyObject] else { return }
                    replyReturn = (parseJSON_getDataFromProfile(for: startPoint, response: response) as? T)
                } else {
                    
                    switch httpResponse.statusCode {
                    case 404:
                        replyReturn = (([:], httpResponse.statusCode, "user not found") as? T)
                    default:
                        replyReturn = (([:], httpResponse.statusCode, "Данные недоступны") as? T)
                    }
                    
                }
                
            case .schedule_getEventsForCurrentDate:
                guard let startPoint = json as? [AnyObject] else { return }
                replyReturn = (parseJSON_getEventsForCurrentDate(for: startPoint, response: response) as? T)
                
                
            case .schedule_getEventsForCurrentId:
                guard let startPoint = json as? [String: AnyObject] else { return }
                replyReturn = (parseJSON_getEventForId(for: startPoint, response: response) as? T)
                
            case .addProfileInterest:
                let startPoint = json as? [String: AnyObject]
                let startPoint2 = json as? [AnyObject]
                if startPoint == nil && startPoint2 == nil { return }
                
                replyReturn = (parseJSON_addProfileInterests(startPoint: startPoint,
                                                             startPoint2: startPoint2,
                                                             response: response) as? T)
                
            case .findUsers:
                guard let startPoint = json as? [String: AnyObject] else { return }
                replyReturn = (parseJSON_getFindedUsers(for: startPoint, response: response) as? T)
            case .userStatus:
                guard let startPoint = json as? [String: AnyObject] else { return }
                replyReturn = (parseJSON_getVerification(for: startPoint, response: response) as? T)
            case .getSettings:
                guard let startPoint = json as? [String: AnyObject] else { return }
                replyReturn = (parseJSON_getSettings(for: startPoint, response: response) as? T)
            case .invite:
                guard let startPoint = json as? [String: AnyObject] else { return }
                replyReturn = (parseJSONPublicMethod(for: startPoint, response: response) as? T)
                
            case .getContactList:
                guard let startPoint = json as? [String: AnyObject] else { return }
                replyReturn = (parseJSON_getContactList(for: startPoint, response: response) as? T)
                
            }
            DispatchQueue.main.async {
                completionBlock(replyReturn)
            }
        }
    }.resume()
}

func responceCode(code: Int) -> Bool {
    return code == 200 ? true : false
//    if code == 200 {
//        return true
//    } else {
//        return false
//    }
}

func prepareRequestParams(email: String?,
                          password: String?,
                          token: String?) -> [String: String] {
    var requestParams: [String: String] = [:]
    requestParams["email"] = email
    requestParams["password"] = password?.toBase64()
    requestParams["X-Auth-Token"] = token
    return requestParams
}

func todoJSON(obj: [String: Any]) -> Data? {
    return try? JSONSerialization.data(withJSONObject: obj)
}

func todoJSONAny(obj: Any) -> Data? {
    return try? JSONSerialization.data(withJSONObject: obj)
}

func todoJSON_Array(obj: [String: [Any]]) -> Data? {
    return try? JSONSerialization.data(withJSONObject: obj)
}

// MARK: - Примеры вызова
/*
 let getToken = Registration.init(email: "test@yandex.ru", password: "zNyF9Tts3r", token: nil)
 
 getData(typeOfContent:.getToken,
 returning:(Int?,String?).self,
 requestParams: getToken.requestParams )
 { [weak self] result in
 let dispathGroup = DispatchGroup()
 getToken.responce = result
 
 dispathGroup.notify(queue: DispatchQueue.main) {
 DispatchQueue.main.async { [weak self]  in
 print("result= \(getToken.responce)")
 }
 }
 }
 */

/* -------------- */

/*
 let unRegistration = Registration(email: nil, password: nil, token: nil)
 getData(typeOfContent:.deleteMail,
 returning:(Int?,String?).self,
 requestParams: [:] )
 { [weak self] result in
 let dispathGroup = DispatchGroup()
 unRegistration.responce = result
 
 dispathGroup.notify(queue: DispatchQueue.main) {
 DispatchQueue.main.async { [weak self]  in
 print("result= \(unRegistration.responce)")
 }
 }
 }
 */

/* -------------- */

/*
 let logout = Registration.init(email: nil, password: nil, token: myToken )
 
 getData(typeOfContent:.logout,
 returning:(Int?,String?).self,
 requestParams: logout.requestParams )
 { [weak self] result in
 let dispathGroup = DispatchGroup()
 logout.responce = result
 
 dispathGroup.notify(queue: DispatchQueue.main) {
 DispatchQueue.main.async { [weak self]  in
 print("result=\(logout.responce)")
 }
 }
 }
 */

/* -------------- */

/*
 let getMedicalOrganization = Profile()
 
 getData(typeOfContent:.getMedicalOrganization,
 returning:([MedicalOrganization],Int?,String?).self,
 requestParams: ["region":"77"] )
 { [weak self] result in
 let dispathGroup = DispatchGroup()
 
 getMedicalOrganization.medicalOrganization = result?.0
 getMedicalOrganization.responce = (result?.1,result?.2)
 dispathGroup.notify(queue: DispatchQueue.main) {
 DispatchQueue.main.async { [weak self]  in
 print("result=\(getMedicalOrganization.medicalOrganization)")
 print(getMedicalOrganization.responce)
 
 }
 }
 }
 */

/* -------------- */

/*
 let getListOfInterest = Profile()
 
 getData(typeOfContent:.getListOfInterestsExtTwo,
 returning:([String:[ListOfInterests]],Int?,String?).self,
 requestParams: ["spec_code":"040100/040101"] )
 { [weak self] result in
 let dispathGroup = DispatchGroup()
 
 getListOfInterest.listOfInterests = result?.0
 
 dispathGroup.notify(queue: DispatchQueue.main) {
 DispatchQueue.main.async { [weak self]  in
 
 print("ListOfInterest = \(getListOfInterest.listOfInterests!)")
 }
 }
 }
 */

/* -------------- */

/*
 let getCities = Profile()
 getData(typeOfContent:.getListCities,
 returning:([Cities],Int?,String?).self,
 requestParams: ["region":"77"] )
 { [weak self] result in
 let dispathGroup = DispatchGroup()
 
 getCities.cities = result?.0
 
 dispathGroup.notify(queue: DispatchQueue.main) {
 DispatchQueue.main.async { [weak self]  in
 print("Cities= \(getCities.cities!)")
 }
 }
 }
 */

/* -------------- */

/*
 let checkProfile = Registration.init(email: nil, password: nil, token: myToken )
 getData(typeOfContent:.checkProfile,
 returning:(Int?,String?).self,
 requestParams: checkProfile.requestParams )
 { [weak self] result in
 let dispathGroup = DispatchGroup()
 checkProfile.responce = result
 
 dispathGroup.notify(queue: DispatchQueue.main) {
 DispatchQueue.main.async { [weak self]  in
 print("result=\(checkProfile.responce)")
 }
 }
 }
 */

/* --------API 12---------- */

/*
 let updateProfile = UpdateProfileKeyUser(first_name: "Антон", last_name: "Иванов", middle_name: nil, phone_number: "1234567", birthday: "1945-01-12",city_id: 77, foto: "zxcvbnm")
 
 getData(typeOfContent:.updateProfile,
 returning:(Int?,String?).self,
 requestParams: ["json":updateProfile.jsonData as Any] )
 { [weak self] result in
 let dispathGroup = DispatchGroup()
 
 updateProfile.responce = result
 
 dispathGroup.notify(queue: DispatchQueue.main) {
 DispatchQueue.main.async { [weak self]  in
 print("updateProfile = \(updateProfile.responce)")
 }
 }
 }
 
 */
/*
 let a: Int? = nil
 let job1 : [String:Any] = ["id": a, "job_oid": "qwert", "is_main": true]
 let job2 : [String:Any] = ["id": a, "job_oid": "qwert1", "is_main": false]
 
 var arr : [Dictionary<String,Any>] = []
 arr.append(job1)
 arr.append(job2)
 
 
 let updateProfile = UpdateProfileKeyJob(arrayJob: arr)
 
 getData(typeOfContent:.updateProfile,
 returning:(Int?,String?).self,
 requestParams: ["json":updateProfile.jsonData as Any])
 { [weak self] result in
 let dispathGroup = DispatchGroup()
 
 updateProfile.responce = result
 
 dispathGroup.notify(queue: DispatchQueue.main) {
 DispatchQueue.main.async { [weak self]  in
 print("updateProfile = \(updateProfile.responce)")
 }
 }
 }
 */
/*
 let a: Int? = nil
 let spec1 : [String:Any] = ["id": a, "spec_id": 9, "is_main": true]
 let spec2 : [String:Any] = ["id": a, "spec_id": 10, "is_main": false]
 
 var arr : [Dictionary<String,Any>] = []
 arr.append(spec1)
 arr.append(spec2)
 
 
 let updateProfile = UpdateProfileKeySpec(arraySpec: arr)
 
 getData(typeOfContent:.updateProfile,
 returning:(Int?,String?).self,
 requestParams: ["json":updateProfile.jsonData as Any])
 { [weak self] result in
 let dispathGroup = DispatchGroup()
 
 updateProfile.responce = result
 
 dispathGroup.notify(queue: DispatchQueue.main) {
 DispatchQueue.main.async { [weak self]  in
 print("updateProfile = \(updateProfile.responce)")
 }
 }
 }
 */

/*
 var arr : [Int] = [1,2,3,4,5,6,7]
 
 
 let updateProfile = UpdateProfileKeyInterest(arrayInterest: arr)
 
 getData(typeOfContent:.updateProfile,
 returning:(Int?,String?).self,
 requestParams: ["json":updateProfile.jsonData as Any])
 { [weak self] result in
 let dispathGroup = DispatchGroup()
 
 updateProfile.responce = result
 
 dispathGroup.notify(queue: DispatchQueue.main) {
 DispatchQueue.main.async { [weak self]  in
 print("updateProfile = \(updateProfile.responce)")
 }
 }
 }
 */

/* --------API 13-------------*/

/*
 let getDataProfile = Profile()
 
 getData(typeOfContent:.getDataFromProfile,
 returning:([String:[AnyObject]],Int?,String?).self,
 requestParams: [:] )
 { [weak self] result in
 let dispathGroup = DispatchGroup()
 getDataProfile.dataFromProfile = result?.0
 
 dispathGroup.notify(queue: DispatchQueue.main) {
 DispatchQueue.main.async { [weak self]  in
 print("getDataProfile = \(getDataProfile.dataFromProfile!)")
 }
 }
 }
 
 */

/* --------API 14-------------*/

/*
 let addInterest = Profile()
 getData(typeOfContent:.addProfileInterest,
 returning:([ListOfInterests],Int?,String?).self,
 requestParams: ["interest":"хирургия"])
 { [weak self] result in
 let dispathGroup = DispatchGroup()
 
 addInterest.addInterests = result?.0
 addInterest.responce = (result?.1,result?.2)
 
 dispathGroup.notify(queue: DispatchQueue.main) {
 DispatchQueue.main.async { [weak self]  in
 print("addInterest = \(addInterest.responce) - \(addInterest.addInterests)")
 }
 }
 }
 */

/* --------Расписание событий API 1-------------*/

/*
 let currentDate = getCurrentDate(dateFormat: .long)
 let currentEvent = ScheduleEvents(id: nil, start_date: currentDate, end_date: currentDate, notify_date: currentDate, title: "My First Event 16", description: "тостовый прием", is_major: true, event_place: "РнД, больница №666", event_type: "reception")
 let createEvent = CreateOrUpdateEvent(events: currentEvent)
 getData(typeOfContent:.schedule_CreateOrUpdateEvent,
 returning:(Int?,String?).self,
 requestParams: ["json":createEvent.jsonData as Any] )
 { [weak self] result in
 let dispathGroup = DispatchGroup()
 
 createEvent.responce = result
 
 dispathGroup.notify(queue: DispatchQueue.main) {
 DispatchQueue.main.async { [weak self]  in
 print("createEvent = \(createEvent.responce)")
 }
 }
 }
 */

/* --------Расписание событий API 2-------------*/
/*
 //Метод для текущей даты
 let getEvents = Schedule()
 getData(typeOfContent:.schedule_getEventsForCurrentDate,
 returning:([ScheduleEvents],Int?,String?).self,
 requestParams: [:] )
 { [weak self] result in
 let dispathGroup = DispatchGroup()
 
 getEvents.events = result?.0
 dispathGroup.notify(queue: DispatchQueue.main) {
 DispatchQueue.main.async { [weak self]  in
 print("getEvents =\(getEvents.events)")
 }
 }
 }
 */

/*
 
 //Метод для любой даты
 let getEvents = Schedule()
 let anyDate = "2019-02-12"
 getData(typeOfContent:.schedule_getEventsForCurrentDate,
 returning:([ScheduleEvents],Int?,String?).self,
 requestParams: ["AnyDate": anyDate] )
 { [weak self] result in
 let dispathGroup = DispatchGroup()
 
 getEvents.events = result?.0
 dispathGroup.notify(queue: DispatchQueue.main) {
 DispatchQueue.main.async { [weak self]  in
 print("getEvents =\(getEvents.events)")
 }
 }
 }
 */

/* --------Расписание событий API 3-------------*/
/*
 let getEvents = Schedule()
 
 getData(typeOfContent:.schedule_getEventsForCurrentId,
 returning:([ScheduleEvents],Int?,String?).self,
 requestParams: ["event_id":"51"] )
 { [weak self] result in
 let dispathGroup = DispatchGroup()
 
 getEvents.events = result?.0
 dispathGroup.notify(queue: DispatchQueue.main) {
 DispatchQueue.main.async { [weak self]  in
 print("getEvents =\(getEvents.events)")
 }
 }
 }
 */

/* --------Расписание событий API 4-------------*/
/*
 let resultDeleteEvents = Schedule()
 getData(typeOfContent:.schedule_deleteForCurrentEvent,
 returning:(Int?,String?).self,
 requestParams: ["event_id":"51"] )
 { [weak self] result in
 let dispathGroup = DispatchGroup()
 
 resultDeleteEvents.responce = result
 dispathGroup.notify(queue: DispatchQueue.main) {
 DispatchQueue.main.async { [weak self]  in
 print("getEvents =\(resultDeleteEvents.responce)")
 }
 }
 }
 */

/* --------Поиск API 1-------------*/
/*
 let findParams = FindUsers(first_name: "серг", middle_name: nil, last_name: nil, email: nil, phone_number: nil, age_from: nil, age_to: nil, city_id: nil, job_places: [], specializations: [], scientific_interests: [], page: 1, limit: 20)
 
 let createFind = CreateFindUsers(findData: findParams) //{Иницализатор для параметрического поиска}
 //   let createFind = CreateFindUsers(page: 1, limit: 20) //{Иницализатор для глобального поиска}
 
 getData(typeOfContent:.findUsers,
 returning:([ResultFindedUsers],Int?,String?).self,
 requestParams: ["json":createFind.jsonData as Any] )
 { [weak self] result in
 let dispathGroup = DispatchGroup()
 createFind.findedData = result?.0
 createFind.responce = (result?.1,result?.2)
 
 dispathGroup.notify(queue: DispatchQueue.main) {
 DispatchQueue.main.async { [weak self]  in
 print("createFind = \(createFind.findedData)\n responce = \(createFind.responce)")
 }
 }
 }
 */

/*
 // Конвертация картинки в Base64String
 let image : UIImage = UIImage(named:"1.jpg")!
 let strBase64 = image.toBase64String()
 //Конвертация Base64String в картинку
 let _: UIImage = (strBase64?.base64ToImage())!
 */
