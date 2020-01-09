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
    func administrativeButtonPressed()
    func scienceButtonPressed()
    func otherButtonPressed()
}

class StartAddEventPresenter: StartAddEventPresenterProtocol {
    
    var view: StartAddEventViewController
    
    // MARK: - Init
    required init(view: StartAddEventViewController) {
        self.view = view
    }
    
    func save(source: SourceEditTextField) { }
    
    // MARK: - Coordinator
    func appointmentButtonPressed() {
        let viewController = AppointmentAddViewController()
        viewController.presenter = AppointmentAddPresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func administrativeButtonPressed() {
        let viewController = EventAddViewController()
        viewController.presenter = EventAddPresenter(view: viewController, eventType: .administrative)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func scienceButtonPressed() {
        let viewController = EventAddViewController()
        viewController.presenter = EventAddPresenter(view: viewController, eventType: .science)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func otherButtonPressed() {
        let viewController = EventAddViewController()
        viewController.presenter = EventAddPresenter(view: viewController, eventType: .other)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
