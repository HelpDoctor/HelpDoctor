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
    var universities: [Universities]? = []
    var listOfInterests: [String: [ListOfInterests]]? = [:]
    var addInterests: [ListOfInterests]? = []
    var dataFromProfile: [String: [AnyObject]]? = [:]
    var responce: (Int?, String?)?
}
