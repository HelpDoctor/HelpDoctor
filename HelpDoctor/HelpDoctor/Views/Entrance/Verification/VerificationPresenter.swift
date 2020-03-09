//
//  VerificationPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 09.03.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol VerificationPresenterProtocol {
    init(view: VerificationViewController)
    func sendButtonTapped(email: String)
    func send()
    func back()
}

class VerificationPresenter: VerificationPresenterProtocol {
    
    // MARK: - Dependency
    let view: VerificationViewController
        
    // MARK: - Init
    required init(view: VerificationViewController) {
        self.view = view
    }
    
    // MARK: - Publiс methods
    /// Отправка на сервер запроса по восстановлению пароля
    /// - Parameter email: адрес электронной почты
    func sendButtonTapped(email: String) {
        view.startActivityIndicator()
        let recovery = Registration(email: email, password: nil, token: nil)
        
        getData(typeOfContent: .recoveryMail,
                returning: (Int?, String?).self,
                requestParams: recovery.requestParams) { [weak self] result in
            let dispathGroup = DispatchGroup()
            recovery.responce = result
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    self?.view.stopActivityIndicator()
                    print("result=\(String(describing: recovery.responce))")
                    guard let code = recovery.responce?.0 else { return }
                    if responceCode(code: code) {
                        self?.send()
                    } else {
                        self?.view.showAlert(message: recovery.responce?.1)
                    }
                }
            }
        }
        
    }
    
    // MARK: - Coordinator
    /// Переход к экрану входа
    func send() {
        let viewController = VerificationEndViewController()
        let presenter = VerificationEndPresenter(view: viewController)
        viewController.presenter = presenter
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /// Переход к предыдущему экрану
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
