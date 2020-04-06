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
            userSettings?.push_notification = value
        case "message_friend":
            userSettings?.message_friend = value
        case "add_friend":
            userSettings?.add_friend = value
        default:
            break
        }
        
        let updateSettings = UpdateSettings(id: userSettings?.id,
                                            push_notification: userSettings?.push_notification,
                                            message_friend: userSettings?.message_friend,
                                            add_friend: userSettings?.add_friend,
                                            message_group: userSettings?.message_group,
                                            email_notification: userSettings?.email_notification,
                                            periodicity: userSettings?.periodicity,
                                            invite_pharmcompany: userSettings?.invite_pharmcompany,
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
        let getSettings = SettingsResponse()
        getData(typeOfContent: .getSetings,
                returning: ([Settings], Int?, String?).self,
                requestParams: [:]) { result in
                    let dispathGroup = DispatchGroup()
                    getSettings.settings = result?.0
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async {
                            Session.instance.userSettings = getSettings.settings?[0]
                        }
                    }
        }
    }
    
    func setSettingsOnView() {
        guard let settings = Session.instance.userSettings else { return }
        settings.push_notification == 1 ? view.setValueOnSwitch(true) : view.setValueOnSwitch(false)
        settings.add_friend == 1 ? view.setContactsCheckbox(true) : view.setContactsCheckbox(false)
        settings.message_friend == 1 ? view.setMessagesCheckbox(true) : view.setMessagesCheckbox(false)
    }
    
    // MARK: - Coordinator
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
