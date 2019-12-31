//
//  RecoveryPasswordEndPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 30.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol RecoveryPasswordEndPresenterProtocol {
    init(view: RecoveryPasswordEndViewController)
}

class RecoveryPasswordEndPresenter: RecoveryPasswordEndPresenterProtocol {
    
    var view: RecoveryPasswordEndViewController
    
    required init(view: RecoveryPasswordEndViewController) {
        self.view = view
    }
    
}
