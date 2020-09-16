//
//  GetAddedProfileInterests.swift
//  HelpDoctor
//
//  Created by Anton Fomkin on 28.11.2019.
//  Copyright © 2019 Anton Fomkin. All rights reserved.
//

import Foundation

func parseJSON_addProfileInterests(startPoint: [String: AnyObject]?,
                                   startPoint2: [AnyObject]?,
                                   response: URLResponse?) -> ([Interest], Int?, String?)? {
    
    var addInterests: [Interest] = []
    var responce: (Int?, String?)?
    
    guard  let httpResponse = response as? HTTPURLResponse
        else { return ([], nil, nil) }
    
    responce = (httpResponse.statusCode, nil)
    
    switch httpResponse.statusCode {
    case 200:
        guard let startPoint = startPoint else { return ([], nil, nil) }
        guard let intId = startPoint["id"] as? Int else { return ([], nil, nil) }
        addInterests.append(Interest(id: intId,
                                            specializationCode: nil,
                                            name: startPoint["name"] as? String))
    case 409:
        guard let startPoint2 = startPoint2 else { return ([], nil, nil) }
        for finalObj in startPoint2 {
            guard let obj = finalObj as? [String: Any] else { return ([], nil, nil) }
            guard let intId = obj["id"] as? Int else { continue }
            addInterests.append(Interest(id: intId,
                                                specializationCode: nil,
                                                name: obj["name"] as? String))
        }
    default:
        guard let startPoint = startPoint else { return ([], nil, nil) }
        responce = parseJSONPublicMethod(for: startPoint as [String: AnyObject], response: response)
    }
    
    return (addInterests, responce?.0, responce?.1)
}
