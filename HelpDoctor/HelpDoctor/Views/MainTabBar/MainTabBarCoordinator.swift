//
//  MainTabBarCoordinator.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 31.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol MainTabBarCoordinatorProtocol: Coordinator {
    func main() -> UIViewController
}

class MainTabBarCoordinator: MainTabBarCoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func main() -> UIViewController {
        let viewController = StartMainViewController()
        viewController.coordinator = StartMainCoordinator(navigationController: navigationController)
        viewController.presenter = StartMainPresenter(view: viewController)
        return viewController
    }
    
}
