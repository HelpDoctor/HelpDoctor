//
//  LoginPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol LoginPresenterProtocol {
    init(view: LoginViewController)
}

class LoginPresenter: LoginPresenterProtocol {
    
    var view: LoginViewController
    
    required init(view: LoginViewController) {
        self.view = view
    }
}
