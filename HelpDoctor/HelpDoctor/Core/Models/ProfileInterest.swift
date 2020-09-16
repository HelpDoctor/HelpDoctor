//
//  ProfileInterest.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 14.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

struct ProfileInterest: Codable {
    let id: Int
    let interest: Interest?
    private enum CodingKeys: String, CodingKey {
        case id
        case interest
    }
}

struct ListOfInterests: Codable {
    
    struct RelevantInterest: Codable {
        let interestId: Int
        private enum CodingKeys: String, CodingKey {
            case interestId = "interest_id"
        }
    }
    
    let general: [Interest]
    let relevant: [RelevantInterest]?
    let relevantAdd: [RelevantInterest]?
    
}
