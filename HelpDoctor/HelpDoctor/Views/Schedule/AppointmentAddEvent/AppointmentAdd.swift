//
//  AppointmentAdd.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol AppointmentAddPresenterProtocol: Presenter {
    init(view: AppointmentAddViewController)
}

class AppointmentAddPresenter: AppointmentAddPresenterProtocol {
    
    var view: AppointmentAddViewController
    
    required init(view: AppointmentAddViewController) {
        self.view = view
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
    func save(source: SourceEditTextField) {
        
    }
    
}
