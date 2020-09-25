//
//  VerificationPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 09.03.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol VerificationPresenterProtocol: Presenter {
    init(view: VerificationViewController)
    func send(src: URL)
}

class VerificationPresenter: VerificationPresenterProtocol {
    
    // MARK: - Dependency
    let view: VerificationViewController
    private let networkManager = NetworkManager()
    
    // MARK: - Init
    required init(view: VerificationViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
    /// Переход к экрану входа
    func send(src: URL) {
        view.startActivityIndicator()
        networkManager.verification(src) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.view.authorized()
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
                self?.view.stopActivityIndicator()
            }
        }
    }
    
    /// Переход к предыдущему экрану
    func back() {
        view.dismiss(animated: true, completion: nil)
    }
    
}
