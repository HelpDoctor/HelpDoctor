//
//  StartSettingsPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 08.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol StartSettingsPresenterProtocol {
    init(view: StartSettingsViewController)
    func addButtonPressed()
}

class StartSettingsPresenter: StartSettingsPresenterProtocol {
    
    var view: StartSettingsViewController
    
    required init(view: StartSettingsViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
    func back() {
        
    }
    
    func addButtonPressed() {
        let viewController = StartAddEventViewController()
        viewController.presenter = StartAddEventPresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
