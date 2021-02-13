//
//  StartMessagesPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 12.02.2021.
//  Copyright © 2021 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol StartMessagesPresenterProtocol: Presenter {
    init(view: StartMessagesViewController)
}

class StartMessagesPresenter: StartMessagesPresenterProtocol {
    
    let view: StartMessagesViewController
    private var arrayEvents: [Event]?
    
    // MARK: - Init
    required init(view: StartMessagesViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    
}

// MARK: - Presenter
extension StartMessagesPresenter {
    func back() { }
    
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
