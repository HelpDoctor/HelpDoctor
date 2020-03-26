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
        if #available(iOS 13.0, *) {
            let tag = 987654321
            
            if let statusBar = UIApplication.shared.keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
                statusBarView.tag = tag
                
                UIApplication.shared.keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
        } else {
            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        return nil
    }
}
