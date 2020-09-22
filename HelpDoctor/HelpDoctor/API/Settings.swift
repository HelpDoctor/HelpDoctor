//
//  Settings.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 04.04.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

final class SettingsResponse {
    var settings: [Settings]? = []
    var responce: (Int?, String?)?
}

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

class UpdateSettings {
    var id: Int?
    var push_notification: Int?
    var message_friend: Int?
    var add_friend: Int?
    var message_group: Int?
    var email_notification: Int?
    var periodicity: Int?
    var invite_pharmcompany: Int?
    var consultation: Int?
    var vacancy: Int?
    var jsonModel: [String: Any] = [:]
    var jsonData: Data?
    var responce: (Int?, String?)?
    
    init(id: Int?,
         push_notification: Int?,
         message_friend: Int?,
         add_friend: Int?,
         message_group: Int?,
         email_notification: Int?,
         periodicity: Int?,
         invite_pharmcompany: Int?,
         consultation: Int?,
         vacancy: Int?) {
        self.id = id
        self.push_notification = push_notification
        self.message_friend = message_friend
        self.add_friend = add_friend
        self.message_group = message_group
        self.email_notification = email_notification
        self.periodicity = periodicity
        self.invite_pharmcompany = invite_pharmcompany
        self.consultation = consultation
        self.vacancy = vacancy
        
        
        jsonModel = [:]
        jsonData = nil
        let dataSettings: [String: Any] = ["id": id as Any,
                                        "push_notification": push_notification as Any,
                                        "message_friend": message_friend as Any,
                                        "add_friend": add_friend as Any,
                                        "message_group": message_group as Any,
                                        "email_notification": email_notification as Any,
                                        "periodicity": periodicity as Any,
                                        "invite_pharmcompany": invite_pharmcompany as Any,
                                        "consultation": consultation as Any,
                                        "vacancy": vacancy as Any
                                       ]
        self.jsonModel = ["settings": dataSettings]
        self.jsonData = todoJSON(obj: jsonModel)
    }
    
}
/*
func parseJSON_getSettings(for startPoint: [String: Any]?,
                           response: URLResponse?) -> ([Settings], Int?, String?)? {
    
    var settings: Settings
    
    guard let httpResponse = response as? HTTPURLResponse else { return ([], nil, nil) }
    guard let startPoint = startPoint else { return ([], nil, nil) }
    
    settings = Settings(startPoint)
    
    return ([settings], httpResponse.statusCode, nil)
}
*/
