//
//  StartSchedulePresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol StartSchedulePresenterProtocol: Presenter {
    init(view: StartScheduleViewController)
    func addButtonPressed()
}

class StartSchedulePresenter: StartSchedulePresenterProtocol {
    
    var view: StartScheduleViewController
    
    required init(view: StartScheduleViewController) {
        self.view = view
    }
    
    func save(source: SourceEditTextField) { }
    
    // MARK: - Coordinator
    func back() {
        
    }
    
    func addButtonPressed() {
        let viewController = StartAddEventViewController()
        viewController.presenter = StartAddEventPresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
