//
//  AddMembersPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 13.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol AddMembersPresenterProtocol: Presenter {
    init(view: AddMembersViewController)
    func friendsButtonPressed()
    func findColleaguesButtonPressed()
    func sendInviteButtonPressed()
}

class AddMembersPresenter: AddMembersPresenterProtocol {
    
    var view: AddMembersViewController
    
    // MARK: - Init
    required init(view: AddMembersViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
    func friendsButtonPressed() {
//        let viewController = AppointmentAddViewController()
//        viewController.presenter = AppointmentAddPresenter(view: viewController)
//        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func findColleaguesButtonPressed() {
//        let viewController = EventAddViewController()
//        viewController.presenter = EventAddPresenter(view: viewController, eventType: .administrative)
//        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func sendInviteButtonPressed() {
//        let viewController = EventAddViewController()
//        viewController.presenter = EventAddPresenter(view: viewController, eventType: .science)
//        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
