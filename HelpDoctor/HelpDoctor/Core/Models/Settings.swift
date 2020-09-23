//
//  Settings.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 04.04.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

struct Settings: Codable {
    var id: Int?
    var pushNotification: Int?
    var messageFriend: Int?
    var addFriend: Int?
    var messageGroup: Int?
    var emailNotification: Int?
    var periodicity: Int?
    var invitePharmcompany: Int?
    var consultation: Int?
    var vacancy: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case pushNotification = "push_notification"
        case messageFriend = "message_friend"
        case addFriend = "add_friend"
        case messageGroup = "message_group"
        case emailNotification = "email_notification"
        case periodicity
        case invitePharmcompany = "invite_pharmcompany"
        case consultation
        case vacancy
    }
}

