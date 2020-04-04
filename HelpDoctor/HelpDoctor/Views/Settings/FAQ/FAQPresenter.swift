//
//  FAQPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 23.02.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol FAQPresenterProtocol: Presenter {
    init(view: FAQViewController)
}

class FAQPresenter: FAQPresenterProtocol {
    
    var view: FAQViewController
    
    required init(view: FAQViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
