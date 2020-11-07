//
//  PushAndSoundPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.04.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol PushAndSoundPresenterProtocol: Presenter {
    init(view: PushAndSoundViewController)
    func setSettingsOnView()
    func updateSettings(_ key: String, _ value: Int)
}

class PushAndSoundPresenter: PushAndSoundPresenterProtocol {
    
    var view: PushAndSoundViewController
    
    required init(view: PushAndSoundViewController) {
        self.view = view
    }
    
    func updateSettings(_ key: String, _ value: Int) {
        var userSettings = Session.instance.userSettings
        switch key {
        case "push_notification":
            userSettings?.pushNotification = value
        case "message_friend":
            userSettings?.messageFriend = value
        case "add_friend":
            userSettings?.addFriend = value
        default:
            break
        }
        guard let settings = userSettings else { return }
        NetworkManager.shared.updateSettings(settings) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.loadSettings()
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
            }
        }
    }
    
    private func loadSettings() {
        NetworkManager.shared.getSettings { [weak self] result in
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
    
    func setSettingsOnView() {
        guard let settings = Session.instance.userSettings else { return }
        settings.pushNotification == 1 ? view.setValueOnSwitch(true) : view.setValueOnSwitch(false)
        settings.addFriend == 1 ? view.setContactsCheckbox(true) : view.setContactsCheckbox(false)
        settings.messageFriend == 1 ? view.setMessagesCheckbox(true) : view.setMessagesCheckbox(false)
    }
    
    // MARK: - Coordinator
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
