//
//  Job.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 14.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

struct Job: Codable {
    let id: Int
    let isMain: Bool?
    let organization: MedicalOrganization?
    private enum CodingKeys: String, CodingKey {
        case id
        case isMain = "is_main"
        case organization
    }
}