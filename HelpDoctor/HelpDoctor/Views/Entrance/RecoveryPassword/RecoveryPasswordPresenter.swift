//
//  RecoveryPasswordPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol RecoveryPasswordPresenterProtocol {
    init(view: RecoveryPasswordViewController)
    func sendButtonTapped(email: String)
    func send()
    func back()
}

class RecoveryPasswordPresenter: RecoveryPasswordPresenterProtocol {
    
    // MARK: - Dependency
    var view: RecoveryPasswordViewController
        
    // MARK: - Init
    required init(view: RecoveryPasswordViewController) {
        self.view = view
    }
    
    // MARK: - Publiv methods
    func sendButtonTapped(email: String) {
        view.startAnimating()
        let recovery = Registration(email: email, password: nil, token: nil)
        
        getData(typeOfContent: .recoveryMail,
                returning: (Int?, String?).self,
                requestParams: recovery.requestParams)
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            recovery.responce = result
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    self?.view.stopAnimating()
                    print("result=\(String(describing: recovery.responce))")
                    guard let code = recovery.responce?.0 else { return }
                    if responceCode(code: code) {
                        self?.view.toRecoveryPasswordEnd()
                    } else {
                        self?.view.showAlert(message: recovery.responce?.1)
                    }
                }
            }
        }
        
    }
    
    // MARK: - Coordinator
    func send() {
        let viewController = RecoveryPasswordEndViewController()
        let presenter = RecoveryPasswordEndPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.email = view.getEmailText()
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
