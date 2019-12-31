//
//  StartMainPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 31.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol StartMainPresenterProtocol {
    init(view: StartMainViewController)
}

class StartMainPresenter: StartMainPresenterProtocol {
    
    var view: StartMainViewController
    
    required init(view: StartMainViewController) {
        self.view = view
    }
    
}
