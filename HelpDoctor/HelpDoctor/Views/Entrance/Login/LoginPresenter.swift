//
//  LoginPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol LoginPresenterProtocol {
    init(view: LoginViewController)
    func loginButtonPressed(email: String, password: String)
    func login()
    func recoveryPassword()
    func back()
}

class LoginPresenter: LoginPresenterProtocol {
    
    // MARK: - Dependency
    var view: LoginViewController
    
    // MARK: - Init
    required init(view: LoginViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    func loginButtonPressed(email: String, password: String) {
        view.startAnimating()
        let getToken = Registration(email: email, password: password, token: nil)
        
        getData(typeOfContent: .getToken,
                returning: (Int?, String?).self,
                requestParams: getToken.requestParams )
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            getToken.responce = result
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    print("result= \(String(describing: getToken.responce))")
                    guard let code = getToken.responce?.0 else { return }
                    if responceCode(code: code) {
                        self?.login()
                    } else {
                        self?.view.showAlert(message: getToken.responce?.1)
                    }
                }
            }
        }
    }
    
    // MARK: - Coordinator
    func login() {
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }
    
    func recoveryPassword() {
        let viewController = RecoveryPasswordViewController()
        let presenter = RecoveryPasswordPresenter(view: viewController)
        viewController.presenter = presenter
        viewController.setEmail(email: view.getEmailText())
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
}
