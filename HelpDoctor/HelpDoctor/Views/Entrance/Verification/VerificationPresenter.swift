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
    
    // MARK: - Init
    required init(view: VerificationViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
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
    
    /// Переход к предыдущему экрану
    func back() {
        view.dismiss(animated: true, completion: nil)
    }
    
}
