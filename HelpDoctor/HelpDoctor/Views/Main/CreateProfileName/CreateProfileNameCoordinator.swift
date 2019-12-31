//
//  CreateProfileNameCoordinator.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 31.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol CreateProfileNameCoordinatorProtocol: Coordinator {
    func next()
}

class CreateProfileNameCoordinator: CreateProfileNameCoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func next() {
        print("Not available yet")
//        let viewController = MainMenuViewController()
//        viewController.coordinator = MainMenuCoordinatorImplementation(navigationController: navigationController)
//        viewController.presenter = MainMenuControllerPresenterImplementation(view: viewController,
//                                                                             factory: requestFactory)
//        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}
