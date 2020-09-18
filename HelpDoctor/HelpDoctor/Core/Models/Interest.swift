//
//  Interest.swift
//  HelpDoctor
//
//  Created by Anton Fomkin on 28.10.2019.
//  Copyright © 2019 Anton Fomkin. All rights reserved.
//

import Foundation

struct Interest: Codable {
    let id: Int
    let specializationCode: String?
    let name: String?
    private enum CodingKeys: String, CodingKey {
        case id
        case specializationCode = "specialization_code"
        case name
    }
}
