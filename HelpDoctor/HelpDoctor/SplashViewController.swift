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
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            self.activityIndicator.stopAnimating()
            
            let checkProfile = Registration(email: nil, password: nil, token: myToken)
            
            getData(typeOfContent: .checkProfile,
                    returning: (Int?, String?).self,
                    requestParams: checkProfile.requestParams)
            { [weak self] result in
                let dispathGroup = DispatchGroup()
                checkProfile.responce = result
                
                dispathGroup.notify(queue: DispatchQueue.main) {
                    DispatchQueue.main.async { [weak self] in
//                        print("result=\(String(describing: checkProfile.responce))")
                        guard let status = checkProfile.responce?.1 else { return }
                        if status == "Token id not found" {
                            AppDelegate.shared.rootViewController.switchToLogout()
                        } else {
                            AppDelegate.shared.rootViewController.switchToMainScreen()
                        }
                    }
                }
            }
        }
    }
    
}
