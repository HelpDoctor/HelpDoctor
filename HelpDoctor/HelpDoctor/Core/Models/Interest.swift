//
//  Interest.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 14.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

struct Interest: Codable {
    let id: Int
    let interest: ListOfInterests?
    private enum CodingKeys: String, CodingKey {
        case id
        case interest
    }
}
