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
        
        let checkProfile = Registration(email: nil, password: nil, token: myToken)
        
        getData(typeOfContent: .checkProfile,
                returning: (Int?, String?).self,
                requestParams: checkProfile.requestParams) { [weak self] result in
            let dispathGroup = DispatchGroup()
            checkProfile.responce = result
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self] in
                    print("result=\(String(describing: checkProfile.responce))")
                    self?.stopAnimating()
                    guard let status = checkProfile.responce?.1 else { return }
                    switch status {
                    case "Token id not found":
                        AppDelegate.shared.rootViewController.switchToLogout()
                    case "X-Auth-Token required":
                        AppDelegate.shared.rootViewController.switchToLogout()
                    default:
                        AppDelegate.shared.rootViewController.switchToMainScreen()
                    }
                }
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
