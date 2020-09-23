//
//  UIApplication+Extensions.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 02.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

extension UIApplication {
    
    func setStatusBarBackgroundColor(color: UIColor) {
        UIApplication.statusBarUIView?.backgroundColor = color
    }

    class var statusBarUIView: UIView? {
        let tag = 987654321
        let sharedApplication = UIApplication.shared.delegate
        let frame = sharedApplication?.window??.windowScene?.statusBarManager?.statusBarFrame ?? .zero
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?.windows
            .first(where: { $0.isKeyWindow })
        
        
        if let statusBar = keyWindow?.viewWithTag(tag) {
            return statusBar
        } else {
            let statusBarView = UIView(frame: frame)
            statusBarView.tag = tag
            
            keyWindow?.addSubview(statusBarView)
            return statusBarView
        }
    }
 
}
