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
    
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
    
    var user: ProfileKeyUser?
}
