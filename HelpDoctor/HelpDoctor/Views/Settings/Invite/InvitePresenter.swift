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
        let invite = InviteUserRequest(email: email, first_name: name, last_name: lastname)
        
        getData(typeOfContent: .invite,
                returning: (Int?, String?).self,
                requestParams: invite.requestParams) { [weak self] result in
                    let dispathGroup = DispatchGroup()
                    invite.responce = result
                    
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async { [weak self]  in
                            let code = invite.responce?.0
                            switch code {
                            case nil:
                                self?.view.clearTextFields()
                                self?.view.showSaved(message: "Отправлено")
                            default:
                                self?.view.showAlert(message: invite.responce?.1)
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
