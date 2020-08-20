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
        let sharedApplication = UIApplication.shared.delegate
        guard let frame = sharedApplication?.window??.windowScene?.statusBarManager?.statusBarFrame else { return 0.f }
        let statusBar = UIView(frame: frame)
        return statusBar.frame.height
    }
    
    static var bottomPadding: CGFloat {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?.windows
            .first(where: { $0.isKeyWindow })
        return keyWindow?.safeAreaInsets.bottom ?? 0
    }
    
    var user: ProfileKeyUser?
    var userJob: [ProfileKeyJob?]?
    var userInterests: [ProfileKeyInterests]?
    var userSettings: Settings?
}
