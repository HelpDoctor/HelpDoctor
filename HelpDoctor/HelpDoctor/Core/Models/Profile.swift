//
//  Profile.swift
//  HelpDoctor
//
//  Created by Anton Fomkin on 21/10/2019.
//  Copyright © 2019 Anton Fomkin. All rights reserved.
//

import Foundation

struct Profiles: Codable {
    let user: User
    let educations: [Education]
    let job: [Job]
    let specializations: [Specialization]
    let interests: [ProfileInterest]
}

struct ProfilesList: Codable {
    var users: [Profiles] = []
    var size: Int = 0
}

struct SearchUserResponseList: Codable {
    var users: [Contacts] = []
    var count: Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case users
        case count = "users_count"
    }
}

struct SearchQuery: Codable {
    var firstName: String?
    var middleName: String?
    var lastName: String?
    var ageFrom: Int?
    var ageTo: Int?
    var cityId: Int?
    var job: String?
    var specialization: Int?
    var education: Int?
    var yearEnding: Int?
    var interest: Int?
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case middleName = "middle_name"
        case lastName = "last_name"
        case ageFrom = "age_from"
        case ageTo = "age_to"
        case cityId = "city_id"
        case job = "job"
        case specialization = "specialization"
        case education = "education"
        case yearEnding = "education_year_ending"
        case interest = "interest"
    }
}
