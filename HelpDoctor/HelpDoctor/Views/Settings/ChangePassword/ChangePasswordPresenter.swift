//
//  ChangePasswordPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 23.02.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol ChangePasswordPresenterProtocol: Presenter {
    init(view: ChangePasswordViewController)
    func oldPasswordChanged(password: String?)
    func passwordChanged(password: String?)
    func confirmPasswordChanged(password: String?)
    func changeButtonButtonPressed()
}

class ChangePasswordPresenter: ChangePasswordPresenterProtocol {
    
    var view: ChangePasswordViewController
    private var oldPassword = ""
    private var newPassword = ""
    private var confirmPassword = ""
    private var isValidatedPassword = false
    private var isValidatedConfirmPassword = false
    
    required init(view: ChangePasswordViewController) {
        self.view = view
    }
    
    func oldPasswordChanged(password: String?) {
        oldPassword = password ?? ""
        checkInput()
    }
    
    func passwordChanged(password: String?) {
        guard let password = password else { return }
        var isValidated = false
        newPassword = password
        if isValidPassword(password: password) {
            isValidated = true
        }
        isValidatedPassword = isValidated
        checkInput()
    }
    
    func confirmPasswordChanged(password: String?) {
        confirmPassword = password ?? ""
        checkInput()
    }
    
    private func checkInput() {
        if isValidatedPassword, newPassword == confirmPassword, oldPassword != "" {
            view.updateSendButton(isEnabled: true)
        } else {
            view.updateSendButton(isEnabled: false)
        }
    }
    
    func isValidPassword(password: String) -> Bool {
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func changeButtonButtonPressed() {
        view.startActivityIndicator()
        let changePassword = ChangePassword(password: oldPassword, new_password: newPassword)
        
        getData(typeOfContent: .changePassword,
                returning: (Int?, String?).self,
                requestParams: changePassword.requestParams) { [weak self] result in
            let dispathGroup = DispatchGroup()
            changePassword.responce = result
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    print("result= \(String(describing: changePassword.responce))")
                    let code = changePassword.responce?.0
                    switch code {
                    case 200:
                        self?.view.clearTextFields()
                        self?.view.showSaved(message: "Пароль изменен")
                    default:
                        self?.view.showAlert(message: changePassword.responce?.1)
                    }
                    self?.view.stopActivityIndicator()
                }
            }
        }
    }
    
    // MARK: - Coordinator
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
