//
//  VerificationErrorPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 02.04.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol VerificationErrorPresenterProtocol: Presenter {
    init(view: VerificationErrorViewController)
    func send(src: URL)
}

class VerificationErrorPresenter: VerificationErrorPresenterProtocol {
    
    // MARK: - Dependency
    let view: VerificationErrorViewController
    private let networkManager = NetworkManager()
    
    // MARK: - Constants and variables
    var email: String?
    
    // MARK: - Init
    required init(view: VerificationErrorViewController) {
        self.view = view
    }
    
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
    
    // MARK: - Coordinator
    /// Переход к предыдущему экрану
    func back() {
        view.dismiss(animated: true, completion: nil)
    }
    
}
