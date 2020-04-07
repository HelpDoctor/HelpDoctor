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
    func loadSettings()
    func userRow()
    func securityRow()
    func feedbackRow()
    func inviteRow()
    func helpRow()
    func pushRow()
    func emailRow()
}

class StartSettingsPresenter: StartSettingsPresenterProtocol {
    
    var view: StartSettingsViewController
    
    required init(view: StartSettingsViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    func loadSettings() {
        let getSettings = SettingsResponse()
        getData(typeOfContent: .getSettings,
                returning: ([Settings], Int?, String?).self,
                requestParams: [:]) { result in
                    let dispathGroup = DispatchGroup()
                    getSettings.settings = result?.0
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async {
                            print("getSettings =\(String(describing: getSettings.settings))")
                            Session.instance.userSettings = getSettings.settings?[0]
                        }
                    }
        }
    }
    
    func userRow() {
        let viewController = ProfileViewController()
        let presenter = ProfilePresenter(view: viewController)
        viewController.presenter = presenter
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
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
    
    func pushRow() {
        let viewController = PushAndSoundViewController()
        let presenter = PushAndSoundPresenter(view: viewController)
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
    
}
