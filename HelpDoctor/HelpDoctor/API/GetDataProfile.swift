//
//  GetDataProfile.swift
//  HelpDoctor
//
//  Created by Anton Fomkin on 03.11.2019.
//  Copyright © 2019 Anton Fomkin. All rights reserved.
//

import Foundation
//swiftlint:disable force_cast
//swiftlint:disable function_body_length
//swiftlint:disable cyclomatic_complexity
func parseJSON_getDataFromProfile(for startPoint: [String: AnyObject]?,
                                  response: URLResponse?) -> ([String: [AnyObject]], Int?, String?)? {
    
    var profileKeyUser: [ProfileKeyUser] = []
    var profileKeyJob: [ProfileKeyJob] = []
    var profileKeySpec: [ProfileKeySpec] = []
    var profileKeyInterests: [ProfileKeyInterests] = []
    var dataProfile: [String: [AnyObject]] = [:]
    
    //let key = "general"
    guard let httpResponse = response as? HTTPURLResponse
        else { return ([:], nil, nil) }
    
    guard var startPoint = startPoint else { return ([:], nil, nil) }
    
    let user = startPoint["user"] as! [String: Any]
    profileKeyUser.append(ProfileKeyUser(id: user["id"] as? Int,
                                         first_name: user["first_name"] as? String,
                                         last_name: user["last_name"] as? String,
                                         middle_name: user["middle_name"] as? String,
                                         email: user["email"] as? String,
                                         phone_number: user["phone_number"] as? String,
                                         birthday: user["birthday"] as? String,
                                         city_id: user["city_id"] as? Int,
                                         cityName: user["cityName"] as? String,
                                         regionId: user["regionId"] as? Int,
                                         regionName: user["regionName"] as? String,
                                         foto: user["foto"] as? String,
                                         gender: user["gender"] as? String,
                                         is_medic_worker: user["is_medic_worker"] as? Int))
    
    dataProfile["user"] = profileKeyUser as [AnyObject]
    startPoint.removeValue(forKey: "user")
    
    for (key, _) in startPoint {
        
//        let arrItems = startPoint[key] as! [AnyObject]
        
//        for finalObj in arrItems {
            /*guard*/ let obj = startPoint[key]/* as? [String: Any] else { /*continue*/ return ([:], nil, nil) }*/
            
            switch key {
            case "interests":
                profileKeyInterests.append(ProfileKeyInterests(interest_id: obj?["interest_id"] as? Int,
                                                               spec_code: obj?["spec_code"] as? String,
                                                               name: obj?["name"] as? String))
            case "job":
                profileKeyJob.append(ProfileKeyJob(id: obj?["id"] as? Int,
//                                                   job_oid: obj?["job_oid"] as? String,
                                                   is_main: obj?["is_main"] as? Bool,
                                                   organization: obj?["organization"] as? MedicalOrganization))
//                                                   nameShort: obj?["nameShort"] as? String))
            case "spec":
                profileKeySpec.append(ProfileKeySpec(id: obj?["id"] as? Int,
                                                     spec_id: obj?["spec_id"] as? Int,
                                                     is_main: obj?["is_main"] as? Bool,
                                                     code: obj?["code"] as? String,
                                                     name: obj?["name"] as? String))
            case "education":
                print("education")
            default:
                continue
            }
//        }
        if key == "interests" { dataProfile[key] = profileKeyInterests as [AnyObject] }
        if key == "job" { dataProfile[key] = profileKeyJob as [AnyObject] }
        if key == "spec" { dataProfile[key] = profileKeySpec as [AnyObject] }
    }
    
    return (dataProfile, httpResponse.statusCode, nil)
}
