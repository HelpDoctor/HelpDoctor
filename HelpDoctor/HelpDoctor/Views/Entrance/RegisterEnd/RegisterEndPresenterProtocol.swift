//
//  RegisterEndPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol RegisterEndPresenterProtocol: Presenter {
    init(view: UIViewController)
}

class RegisterSuccessPresenterImplementation: RegisterEndPresenterProtocol {
    
    var view: UIViewController
    
    required init(view: UIViewController) {
        self.view = view
    }
    
}
