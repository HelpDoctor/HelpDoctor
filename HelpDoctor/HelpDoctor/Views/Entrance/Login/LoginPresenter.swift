//
//  LoginPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol LoginPresenterProtocol: Presenter {
    init(view: LoginViewController)
    func loginButtonPressed(email: String?, password: String?)
    func login()
    func recoveryPassword()
}

class LoginPresenter: LoginPresenterProtocol {
    
    // MARK: - Dependency
    let view: LoginViewController
    private let networkManager = NetworkManager()
    
    // MARK: - Init
    required init(view: LoginViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    /// Отправка на сервер запроса авторизации
    /// - Parameters:
    ///   - email: адрес электронной почты
    ///   - password: пароль
    func loginButtonPressed(email: String?, password: String?) {
        guard let email = email,
            email != "" else {
                view.showAlert(message: "Заполните E-Mail")
                return
        }
        guard let password = password,
            password != "" else {
                view.showAlert(message: "Пароль не может быть пустым")
                return
        }
        view.startActivityIndicator()
        networkManager.login(email, password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.login()
                case .failure(let error):
                    self.view.showAlert(message: error.description)
                }
                self.view.stopActivityIndicator()
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
