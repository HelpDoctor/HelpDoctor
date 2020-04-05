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
    func loadSettings()
}

class PushAndSoundPresenter: PushAndSoundPresenterProtocol {
    
    var view: PushAndSoundViewController
    var settings: Settings?
    
    required init(view: PushAndSoundViewController) {
        self.view = view
    }
    
    func loadSettings() {
        let getSettings = SettingsResponse()
        getData(typeOfContent: .getSetings,
                returning: ([Settings], Int?, String?).self,
                requestParams: [:]) { [weak self] result in
                    let dispathGroup = DispatchGroup()
                    getSettings.settings = result?.0
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async { [weak self]  in
                            print("getSettings =\(String(describing: getSettings.settings))")
                            self?.settings = getSettings.settings?[0]
                            self?.setSettingsOnView()
                        }
                    }
        }
    }
    
    private func setSettingsOnView() {
        guard let settings = settings else { return }
        
        settings.push_notification == 1 ? view.setValueOnSwitch(true) : view.setValueOnSwitch(false)
        settings.add_friend == 1 ? view.setContactsCheckbox(true) : view.setContactsCheckbox(false)
        settings.message_friend == 1 ? view.setMessagesCheckbox(true) : view.setMessagesCheckbox(false)
    }
    
    // MARK: - Coordinator
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
