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

struct Settings {
    let id: Int?
    let push_notification: Int?
    let message_friend: Int?
    let add_friend: Int?
    let message_group: Int?
    let email_notification: Int?
    let periodicity: Int?
    let invite_pharmcompany: Int?
    let consultation: Int?
    let vacancy: Int?
    
    init(_ dictionary: [String: Any]) {
        self.id = dictionary["id"] as? Int
        self.push_notification = dictionary["push_notification"] as? Int
        self.message_friend = dictionary["message_friend"] as? Int
        self.add_friend = dictionary["add_friend"] as? Int
        self.message_group = dictionary["message_group"] as? Int
        self.email_notification = dictionary["email_notification"] as? Int
        self.periodicity = dictionary["periodicity"] as? Int
        self.invite_pharmcompany = dictionary["invite_pharmcompany"] as? Int
        self.consultation = dictionary["consultation"] as? Int
        self.vacancy = dictionary["vacancy"] as? Int
    }

}

func parseJSON_getSettings(for startPoint: [String: Any]?,
                           response: URLResponse?) -> ([Settings], Int?, String?)? {
    
    var settings: Settings
    
    guard let httpResponse = response as? HTTPURLResponse else { return ([], nil, nil) }
    guard let startPoint = startPoint else { return ([], nil, nil) }
    
    settings = Settings(startPoint)
    
    return ([settings], httpResponse.statusCode, nil)
}
