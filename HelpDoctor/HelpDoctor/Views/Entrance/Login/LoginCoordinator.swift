//
//  LoginCoordinator.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol LoginCoordinatorProtocol: Coordinator {
    func login()
    func recoveryPassword()
    func back()
}

class LoginCoordinator: LoginCoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func login() {
        let viewController = MainTabBarController()
//        viewController.coordinator = MainTabBarCoordinator(navigationController: navigationController)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func recoveryPassword() {
        let viewController = RecoveryPasswordViewController()
        viewController.coordinator = RecoveryPasswordCoordinator(navigationController: navigationController)
        viewController.presenter = RecoveryPasswordPresenter(view: viewController)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func back() {
        let firstViewController = self.navigationController.viewControllers[0]
        self.navigationController.popToViewController(firstViewController, animated: true)
    }
    
}
