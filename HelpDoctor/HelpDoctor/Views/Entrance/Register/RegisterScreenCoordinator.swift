//
//  RegisterScreenCoordinator.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol RegisterScreenCoordinator: Coordinator {
    func register()
    func back()
}

class RegisterScreenCoordinatorImplementation: RegisterScreenCoordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func register() {
        let viewController = RegisterEndViewController()
        viewController.coordinator =
            RegisterEndCoordinator(navigationController: navigationController)
        viewController.presenter = RegisterEndPresenter(view: viewController)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func back() {
        self.navigationController.popViewController(animated: true)
    }
    
}
