//
//  RecoveryPasswordPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol RecoveryPasswordPresenterProtocol: Presenter {
    init(view: RecoveryPasswordViewController)
    func sendButtonTapped(email: String?)
    func send()
}

class RecoveryPasswordPresenter: RecoveryPasswordPresenterProtocol {
    
    // MARK: - Dependency
    let view: RecoveryPasswordViewController
    private let networkManager = NetworkManager()
    
    // MARK: - Init
    required init(view: RecoveryPasswordViewController) {
        self.view = view
    }
    
    // MARK: - Publiс methods
    /// Отправка на сервер запроса по восстановлению пароля
    /// - Parameter email: адрес электронной почты
    func sendButtonTapped(email: String?) {
        guard let email = email,
            email != "" else {
                view.showAlert(message: "Заполните E-Mail")
                return
        }
        view.startActivityIndicator()
        networkManager.recovery(email) { result in
            DispatchQueue.main.async {
                self.view.stopActivityIndicator()
                switch result {
                case .success(let code):
                    responceCode(code: code) ? self.send() : nil
                case .failure(let error):
                    self.view.showAlert(message: error.description)
                }
            }
        }
    }
    
    // MARK: - Coordinator
    /// Переход к экрану входа
    func send() {
        let viewController = RecoveryPasswordEndViewController()
        let presenter = RecoveryPasswordEndPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.email = view.getEmailText()
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /// Переход к предыдущему экрану
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
