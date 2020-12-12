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
}

// MARK: - Presenter
extension FAQPresenter {
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
    func toProfile() {
        if Session.instance.userCheck {
            let viewController = ProfileViewController()
            viewController.presenter = ProfilePresenter(view: viewController)
            view.navigationController?.pushViewController(viewController, animated: true)
        } else {
            let viewController = CreateProfileNameViewController()
            viewController.presenter = CreateProfileNamePresenter(view: viewController)
            view.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
