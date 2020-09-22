//
//  GetEventsForCurrentDate.swift
//  HelpDoctor
//
//  Created by Anton Fomkin on 15.11.2019.
//  Copyright © 2019 Anton Fomkin. All rights reserved.
//
/*
import Foundation

func parseJSON_getEventsForCurrentDate(for startPoint: [AnyObject]?,
                                       response: URLResponse?) -> ([ScheduleEvents], Int?, String?)? {
    var arrEvents: [ScheduleEvents] = []
    
    guard  let httpResponse = response as? HTTPURLResponse
        else { return ([], nil, nil) }
    
    guard let startPoint = startPoint else { return ([], nil, nil) }
    
    for finalObj in startPoint {
        guard let obj = finalObj as? [String: Any] else { return ([], nil, nil) }
        guard let eventId = obj["id"] as? Int,
            let startDate = obj["start_date"] as? String,
            let endDate = obj["end_date"] as? String,
            let eventType = obj["event_type"] as? String
            else { continue }
        
        arrEvents.append(ScheduleEvents(id: eventId,
                                        start_date: startDate,
                                        end_date: endDate,
                                        notify_date: obj["notify_date"] as? String,
                                        title: obj["title"] as? String,
                                        description: obj["description"] as? String,
                                        is_major: obj["is_major"] as? Bool,
                                        event_place: obj["event_place"] as? String,
                                        event_type: eventType,
                                        participants: obj["participants"] as? [AnyObject]))
        
    }
    return (arrEvents, httpResponse.statusCode, nil)
}
*/
