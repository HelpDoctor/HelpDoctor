//
//  EmailPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 23.02.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol EmailPresenterProtocol: Presenter {
    init(view: EmailViewController)
}

class EmailPresenter: EmailPresenterProtocol {
    
    var view: EmailViewController
    
    required init(view: EmailViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
