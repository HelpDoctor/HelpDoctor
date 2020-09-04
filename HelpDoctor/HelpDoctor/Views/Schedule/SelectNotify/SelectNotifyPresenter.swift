//
//  SelectNotifyPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 04.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol SelectNotifyControllerDelegate: AnyObject {
    func callback(notifyTime: Double)
}

protocol SelectNotifyPresenterProtocol {
    init(view: SelectNotifyViewController)
    func buttonPressed(_ notifyTime: Double)
}

class SelectNotifyPresenter: SelectNotifyPresenterProtocol {
    
    let view: SelectNotifyViewController
    weak var delegate: SelectNotifyControllerDelegate?
    
    // MARK: - Init
    required init(view: SelectNotifyViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
    func buttonPressed(_ notifyTime: Double) {
        view.dismiss(animated: true, completion: nil)
        delegate?.callback(notifyTime: notifyTime)
    }
    
}
