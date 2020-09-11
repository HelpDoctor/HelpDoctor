//
//  VerificationEndPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 09.03.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol VerificationEndPresenterProtocol {
    init(view: VerificationEndViewController)
    func back()
}

class VerificationEndPresenter: VerificationEndPresenterProtocol {
    
    // MARK: - Dependency
    let view: VerificationEndViewController
    
    // MARK: - Constants and variables
    var email: String?
    
    // MARK: - Init
    required init(view: VerificationEndViewController) {
        self.view = view
    }
    
    /// Переход к предыдущему экрану
    func back() {
        view.dismiss(animated: true, completion: nil)
    }
    
}
