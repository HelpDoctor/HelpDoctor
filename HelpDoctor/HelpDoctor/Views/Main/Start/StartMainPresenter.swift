//
//  StartMainPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 31.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol StartMainPresenterProtocol {
    init(view: StartMainViewController)
    func fillProfile()
}

class StartMainPresenter: StartMainPresenterProtocol {
    
    // MARK: - Dependency
    var view: StartMainViewController
    
    // MARK: - Init
    required init(view: StartMainViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    func fillProfile() {
        let viewController = CreateProfileNameViewController()
        viewController.presenter = CreateProfileNamePresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
