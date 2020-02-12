//
//  ValidateManager.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class ValidateManager: ValidateProtocol {
     
    func validate(email: String?) -> String? {
        guard let email = email,
            email.contains("@"),
            email.count > 5 else {
                return nil
        }
        for index in 0..<email.count {
            let emailArray = Array(email)
            if emailArray[index] == "@" {
                for indexTwo in index..<email.count where emailArray[indexTwo] == "." {
                    return email
                }
            }
        }
        return nil
    }
    
    func validate(password: String?) -> String? {
        guard let password = password,
            password.count > 5 else {
                return nil
        }
        return password
    }
    
}
