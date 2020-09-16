//
//  GetDataProfile.swift
//  HelpDoctor
//
//  Created by Anton Fomkin on 03.11.2019.
//  Copyright © 2019 Anton Fomkin. All rights reserved.
//

import Foundation

//swiftlint:disable function_body_length
func parseJSON_getDataFromProfile(for startPoint: [String: AnyObject]?,
                                  response: URLResponse?) -> ([String: [AnyObject]], Int?, String?)? {
    
    var profileKeyUser: [User] = []
    var profileKeyJob: [Job] = []
    var profileKeySpec: [Specialization] = []
    var profileKeyInterests: [ProfileKeyInterests] = []
    var dataProfile: [String: [AnyObject]] = [:]
    
    guard let httpResponse = response as? HTTPURLResponse,
        var startPoint = startPoint
        else { return ([:], nil, nil) }
    
    guard let user = startPoint["user"] as? [String: Any],
        let userId = user["id"] as? Int else { return ([:], nil, nil) }
    var verifiedUser = false
    if UserDefaults.standard.string(forKey: "userStatus") == "verified" {
        verifiedUser = true
    }
    profileKeyUser.append(User(id: userId,
                               firstName: user["first_name"] as? String,
                               lastName: user["last_name"] as? String,
                               middleName: user["middle_name"] as? String,
                               gender: user["gender"] as? String,
                               email: user["email"] as? String,
                               phoneNumber: user["phone_number"] as? String,
                               birthday: user["birthday"] as? String,
                               cityId: user["city_id"] as? Int,
                               cityName: user["cityName"] as? String,
                               regionId: user["regionId"] as? Int,
                               regionName: user["regionName"] as? String,
                               foto: user["foto"] as? String,
                               isMedicWorker: user["is_medic_worker"] as? Int,
                               verifiedUser: verifiedUser))
    
    dataProfile["user"] = profileKeyUser as [AnyObject]
    startPoint.removeValue(forKey: "user")
    
    for (key, _) in startPoint {
        
        let obj = startPoint[key]
        
        switch key {
        case "interests":
            profileKeyInterests.append(ProfileKeyInterests(interest_id: obj?["interest_id"] as? Int,
                                                           spec_code: obj?["spec_code"] as? String,
                                                           name: obj?["name"] as? String))
            dataProfile[key] = profileKeyInterests as [AnyObject]
        case "job":
            profileKeyJob.append(Job(id: obj?["id"] as? Int ?? 0,
                                     isMain: obj?["is_main"] as? Bool,
                                     organization: obj?["organization"] as? MedicalOrganization))
            dataProfile[key] = profileKeyJob as [AnyObject]
        case "spec":
            profileKeySpec.append(Specialization(id: obj?["id"] as? Int ?? 0,
                                                 isMain: obj?["is_main"] as? Bool,
                                                 specialization: obj?["specialization"] as? MedicalSpecialization))
            dataProfile[key] = profileKeySpec as [AnyObject]
        case "education":
            print("education")
        default:
            continue
        }

    }
    
    return (dataProfile, httpResponse.statusCode, nil)
}
