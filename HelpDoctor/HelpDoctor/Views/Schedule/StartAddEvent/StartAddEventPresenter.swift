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
    
    let view: StartAddEventViewController
    weak var delegate: SelectDateControllerDelegate?
    
    // MARK: - Init
    required init(view: StartAddEventViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
    func appointmentButtonPressed() {
        let viewController = AppointmentAddViewController()
        let presenter = AppointmentAddPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.delegate = delegate
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func administrativeButtonPressed() {
        let viewController = EventAddViewController()
        let presenter = EventAddPresenter(view: viewController, eventType: .administrative)
        viewController.presenter = presenter
        presenter.delegate = delegate
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func scienceButtonPressed() {
        let viewController = EventAddViewController()
        let presenter = EventAddPresenter(view: viewController, eventType: .science)
        viewController.presenter = presenter
        presenter.delegate = delegate
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func otherButtonPressed() {
        let viewController = EventAddViewController()
        let presenter = EventAddPresenter(view: viewController, eventType: .other)
        viewController.presenter = presenter
        presenter.delegate = delegate
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
