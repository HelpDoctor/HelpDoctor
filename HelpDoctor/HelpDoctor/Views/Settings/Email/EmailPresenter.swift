//
//  EmailPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 23.02.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol EmailPresenterProtocol: Presenter {
    init(view: EmailViewController)
    func updateSettings(_ key: String, _ value: Int)
    func setSettingsOnView()
}

class EmailPresenter: EmailPresenterProtocol {
    
    var view: EmailViewController
    
    required init(view: EmailViewController) {
        self.view = view
    }
    
    func updateSettings(_ key: String, _ value: Int) {
        var userSettings = Session.instance.userSettings
        switch key {
        case "email_notification":
            userSettings?.email_notification = value
        case "periodicity":
            userSettings?.periodicity = value
        case "invite_pharmcompany":
            userSettings?.invite_pharmcompany = value
        case "consultation":
            userSettings?.consultation = value
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
        getData(typeOfContent: .getSettings,
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
        
        if settings.email_notification == 1 {
            view.setValueOnSwitch(true)
            setPeriodicityOnView()
        } else {
            view.setValueOnSwitch(false)
        }
        
        settings.invite_pharmcompany == 1 ? view.setValueOnCompanyCheckbox(true) : view.setValueOnCompanyCheckbox(false)
        settings.consultation == 1 ? view.setValueOnPatientsCheckbox(true) : view.setValueOnPatientsCheckbox(false)
    }
    
    private func setPeriodicityOnView() {
        guard let settings = Session.instance.userSettings else { return }
        switch settings.periodicity {
        case 1:
            view.dayButtonPressed()
        case 3:
            view.threeDaysButtonPressed()
        case 7:
            view.weekButtonPressed()
        case 30:
            view.monthButtonPressed()
        default:
            break
        }
    }
    
    // MARK: - Coordinator
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
