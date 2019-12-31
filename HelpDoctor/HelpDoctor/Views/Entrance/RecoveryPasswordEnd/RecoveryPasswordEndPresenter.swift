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
    
    var view: RecoveryPasswordEndViewController
    
    required init(view: RecoveryPasswordEndViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
    func login() {
        let viewController = LoginViewController()
        viewController.presenter = LoginPresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
