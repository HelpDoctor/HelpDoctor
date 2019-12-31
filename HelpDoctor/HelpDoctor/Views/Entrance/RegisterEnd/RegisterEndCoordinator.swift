//
//  RegisterEndCoordinator.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol RegisterEndCoordinatorProtocol: Coordinator {
    func login()
    func back()
}

class RegisterEndCoordinator: RegisterEndCoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func login() {
//        let viewController = MainMenuViewController()
//        viewController.coordinator = MainMenuCoordinatorImplementation(navigationController: navigationController)
//        viewController.presenter = MainMenuControllerPresenterImplementation(view: viewController,
//                                                                             factory: requestFactory)
//        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func back() {
        let firstViewController = self.navigationController.viewControllers[0]
        self.navigationController.popToViewController(firstViewController, animated: true)
    }
    
}
