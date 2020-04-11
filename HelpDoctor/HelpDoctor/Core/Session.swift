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
    
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
    
    static var bottomPadding: CGFloat {
        return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
    }
    
    var user: ProfileKeyUser?
    var userJob: [ProfileKeyJob?]?
    var userInterests: [ProfileKeyInterests]?
    var userSettings: Settings?
}
