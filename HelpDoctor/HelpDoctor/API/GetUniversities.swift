//
//  GetUniversities.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 11.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//
/*
import Foundation

func parseJSON_getUniversities (for startPoint: [AnyObject]?,
                                response: URLResponse?) -> ([University], Int?, String?)? {
    var arrUniversities: [University] = []
    
    guard let httpResponse = response as? HTTPURLResponse
        else { return ([], nil, nil) }
    
    guard let startPoint = startPoint else { return ([], nil, nil) }
    
    for finalObj in startPoint {
        guard let obj = finalObj as? [String: Any] else { return ([], nil, nil) }
        guard let universityId = obj["educationId"] as? Int else { continue }
        arrUniversities.append(University(educationId: universityId,
                                          educationName: obj["educationName"] as? String))
    }
    return (arrUniversities, httpResponse.statusCode, nil)
}
*/
