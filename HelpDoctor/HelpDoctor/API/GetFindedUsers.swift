//
//  GetFindedUsers.swift
//  HelpDoctor
//
//  Created by Anton Fomkin on 29.11.2019.
//  Copyright © 2019 Anton Fomkin. All rights reserved.
//
/*
import Foundation

func parseJSON_getFindedUsers(for startPoint: [String: AnyObject]?,
                              response: URLResponse?) -> ([ResultFindedUsers], Int?, String?)? {
    
    var dataProfile: [ResultFindedUsers] = []
    var job_places: [Job] = []
    var specializations: [Specialization] = []
    var responceCode: Int?
    var responceDescription: String?
    
    guard let httpResponse = response as? HTTPURLResponse
        else { return ([], nil, nil) }
    
    guard var startPoint = startPoint else { return ([], nil, nil) }
    
    responceCode = httpResponse.statusCode
    
    switch responceCode {
    case 200:
        let size = startPoint["size"] as! Int
        if size != 0 {
            startPoint.removeValue(forKey: "size")
            
            let arrItems = startPoint["users"] as! [AnyObject]
            
            for finalObj in arrItems {
                guard let obj = finalObj as? [String: Any] else { return ([], nil, nil) }
                
                if obj["job_places"] as? [AnyObject] != nil {
                    job_places = []
                    let jobArray = obj["job_places"] as! [AnyObject]
                    for items in jobArray {
                        let item = items as! [String: Any]
                        let job = Job(id: 0,
                                      isMain: item["is_main"] as? Bool,
                                      organization: item["organization"] as? MedicalOrganization)
                        //                        let job = ProfileKeyJob(id: nil,
                        //                                                job_oid: item["oid"] as? String,
                        //                                                is_main: item["is_main"] as? Bool,
                        //                                                organization: item["organization"] as? MedicalOrganization)
                        //                                                nameShort: item["nameShort"] as? String)
                        job_places.append(job)
                    }
                }
                
                if obj["specializations"] as? [AnyObject] != nil {
                    specializations = []
                    let specializationsArray = obj["specializations"] as! [AnyObject]
                    for items in specializationsArray {
                        let item = items as! [String: Any]
                        guard let specId = item["id"] as? Int else { continue }
                        let spec = Specialization(id: specId,
                                                  isMain: item["is_main"] as? Bool,
                                                  specialization: item["specialization"] as? MedicalSpecialization)
//                        let spec = ProfileKeySpec(id: item["id"] as? Int,
//                                                  spec_id: nil,
//                                                  is_main: item["is_main"] as? Bool,
//                                                  code: nil,
//                                                  name: item["name"] as? String)
                        
                        specializations.append(spec)
                    }
                }
                guard let userId = obj["id"] as? Int else { continue }
                var verifiedUser = false
                if UserDefaults.standard.string(forKey: "userStatus") == "verified" {
                    verifiedUser = true
                }
                let user = User(id: userId,
                                firstName: obj["first_name"] as? String,
                                lastName: obj["last_name"] as? String,
                                middleName: obj["middle_name"] as? String,
                                gender: nil,
                                email: nil,
                                phoneNumber: nil,
                                birthday: nil,
                                cityId: nil,
                                cityName: nil,
                                regionId: nil,
                                regionName: nil,
                                foto: obj["foto"] as? String,
                                isMedicWorker: nil,
                                verifiedUser: verifiedUser)
                //                let user = ProfileKeyUser(id: obj["id"] as? Int,
                //                                          first_name: obj["first_name"] as? String,
                //                                          last_name: obj["last_name"] as? String,
                //                                          middle_name: obj["middle_name"] as? String,
                //                                          email: nil,
                //                                          phone_number: nil,
                //                                          birthday: nil,
                //                                          city_id: nil,
                //                                          cityName: nil,
                //                                          regionId: nil,
                //                                          regionName: nil,
                //                                          foto: obj["foto"] as? String,
                //                                          gender: nil,
                //                                          is_medic_worker: nil)
                
                dataProfile.append(ResultFindedUsers(user: user,
                                                     job_places: job_places,
                                                     specializations: specializations))
                
            }
        }
        
    default:
        let getError = parseJSONPublicMethod(for: startPoint as [String: AnyObject], response: response)
        responceDescription = getError?.1
    }
    
    return (dataProfile, responceCode, responceDescription)
}
*/
