//
//  StartMainPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 31.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol StartMainPresenterProtocol: Presenter {
    init(view: StartMainViewController)
    func profileCheck()
    func fillProfile()
    func toProfile()
    func toSearchContacts()
}

class StartMainPresenter: StartMainPresenterProtocol {
    
    // MARK: - Dependency
    let view: StartMainViewController
    
    // MARK: - Init
    required init(view: StartMainViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    func profileCheck() {
        if Session.instance.userCheck {
            view.hideFillProfileButton()
        } else {
            view.showFillProfileButton()
        }
    }
    
    /// Переход на первый экран заполнения профиля
    func fillProfile() {
        let viewController = CreateProfileNameViewController()
        viewController.presenter = CreateProfileNamePresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func toSearchContacts() {
        let viewController = StartSearchUserViewController()
        viewController.presenter = StartSearchUserPresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Presenter
extension StartMainPresenter {
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
    func toProfile() {
        let viewController = ProfileViewController()
        viewController.presenter = ProfilePresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
}
