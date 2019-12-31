//
//  SplashViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 31.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
       super.viewDidLoad()
       view.backgroundColor = UIColor.white
       view.addSubview(activityIndicator)
       activityIndicator.frame = view.bounds
       activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
       makeServiceCall()
    }
    
    private func makeServiceCall() {
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
           self.activityIndicator.stopAnimating()
//           AppDelegate.shared.rootViewController.switchToMainScreen()
            AppDelegate.shared.rootViewController.switchToLogout()
//           if UserDefaults.standard.bool(forKey: “LOGGED_IN”) {
//              // navigate to protected page
//           } else {
//              // navigate to login screen
//           }
        }
    }

}
