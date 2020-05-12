//
//  VerificationEndPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 09.03.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol VerificationEndPresenterProtocol {
    init(view: VerificationEndViewController)
//    func login()
    func back()
}

class VerificationEndPresenter: VerificationEndPresenterProtocol {
    
    // MARK: - Dependency
    let view: VerificationEndViewController
    
    // MARK: - Constants and variables
    var email: String?
    
    // MARK: - Init
    required init(view: VerificationEndViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
//    func login() {
//        let viewController = LoginViewController()
//        let presenter = LoginPresenter(view: viewController)
//        viewController.presenter = presenter
//        viewController.setEmail(email: email ?? "")
//        view.navigationController?.pushViewController(viewController, animated: true)
//    }
    
    /// Переход к предыдущему экрану
    func back() {
        view.dismiss(animated: true, completion: nil)
    }
    
    /// Переход к предыдущему экрану
    func hide() {
        view.dismiss(animated: true, completion: nil)
    }
    
}
