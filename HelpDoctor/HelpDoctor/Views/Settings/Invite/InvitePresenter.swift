//
//  InvitePresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 23.02.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol InvitePresenterProtocol: Presenter {
    init(view: InviteViewController)
    func inviteUser(email: String, name: String, lastname: String?)
}

class InvitePresenter: InvitePresenterProtocol {
    
    var view: InviteViewController
    private let networkManager = NetworkManager()
    
    required init(view: InviteViewController) {
        self.view = view
    }
    
    func inviteUser(email: String, name: String, lastname: String?) {
        if email == "" {
            view.showAlert(message: "Адрес электронной почты не может быть пустым")
            return
        } else if name == "" {
            view.showAlert(message: "Имя не может быть пустым")
            return
        }
        
        view.startActivityIndicator()
        networkManager.invite(email, name, lastname) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.view.clearTextFields()
                    self?.view.showSaved(message: "Отправлено")
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
                self?.view.stopActivityIndicator()
            }
        }
    }
    
    // MARK: - Coordinator
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
