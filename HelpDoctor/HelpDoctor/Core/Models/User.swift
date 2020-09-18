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
    var phoneNumber: String?
    var birthday: String?
    var cityId: Int?
    let cityName: String?
    let regionId: Int?
    let regionName: String?
    var foto: String?
    var isMedicWorker: Int?
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
    
    init(id: Int,
         firstName: String?,
         lastName: String?,
         middleName: String?,
         gender: String?,
         email: String?,
         phoneNumber: String?,
         birthday: String?,
         cityId: Int?,
         cityName: String?,
         regionId: Int?,
         regionName: String?,
         foto: String?,
         isMedicWorker: Int?,
         verifiedUser: Bool) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.middleName = middleName
        self.gender = gender
        self.email = email
        self.phoneNumber = phoneNumber
        self.birthday = birthday
        self.cityId = cityId
        self.cityName = cityName
        self.regionId = regionId
        self.regionName = regionName
        self.foto = foto
        self.isMedicWorker = isMedicWorker
        self.verifiedUser = verifiedUser
    }
    
    init(firstName: String?,
         lastName: String?,
         middleName: String?,
         gender: String?,
         phoneNumber: String?,
         birthday: String?,
         cityId: Int?,
         foto: String?,
         isMedicWorker: Int?) {
        self.id = 0
        self.firstName = firstName
        self.lastName = lastName
        self.middleName = middleName
        self.gender = gender
        self.email = nil
        self.phoneNumber = phoneNumber
        self.birthday = birthday
        self.cityId = cityId
        self.cityName = nil
        self.regionId = nil
        self.regionName = nil
        self.foto = foto
        self.isMedicWorker = isMedicWorker
        self.verifiedUser = ((Session.instance.user?.verifiedUser) != nil) ? true : false
    }

}
