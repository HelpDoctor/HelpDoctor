//
//  AppDelegate.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 27.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let notification = NotificationDelegate()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
        
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
        
        notification.notificationCenter.delegate = notification
        notification.userRequest()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        guard let window = window else { return }
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = window.frame
        blurEffectView.tag = 1
        self.window?.addSubview(blurEffectView)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if let viewWithTag = self.window?.viewWithTag(1) {
            viewWithTag.removeFromSuperview()
        }
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

}
//swiftlint:disable force_cast
extension AppDelegate {
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var rootViewController: RootViewController {
        return window?.rootViewController as! RootViewController
    }
}
