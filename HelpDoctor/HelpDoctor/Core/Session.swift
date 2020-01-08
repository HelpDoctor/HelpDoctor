//
//  Session.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 07.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class Session {
    static let instance = Session()
    
    private init() { }
    
    var width: CGFloat = 0
    var height: CGFloat = 0
    var user: ProfileKeyUser?
}
