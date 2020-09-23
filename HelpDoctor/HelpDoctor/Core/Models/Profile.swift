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
