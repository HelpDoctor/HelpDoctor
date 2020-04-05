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
    func loadSettings()
}

class EmailPresenter: EmailPresenterProtocol {
    
    var view: EmailViewController
    var settings: Settings?
    
    required init(view: EmailViewController) {
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
        switch settings?.periodicity {
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
