//
//  GetRegions.swift
//  HelpDoctor
//
//  Created by Anton Fomkin on 21/10/2019.
//  Copyright © 2019 Anton Fomkin. All rights reserved.
//

import Foundation

func parseJSON_getRegions (for startPoint: [AnyObject]?,
                           response: URLResponse?) -> ([Regions], Int?, String?)? {
    var arrRegions: [Regions] = []
    
    guard let httpResponse = response as? HTTPURLResponse
        else { return ([], nil, nil) }
    
    guard let startPoint = startPoint else { return ([], nil, nil) }
    
    for finalObj in startPoint {
        guard let obj = finalObj as? [String: Any] else { return ([], nil, nil) }
        guard let regionId = obj["regionId"] as? Int else { continue }
        arrRegions.append(Regions(regionId: regionId,
                                  regionName: obj["regionName"] as? String))
    }
    return (arrRegions, httpResponse.statusCode, nil)
}
