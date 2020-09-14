//
//  User.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 14.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let firstName: String?
    let lastName: String?
    let middleName: String?
    let gender: String?
    let email: String?
    let phoneNumber: String?
    let birthday: String?
    let cityId: Int?
    let cityName: String?
    let regionId: Int?
    let regionName: String?
    let foto: String?
    let isMedicWorker: Int?
    let verifiedUser: Bool
    private enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case middleName = "middle_name"
        case gender
        case email
        case phoneNumber = "phone_number"
        case birthday
        case cityId = "city_id"
        case cityName
        case regionId
        case regionName
        case foto
        case isMedicWorker = "is_medic_worker"
        case verifiedUser = "verified_user"
    }
}
