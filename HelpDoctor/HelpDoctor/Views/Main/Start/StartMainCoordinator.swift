//
//  StartMainCoordinator.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 31.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol StartMainCoordinatorProtocol: Coordinator {
    func fillProfile()
}

class StartMainCoordinator: StartMainCoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func fillProfile() {
        let viewController = CreateProfileNameViewController()
        viewController.coordinator = CreateProfileNameCoordinator(navigationController: navigationController)
        viewController.presenter = CreateProfileNamePresenter(view: viewController)
        print(navigationController)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}
