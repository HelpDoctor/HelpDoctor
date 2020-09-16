//
//  ServerResponse.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 16.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

struct ServerResponse: Codable {
    let status: String
    let message: String?
    private enum CodingKeys: String, CodingKey {
        case status
        case message
    }
}
