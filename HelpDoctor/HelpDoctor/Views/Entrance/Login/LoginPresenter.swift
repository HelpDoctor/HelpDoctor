//
//  LoginPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol LoginPresenterProtocol {
    init(view: LoginViewController)
    func login()
    func recoveryPassword()
    func back()
}

class LoginPresenter: LoginPresenterProtocol {
    
    var view: LoginViewController
    
    required init(view: LoginViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
    func login() {
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }
    
    func recoveryPassword() {
        let viewController = RecoveryPasswordViewController()
        viewController.presenter = RecoveryPasswordPresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
}
