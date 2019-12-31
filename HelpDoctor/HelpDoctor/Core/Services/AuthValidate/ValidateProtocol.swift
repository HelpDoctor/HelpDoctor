//
//  ValidateProtocol.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol ValidateProtocol {
    func validate(email: String?) -> String?
    func validate(password: String?) -> String?
}
