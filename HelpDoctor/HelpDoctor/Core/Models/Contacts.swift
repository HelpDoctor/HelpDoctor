//
//  Contacts.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 21.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

struct Contacts: Codable {
    let id: Int?
    let firstName: String?
    let middleName: String?
    let lastName: String?
    let foto: String?
    let specialization: String?
    var fullName: String {
        return "\(lastName ?? "") \(firstName ?? "") \(middleName ?? "")"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case middleName = "middle_name"
        case lastName = "last_name"
        case foto
        case specialization
    }
}

struct ContactsList: Codable {
    var contacts: [Contacts] = []
    var contactsCount: Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case contacts
        case contactsCount = "contacts_count"
    }
}

struct BlockedList: Codable {
    var blockedUsers: [Contacts] = []
    var blockedCount: Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case blockedUsers = "blocked_users"
        case blockedCount = "blocked_count"
    }
}
