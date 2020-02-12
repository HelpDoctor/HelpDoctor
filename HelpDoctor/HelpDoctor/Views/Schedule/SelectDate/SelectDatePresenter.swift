//
//  SelectDatePresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 25.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol SelectDateControllerDelegate: AnyObject {
    func callback(newDate: Date)
}

protocol SelectDatePresenterProtocol: Presenter {
    init(view: SelectDateViewController, startDate: Date)
}

class SelectDatePresenter: SelectDatePresenterProtocol {
    
    // MARK: - Dependency
    let view: SelectDateViewController
    
    // MARK: - Constants and variables
    var startDate: Date
    
    // MARK: - Init
    required init(view: SelectDateViewController, startDate: Date) {
        self.view = view
        self.startDate = startDate
        view.setStartDate(startDate: startDate)
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
