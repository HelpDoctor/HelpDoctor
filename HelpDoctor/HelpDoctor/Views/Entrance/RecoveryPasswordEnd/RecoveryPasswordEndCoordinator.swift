//
//  RecoveryPasswordEndCoordinator.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 30.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol RecoveryPasswordEndCoordinatorProtocol: Coordinator {
    func login()
}

class RecoveryPasswordEndCoordinator: RecoveryPasswordEndCoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func login() {
        let viewController = MainTabBarController()
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}
