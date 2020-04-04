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
}

class ChangePasswordPresenter: ChangePasswordPresenterProtocol {
    
    var view: ChangePasswordViewController
    
    required init(view: ChangePasswordViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
