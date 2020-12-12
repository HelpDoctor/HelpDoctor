//
//  StartSearchUserPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 23.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol StartSearchUserPresenterProtocol: Presenter {
    init(view: StartSearchUserViewController)
    func toFilter()
    func toResult()
}

class StartSearchUserPresenter: StartSearchUserPresenterProtocol {

    // MARK: - Dependency
    let view: StartSearchUserViewController
    
    // MARK: - Init
    required init(view: StartSearchUserViewController) {
        self.view = view
    }
    
    func toFilter() {
        let viewController = SearchUsersViewController()
        let presenter = SearchUsersPresenter(view: viewController)
        viewController.presenter = presenter
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func toResult() {
        let viewController = SearchResultViewController()
        let presenter = SearchResultPresenter(view: viewController)
        viewController.presenter = presenter
        view.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Presenter
extension StartSearchUserPresenter {
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
