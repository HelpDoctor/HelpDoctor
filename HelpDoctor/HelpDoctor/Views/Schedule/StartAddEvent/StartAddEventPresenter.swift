//
//  StartAddEventPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol StartAddEventControllerDelegate: AnyObject {
    func callback(eventType: EventType)
}

protocol StartAddEventPresenterProtocol {
    init(view: StartAddEventViewController)
    func buttonPressed(_ eventType: EventType)
}

class StartAddEventPresenter: StartAddEventPresenterProtocol {
    
    let view: StartAddEventViewController
    weak var delegate: StartAddEventControllerDelegate?
    
    // MARK: - Init
    required init(view: StartAddEventViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
    func buttonPressed(_ eventType: EventType) {
        view.dismiss(animated: true, completion: nil)
        switch eventType {
        case .administrative:
            delegate?.callback(eventType: .administrative)
        case .other:
            delegate?.callback(eventType: .other)
        case .reception:
            delegate?.callback(eventType: .reception)
        case .science:
            delegate?.callback(eventType: .science)
        }
    }
    
}
