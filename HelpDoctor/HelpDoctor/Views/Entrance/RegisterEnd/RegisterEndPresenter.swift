//
//  RegisterEndPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol RegisterEndPresenterProtocol {
    init(view: RegisterEndViewController)
    func login()
    func back()
}

class RegisterEndPresenter: RegisterEndPresenterProtocol {
    
    var view: RegisterEndViewController
    
    required init(view: RegisterEndViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
    func login() {
        let viewController = LoginViewController()
        viewController.presenter = LoginPresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func back() {
        guard let firstViewController = view.navigationController?.viewControllers[0] else { return }
        view.navigationController?.popToViewController(firstViewController, animated: true)
    }
    
}
