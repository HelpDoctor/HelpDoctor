//
//  VerificationOkPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 11.04.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol VerificationOkPresenterProtocol: Presenter {
    init(view: VerificationOkViewController)
}

class VerificationOkPresenter: VerificationOkPresenterProtocol {
    
    // MARK: - Dependency
    let view: VerificationOkViewController
    
    // MARK: - Init
    required init(view: VerificationOkViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
    /// Переход к предыдущему экрану
    func back() {
        view.dismiss(animated: true, completion: nil)
    }
    
}
