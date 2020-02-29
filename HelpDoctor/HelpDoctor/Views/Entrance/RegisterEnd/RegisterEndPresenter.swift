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
    
    let view: RegisterEndViewController
    var email: String?
    
    required init(view: RegisterEndViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
    /// Переход к экрану входа
    func login() {
        let viewController = LoginViewController()
        let presenter = LoginPresenter(view: viewController)
        viewController.presenter = presenter
        viewController.setEmail(email: email ?? "")
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /// Переход на предыдущий экран
    func back() {
        guard let firstViewController = view.navigationController?.viewControllers[0] else { return }
        view.navigationController?.popToViewController(firstViewController, animated: true)
    }
    
}
