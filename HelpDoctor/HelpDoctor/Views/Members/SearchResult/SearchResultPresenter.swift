//
//  SearchResultPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 23.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol SearchResultPresenterProtocol: Presenter {
    init(view: SearchResultViewController)
}

class SearchResultPresenter: SearchResultPresenterProtocol {

    // MARK: - Dependency
    let view: SearchResultViewController
    
    // MARK: - Init
    required init(view: SearchResultViewController) {
        self.view = view
    }
}

// MARK: - Presenter
extension SearchResultPresenter {
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
