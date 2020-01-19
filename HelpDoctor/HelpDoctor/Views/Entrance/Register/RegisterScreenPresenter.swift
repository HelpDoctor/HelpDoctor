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
    func bottomEmailChanged(bottomEmail: String?)
    func register(email: String)
    func back()
}

class RegisterScreenPresenterImplementation: RegisterScreenPresenter {
    
    // MARK: - Dependency
    var view: RegisterScreenViewController
    
    // MARK: - Constants and variables
    private let validateManager = ValidateManager()
    private var topEmail: String?
    private var bottomEmail: String?
//    private let validImage = UIImage(named: "checkMarkTF")
    private var isValidatedTopEmail = false
    private var isValidatedBottomEmail = false
    
    // MARK: - Init
    required init(view: RegisterScreenViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    func registerButtonPressed(email: String) {
        view.startAnimating()
        let register = Registration(email: email, password: nil, token: nil )
        
        getData(typeOfContent: .registrationMail,
                returning: (Int?, String?).self,
                requestParams: register.requestParams )
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            register.responce = result
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    print("result=\(String(describing: register.responce))")
                    self?.view.stopAnimating()
                    guard let code = register.responce?.0 else { return }
                    if responceCode(code: code) {
                        self?.register(email: email)
                    } else {
                        self?.view.showAlert(message: register.responce?.1)
                    }
                }
            }
        }
    }
    
    func topEmailChanged(topEmail: String?) {
        var isValidated = false
        if let validateEmail = checkValid(email: topEmail) {
            self.topEmail = validateEmail
            isValidated = true
        } else {
            self.topEmail = nil
        }
//        updateTopEmailViews(isValidated: isValidated)
        isValidatedTopEmail = isValidated
        checkInput()
    }
    
    func bottomEmailChanged(bottomEmail: String?) {
        var isValidated = false
        if let validateEmail = checkValid(email: bottomEmail) {
            self.bottomEmail = validateEmail
            if bottomEmail == topEmail {
                isValidated = true
            }
        } else {
            self.bottomEmail = nil
        }
//        updateBottomEmailViews(isValidated: isValidated)
        isValidatedBottomEmail = isValidated
        checkInput()
    }
    
    // MARK: - Private methods
    private func checkInput() {
        if isValidatedBottomEmail, isValidatedTopEmail, topEmail == bottomEmail {
            view.updateButtonRegister(isEnabled: true)
        } else {
            view.updateButtonRegister(isEnabled: false)
        }
    }
    
    private func checkValid(email: String?) -> String? {
        return validateManager.validate(email: email)
    }
    
//    private func updateTopEmailViews(isValidated: Bool) {
//        let shownImage = getValidImage(isValidated: isValidated)
//        view.updateTopEmailSuccess(image: shownImage)
//    }
    
//    private func updateBottomEmailViews(isValidated: Bool) {
//        let shownImage = getValidImage(isValidated: isValidated)
//        view.updateBottomEmailSuccess(image: shownImage)
//    }
    
//    private func getValidImage(isValidated: Bool) -> UIImage? {
//        return isValidated
//            ? validImage
//            : nil
//    }
    
    // MARK: - Coordinator
    func register(email: String) {
        let viewController = RegisterEndViewController()
        let presenter = RegisterEndPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.email = email
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
