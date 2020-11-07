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
    func verificationRow()
    func blockedRow()
    func securityRow()
    func feedbackRow()
    func inviteRow()
    func helpRow()
    func pushRow()
    func emailRow()
}

class StartSettingsPresenter: StartSettingsPresenterProtocol {
    
    var view: StartSettingsViewController
    private let networkManager = NetworkManager()
    
    required init(view: StartSettingsViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    func loadSettings() {
        networkManager.getSettings { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let settings):
                    Session.instance.userSettings = settings
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
            }
        }
    }
    
    func userRow() {
        let viewController = EditProfileViewController()
        let presenter = EditProfilePresenter(view: viewController)
        viewController.presenter = presenter
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func verificationRow() {
        networkManager.getUserStatus { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let serverResponse):
                    let status = serverResponse.status
                    switch status {
                    case "denied":
                        UserDefaults.standard.set("denied", forKey: "userStatus")
                        self?.toErrorVerification(serverResponse.message)
                    case "not_verification":
                        UserDefaults.standard.set("not_verification", forKey: "userStatus")
                        self?.toVerification()
                    case "processing":
                        UserDefaults.standard.set("processing", forKey: "userStatus")
                        self?.toEndVerification()
                    case "verified":
                        self?.toOkVerification()
                        UserDefaults.standard.set("verified", forKey: "userStatus")
                    default:
                        break
                    }
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
            }
        }
    }
    
    func blockedRow() {
        let viewController = BlockedUsersViewController()
        let presenter = BlockedUsersPresenter(view: viewController)
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
    
    func toVerification() {
        let viewController = VerificationViewController()
        viewController.presenter = VerificationPresenter(view: viewController)
        view.present(viewController, animated: true, completion: nil)
    }
    
    func toEndVerification() {
        let viewController = VerificationEndViewController()
        viewController.presenter = VerificationEndPresenter(view: viewController)
        view.present(viewController, animated: true, completion: nil)
    }
    
    func toErrorVerification(_ message: String?) {
        let viewController = VerificationErrorViewController()
        viewController.presenter = VerificationErrorPresenter(view: viewController)
        viewController.messageFromServer = message
        view.present(viewController, animated: true, completion: nil)
    }
    
    func toOkVerification() {
        let viewController = VerificationOkViewController()
        viewController.presenter = VerificationOkPresenter(view: viewController)
        view.present(viewController, animated: true, completion: nil)
    }
    
}
