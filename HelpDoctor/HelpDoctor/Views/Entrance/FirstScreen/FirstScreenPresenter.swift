//
//  FirstScreenPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol FirstScreenPresenter: Presenter {
    init(view: UIViewController)
}

class FirstScreenPresenterImplementation: FirstScreenPresenter {
    
    var view: UIViewController
    
    required init(view: UIViewController) {
        self.view = view
    }
    
}
