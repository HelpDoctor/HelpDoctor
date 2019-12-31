//
//  RecoveryPasswordCoordinator.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol RecoveryPasswordCoordinatorProtocol: Coordinator {
    func send()
    func back()
}

class RecoveryPasswordCoordinator: RecoveryPasswordCoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func send() {
        let viewController = RecoveryPasswordEndViewController()
        viewController.coordinator = RecoveryPasswordEndCoordinator(navigationController: navigationController)
        viewController.presenter = RecoveryPasswordEndPresenter(view: viewController)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func back() {
        self.navigationController.popViewController(animated: true)
    }
    
}
