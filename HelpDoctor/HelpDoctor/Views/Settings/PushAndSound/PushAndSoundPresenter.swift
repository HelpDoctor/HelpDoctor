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
    private let networkManager = NetworkManager()
    
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
        
        let updateSettings = UpdateSettings(id: userSettings?.id,
                                            push_notification: userSettings?.pushNotification,
                                            message_friend: userSettings?.messageFriend,
                                            add_friend: userSettings?.addFriend,
                                            message_group: userSettings?.messageGroup,
                                            email_notification: userSettings?.emailNotification,
                                            periodicity: userSettings?.periodicity,
                                            invite_pharmcompany: userSettings?.invitePharmcompany,
                                            consultation: userSettings?.consultation,
                                            vacancy: userSettings?.vacancy)
        
        getData(typeOfContent: .updateSettings,
                returning: (Int?, String?).self,
                requestParams: ["json": updateSettings.jsonData as Any] ) { [weak self] result in
                    let dispathGroup = DispatchGroup()
                    
                    updateSettings.responce = result
                    
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async { [weak self]  in
                            print("updateSettings = \(String(describing: updateSettings.responce))")
                            guard let code = updateSettings.responce?.0 else { return }
                            if responceCode(code: code) {
                                self?.loadSettings()
                            } else {
                                self?.view.showAlert(message: updateSettings.responce?.1)
                            }
                        }
                    }
        }
    }
    
    private func loadSettings() {
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
