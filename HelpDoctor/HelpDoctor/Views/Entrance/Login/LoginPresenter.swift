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
    let view: LoginViewController
    
    // MARK: - Init
    required init(view: LoginViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    /// Отправка на сервер запроса авторизации
    /// - Parameters:
    ///   - email: адрес электронной почты
    ///   - password: пароль
    func loginButtonPressed(email: String, password: String) {
        view.startActivityIndicator()
        let getToken = Registration(email: email, password: password, token: nil)
        
        getData(typeOfContent: .getToken,
                returning: (Int?, String?).self,
                requestParams: getToken.requestParams) { [weak self] result in
            let dispathGroup = DispatchGroup()
            getToken.responce = result
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    print("result= \(String(describing: getToken.responce))")
                    let code = getToken.responce?.0
                    switch code {
                    case 200:
                        self?.login()
                    case 400, 403, 500:
                        self?.view.showAlert(message: getToken.responce?.1)
                    case nil:
                        self?.view.showAlert(message: "Не верный пароль")
                    default:
                        self?.view.showAlert(message: "Ошибка, повторите попытку позже")
                    }
                    self?.view.stopActivityIndicator()
                }
            }
        }
    }
    
    // MARK: - Coordinator
    /// Переход на главный экран
    func login() {
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }
    
    /// Переход на экран восстановления пароля
    func recoveryPassword() {
        let viewController = RecoveryPasswordViewController()
        let presenter = RecoveryPasswordPresenter(view: viewController)
        viewController.presenter = presenter
        viewController.setEmail(email: view.getEmailText())
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /// Переход на предыдущий экран
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
