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
    
    private init() {
        self.userStatus = .notVerification
    }
    
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
    var userStatus: UserStatus?
    var userJob: [ProfileKeyJob?]?
    var userInterests: [ProfileKeyInterests]?
    var userSettings: Settings?
}

enum UserStatus: String {
    case notVerification = "not_verification"
    case verified = "verified"
    case processing = "processing"
    case denied = "denied"
}
