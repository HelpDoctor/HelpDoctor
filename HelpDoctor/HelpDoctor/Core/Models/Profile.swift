//
//  Profile.swift
//  HelpDoctor
//
//  Created by Anton Fomkin on 21/10/2019.
//  Copyright © 2019 Anton Fomkin. All rights reserved.
//

import Foundation

final class Profile {
    var regions: [Regions]? = []
    var cities: [Cities]? = []
    var medicalOrganization: [MedicalOrganization]? = []
    var medicalSpecialization: [MedicalSpecialization]? = []
    var universities: [University]? = []
    var listOfInterests: [String: [Interest]]? = [:]
    var addInterests: [Interest]? = []
    var dataFromProfile: [String: [AnyObject]]? = [:]
    var responce: (Int?, String?)?
}

struct Profiles: Codable {
    let user: User
    let educations: [Education]
    let job: [Job]
    let specializations: [Specialization]
    let interests: [ProfileInterest]
}
