//
//  AddGuestsPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 04.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol AddGuestsPresenterProtocol: Presenter {
    init(view: AddGuestsViewController)
    func toInviteFriend()
}

class AddGuestsPresenter: AddGuestsPresenterProtocol {

    // MARK: - Dependency
    let view: AddGuestsViewController
    
    // MARK: - Constants and variables
    
    // MARK: - Init
    required init(view: AddGuestsViewController) {
        self.view = view
    }
    
    func toInviteFriend() {
        let viewController = InviteViewController()
        viewController.presenter = InvitePresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
    
