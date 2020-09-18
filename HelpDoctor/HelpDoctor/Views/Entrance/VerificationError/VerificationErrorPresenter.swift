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
    
    // MARK: - Constants and variables
    var email: String?
    
    // MARK: - Init
    required init(view: VerificationErrorViewController) {
        self.view = view
    }
    
    /// Переход к экрану входа
    func send(src: URL) {
        view.startActivityIndicator()
        uploadImage(source: src,
                    returning: (Int?, String?).self) { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self] in
                    self?.view.stopActivityIndicator()
                    guard let code = result?.0 else { return }
                    if responceCode(code: code) {
                        self?.view.authorized()
                    } else {
                        self?.view.showAlert(message: result?.1)
                    }
                }
            }
        }
    }
    
    // MARK: - Coordinator
    /// Переход к предыдущему экрану
    func back() {
        view.dismiss(animated: true, completion: nil)
    }
    
}
