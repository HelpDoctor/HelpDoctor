//
//  OtherTimeNotifyPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 12.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol OtherTimeControllerDelegate {
    func callback(notifyDate: Date)
}

protocol OtherTimeNotifyPresenterProtocol: Presenter {
    init(view: OtherTimeNotifyViewController, startTime: Date)
}

class OtherTimeNotifyPresenter: OtherTimeNotifyPresenterProtocol {
    
    // MARK: - Dependency
    var view: OtherTimeNotifyViewController
//    var delegate: OtherTimeControllerDelegate?
    
    // MARK: - Constants and variables
    var startTime: Date
    
    // MARK: - Init
    required init(view: OtherTimeNotifyViewController, startTime: Date) {
        self.view = view
        self.startTime = startTime
        view.setStartTime(startTime: startTime)
    }
    
    // MARK: - Public methods

    
    // MARK: - Coordinator
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
    func backToRoot() {
        view.navigationController?.popToRootViewController(animated: true)
    }
    
    func save(source: SourceEditTextField) { }
    
}
