//
//  AcademicDegree.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 16.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

enum AcademicDegree: String, Codable {
    case candidate
    case doctor
    case academic
    case professor
    case docent
    case null
    
    var label: String {
        switch self {
        case .candidate:
            return "Кандидат наук"
        case .doctor:
            return "Доктор наук"
        case .academic:
            return "Академик наук"
        case .professor:
            return "Профессор"
        case .docent:
            return "Доцент"
        case .null:
            return "Нет степени"
        }
    }
}
