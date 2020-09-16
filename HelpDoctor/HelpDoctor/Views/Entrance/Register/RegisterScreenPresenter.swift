//
//  RegisterScreenPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol RegisterScreenPresenter {
    init(view: RegisterScreenViewController)
    func registerButtonPressed(email: String)
    func topEmailChanged(topEmail: String?)
    func checkPolicyChanged(isAgree: Bool)
    func register(email: String)
    func back()
}

class RegisterScreenPresenterImplementation: RegisterScreenPresenter {
    
    // MARK: - Dependency
    let view: RegisterScreenViewController
    let networkManager = NetworkManager()
    
    // MARK: - Constants and variables
    private let validateManager = ValidateManager()
    private var topEmail: String?
    private var isValidatedTopEmail = false
    private var isAgreePolicy = false
    
    // MARK: - Init
    required init(view: RegisterScreenViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    /// Отправка на сервер запроса регистрации
    /// - Parameter email: адрес электронной почты
    func registerButtonPressed(email: String) {
        view.stopActivityIndicator()
//        let register = Registration(email: email, password: nil, token: nil)
//        
//        getData(typeOfContent: .registrationMail,
//                returning: (Int?, String?).self,
//                requestParams: register.requestParams) { [weak self] result in
//            let dispathGroup = DispatchGroup()
//            register.responce = result
//            
//            dispathGroup.notify(queue: DispatchQueue.main) {
//                DispatchQueue.main.async { [weak self]  in
//                    print("result=\(String(describing: register.responce))")
//                    self?.view.stopActivityIndicator()
//                    guard let code = register.responce?.0 else { return }
//                    if responceCode(code: code) {
//                        self?.register(email: email)
//                    } else {
//                        self?.view.showAlert(message: register.responce?.1)
//                    }
//                }
//            }
//        }
        
        networkManager.registration(email) { status, error in
            status?.status
            if let error = error {
                DispatchQueue.main.async {
                    self.view.showAlert(message: error)
                }
            }
            if status != nil {
                self.register(email: email)
            }
        }

    }
    
    /// Проверка адреса электронной почты
    /// - Parameter topEmail: адрес электронной почты
    func topEmailChanged(topEmail: String?) {
        var isValidated = false
        if let validateEmail = checkValid(email: topEmail) {
            self.topEmail = validateEmail
            isValidated = true
        } else {
            self.topEmail = nil
        }
        isValidatedTopEmail = isValidated
        checkInput()
    }
    
    func checkPolicyChanged(isAgree: Bool) {
        isAgreePolicy = isAgree
        checkInput()
    }
    
    // MARK: - Private methods
    /// Проверка введенных адресов
    private func checkInput() {
        if isValidatedTopEmail, isAgreePolicy {
            view.updateButtonRegister(isEnabled: true)
        } else {
            view.updateButtonRegister(isEnabled: false)
        }
    }
    
    /// Проверка корректности адреса электронной почты
    /// - Parameter email: адрес электронной почты
    private func checkValid(email: String?) -> String? {
        return validateManager.validate(email: email)
    }
    
    // MARK: - Coordinator
    /// Переход к экрану завершения регистрации
    /// - Parameter email: адрес электронной почты
    func register(email: String) {
        let viewController = RegisterEndViewController()
        let presenter = RegisterEndPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.email = email
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /// Переход к предыдущему экрану
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
