//
//  GetEventForId.swift
//  HelpDoctor
//
//  Created by Anton Fomkin on 16.11.2019.
//  Copyright © 2019 Anton Fomkin. All rights reserved.
//

import Foundation

func parseJSON_getEventForId(for startPoint: [String: Any]?,
                             response: URLResponse?) -> ([ScheduleEvents], Int?, String?)? {
    
    var event: ScheduleEvents
    
    guard  let httpResponse = response as? HTTPURLResponse
        else { return ([], nil, nil) }
    
    guard let startPoint = startPoint else { return ([], nil, nil) }
    guard let eventId = startPoint["id"] as? Int,
        let startDate = startPoint["start_date"] as? String,
        let endDate = startPoint["end_date"] as? String,
        let eventType = startPoint["event_type"] as? String
        else { return ([], nil, nil) }
    
    event = ScheduleEvents(id: eventId,
                           start_date: startDate,
                           end_date: endDate,
                           notify_date: startPoint["notify_date"] as? String,
                           title: startPoint["title"] as? String,
                           description: startPoint["description"] as? String,
                           is_major: startPoint["is_major"] as? Bool,
                           event_place: startPoint["event_place"] as? String,
                           event_type: eventType,
                           participants: startPoint["participants"] as? [AnyObject])
    
    return ([event], httpResponse.statusCode, nil)
}
