//
//  Education.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 14.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

struct Education: Codable {
    let id: Int
    let isMain: Bool?
    let yearEnding: Int?
    let academicDegree: String?
    let education: University?
    private enum CodingKeys: String, CodingKey {
        case id
        case isMain = "is_main"
        case yearEnding = "year_ending"
        case academicDegree = "academic_degree"
        case education
    }
}
