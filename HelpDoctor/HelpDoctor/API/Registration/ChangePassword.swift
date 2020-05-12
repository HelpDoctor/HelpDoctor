//
//  ChangePassword.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.05.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

final class ChangePassword {
    
    var password: String?
    var new_password: String?
    var requestParams: [String: String]
    var responce: (Int?, String?)?
    
    init(password: String?, new_password: String?) {
        self.password = password
        self.new_password = new_password
        requestParams = [:]
        requestParams["password"] = self.password?.toBase64()
        requestParams["new_password"] = self.new_password?.toBase64()
    }
    
}
