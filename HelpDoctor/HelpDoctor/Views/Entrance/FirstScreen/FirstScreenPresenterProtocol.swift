//
//  FirstScreenPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol FirstScreenPresenterProtocol {
    init(view: FirstScreenViewController)
    func register()
    func login()
}

class FirstScreenPresenter: FirstScreenPresenterProtocol {
    
    let view: FirstScreenViewController
    
    required init(view: FirstScreenViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
    func login() {
        let viewController = LoginViewController()
        viewController.presenter = LoginPresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func register() {
        let viewController = RegisterScreenViewController()
        viewController.presenter = RegisterScreenPresenterImplementation(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
