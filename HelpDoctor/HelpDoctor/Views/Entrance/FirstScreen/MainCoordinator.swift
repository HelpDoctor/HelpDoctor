//
//  MainCoordinator.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol MainCoordinatorProtocol: Coordinator {
    func start()
    func login()
    func register()
}

class MainCoordinator: MainCoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = FirstScreenViewController()
        viewController.coordinator = self
        viewController.presenter = FirstScreenPresenterImplementation(view: viewController)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func login() {
        let viewController = LoginViewController()
        viewController.coordinator = LoginCoordinator(navigationController: navigationController)
        viewController.presenter = LoginPresenter(view: viewController)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func register() {
        let viewController = RegisterScreenViewController()
        viewController.coordinator = RegisterScreenCoordinatorImplementation(navigationController: navigationController)
        viewController.presenter = RegisterScreenPresenterImplementation(view: viewController)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}
