//
//  InviteUser.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 16.05.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

final class InviteUserRequest {
    
    var email: String?
    var first_name: String?
    var last_name: String?
    var requestParams: [String: String]
    var responce: (Int?, String?)?
    
    init(email: String?, first_name: String?, last_name: String?) {
        self.email = email
        self.first_name = first_name
        self.last_name = last_name
        requestParams = [:]
        requestParams["email"] = self.email
        requestParams["first_name"] = self.first_name
        requestParams["last_name"] = self.last_name
    }
    
}
