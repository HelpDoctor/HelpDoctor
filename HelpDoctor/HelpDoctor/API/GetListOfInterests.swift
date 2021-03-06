//
//  GetListOfInterests.swift
//  HelpDoctor
//
//  Created by Anton Fomkin on 28.10.2019.
//  Copyright © 2019 Anton Fomkin. All rights reserved.
//

import Foundation
//swiftlint:disable force_cast
func parseJSON_getListOfInterests(for startPoint: [String: AnyObject]?,
                                  response: URLResponse?) -> ([String: [ListOfInterests]], [Int]?, Int?, String?)? {
    var arrListOfInterests: [ListOfInterests] = []
    var dictListOfInterests: [String: [ListOfInterests]] = [:]
    var idRelevantInterests: [Int] = []
    
    guard  let httpResponse = response as? HTTPURLResponse
        else { return ([:], nil, nil, nil) }
    
    guard let startPoint = startPoint else { return ([:], nil, nil, nil) }
    
    for (key, _) in startPoint {
        
        arrListOfInterests = []
        let arrItems = startPoint[key] as! [AnyObject]
        
        for finalObj in arrItems {
            guard let obj = finalObj as? [String: Any] else { return ([:], nil, nil, nil) }
            
            if key == "relevant" {
                idRelevantInterests.append(obj["interest_id"] as! Int)
            } else {
                guard let id = obj["id"] as? Int else { continue }
                arrListOfInterests.append(ListOfInterests(id: id,
                                                          specializationCode: obj["specialization_code"] as? String,
                                                          name: obj["name"] as? String))
            }
            dictListOfInterests[key] = arrListOfInterests
        }
    }
    
    return (dictListOfInterests, idRelevantInterests, httpResponse.statusCode, nil)
}
