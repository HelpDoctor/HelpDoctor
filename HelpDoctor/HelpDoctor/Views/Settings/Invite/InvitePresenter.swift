//
//  InvitePresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 23.02.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol InvitePresenterProtocol: Presenter {
    init(view: InviteViewController)
}

class InvitePresenter: InvitePresenterProtocol {
    
    var view: InviteViewController
    
    required init(view: InviteViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
