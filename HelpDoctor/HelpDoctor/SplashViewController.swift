//
//  SplashViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 31.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    private var activityIndicator = ActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        makeServiceCall()
    }
    
    private func makeServiceCall() {
        startAnimating()
        NetworkManager.shared.checkProfile { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let status):
                    Session.instance.userCheck = status
                    AppDelegate.shared.rootViewController.switchToMainScreen()
                case .failure:
                    AppDelegate.shared.rootViewController.switchToLogout()
                }
                self.stopAnimating()
            }
        }
    }
    
    func startAnimating() {
        let size: CGFloat = 70
        activityIndicator = ActivityIndicatorView(frame: CGRect(x: (Session.width - size) / 2,
                                                                y: (Session.height - size) / 2,
                                                                width: size,
                                                                height: size))
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
    
}
