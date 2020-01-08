//
//  StartAddEventPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol StartAddEventPresenterProtocol: Presenter {
    init(view: StartAddEventViewController)
    func appointmentButtonPressed()
}

class StartAddEventPresenter: StartAddEventPresenterProtocol {
    
    var view: StartAddEventViewController
    
    required init(view: StartAddEventViewController) {
        self.view = view
    }
    
    func save(source: SourceEditTextField) {
        
    }
    
    // MARK: - Coordinator
    func appointmentButtonPressed() {
        let viewController = AppointmentAddViewController()
        viewController.presenter = AppointmentAddPresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
