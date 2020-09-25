//
//  EventType.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 09.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

enum EventType: String, Codable {
    case reception = "reception"
    case administrative = "administrative"
    case science = "scientific"
    case other = "another"
    
    var description: String {
        switch self {
        case .reception:
            return "Прием пациентов"
        case .administrative:
            return "Административная деятельность"
        case .science:
            return "Научная деятельность"
        case .other:
            return "Другое"
        }
    }
}
