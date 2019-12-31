//
//  CreateProfileNamePresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 31.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol CreateProfileNamePresenterProtocol {
    init(view: CreateProfileNameViewController)
}

class CreateProfileNamePresenter: CreateProfileNamePresenterProtocol {
    
    var view: CreateProfileNameViewController
    
    required init(view: CreateProfileNameViewController) {
        self.view = view
    }
    
}
