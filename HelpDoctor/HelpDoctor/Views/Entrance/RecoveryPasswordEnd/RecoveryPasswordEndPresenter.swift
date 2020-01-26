//
//  RecoveryPasswordEndPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 30.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol RecoveryPasswordEndPresenterProtocol {
    init(view: RecoveryPasswordEndViewController)
    func login()
}

class RecoveryPasswordEndPresenter: RecoveryPasswordEndPresenterProtocol {
    
    // MARK: - Dependency
    let view: RecoveryPasswordEndViewController
    
    // MARK: - Constants and variables
    var email: String?
    
    // MARK: - Init
    required init(view: RecoveryPasswordEndViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
    func login() {
        let viewController = LoginViewController()
        let presenter = LoginPresenter(view: viewController)
        viewController.presenter = presenter
        viewController.setEmail(email: email ?? "")
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
