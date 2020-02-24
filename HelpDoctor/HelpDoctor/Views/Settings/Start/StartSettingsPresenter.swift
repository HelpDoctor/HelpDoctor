//
//  StartSettingsPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 08.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol StartSettingsPresenterProtocol: Presenter {
    init(view: StartSettingsViewController)
    func securityRow()
    func feedbackRow()
    func inviteRow()
    func helpRow()
    func emailRow()
}

class StartSettingsPresenter: StartSettingsPresenterProtocol {
    
    var view: StartSettingsViewController
    
    required init(view: StartSettingsViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    func feedbackRow() {
        let viewController = FeedbackViewController()
        let presenter = FeedbackPresenter(view: viewController)
        viewController.presenter = presenter
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func securityRow() {
        let viewController = ChangePasswordViewController()
        let presenter = ChangePasswordPresenter(view: viewController)
        viewController.presenter = presenter
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func inviteRow() {
        let viewController = InviteViewController()
        let presenter = InvitePresenter(view: viewController)
        viewController.presenter = presenter
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func helpRow() {
        let viewController = FAQViewController()
        let presenter = FAQPresenter(view: viewController)
        viewController.presenter = presenter
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func emailRow() {
        let viewController = EmailViewController()
        let presenter = EmailPresenter(view: viewController)
        viewController.presenter = presenter
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Coordinator
    func back() { }
    
    func save(source: SourceEditTextField) { }
    
}
