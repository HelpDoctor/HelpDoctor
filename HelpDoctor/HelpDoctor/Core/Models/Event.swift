//
//  Event.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 21.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

struct Event: Codable {
    struct Participant: Codable {
        let id: Int?
        let fullName: String?
        
        enum CodingKeys: String, CodingKey {
            case id = "user_id"
            case fullName = "full_name"
        }
    }
    
    let id: Int?
    let startDate: String
    let endDate: String
    let notifyDate: String?
    let title: String?
    let description: String?
    let isMajor: Bool?
    let eventPlace: String?
    let eventType: EventType?
    let participants: [Participant]?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case startDate = "start_date"
        case endDate = "end_date"
        case notifyDate = "notify_date"
        case title
        case description
        case isMajor = "is_major"
        case eventPlace = "event_place"
        case eventType = "event_type"
        case participants
    }
}

struct EventForDate: Codable {
    let date: String
    let isEvent: Bool
    
    private enum CodingKeys: String, CodingKey {
        case date
        case isEvent = "is_event"
    }
}
