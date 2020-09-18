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
    func setEmailOnView() -> String
    func loginButtonPressed(email: String, password: String)
    func back()
}

class RegisterEndPresenter: RegisterEndPresenterProtocol {
    
    let view: RegisterEndViewController
    private let networkManager = NetworkManager()
    var email: String?
    
    required init(view: RegisterEndViewController) {
        self.view = view
    }
    
    func setEmailOnView() -> String {
        return email ?? ""
    }
    
    /// Отправка на сервер запроса авторизации
    /// - Parameters:
    ///   - email: адрес электронной почты
    ///   - password: пароль
    func loginButtonPressed(email: String, password: String) {
        if email == "" {
            view.showAlert(message: "Заполните E-Mail")
            return
        }
        if password == "" {
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
    private func login() {
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }
    
    /// Переход на предыдущий экран
    func back() {
        guard let firstViewController = view.navigationController?.viewControllers[0] else { return }
        view.navigationController?.popToViewController(firstViewController, animated: true)
    }
    
}
