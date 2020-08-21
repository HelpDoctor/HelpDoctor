//
//  AddEventPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 20.08.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol AddEventPresenterProtocol: Presenter {
    init(view: AddEventViewController)
    func eventTypeChoice()
    func appointmentButtonPressed()
    func administrativeButtonPressed()
    func scienceButtonPressed()
    func otherButtonPressed()
}

class AddEventPresenter: AddEventPresenterProtocol {
    
    let view: AddEventViewController
    weak var delegate: SelectDateControllerDelegate?
//    private let transition = PanelTransition()
    
    // MARK: - Init
    required init(view: AddEventViewController) {
        self.view = view
    }
    
    func eventTypeChoice() {
        let viewController = StartAddEventViewController()
        let presenter = StartAddEventPresenter(view: viewController)
        viewController.presenter = presenter
//        viewController.transitioningDelegate = transition
//        viewController.modalPresentationStyle = .automatic
        
        view.present(viewController, animated: true)
        
        
        
//        view.present(viewController, animated: true, completion: nil)
//        view.navigationController?.pushViewController(viewController, animated: true)
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
