//
//  FeedbackPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 23.02.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol FeedbackPresenterProtocol: Presenter {
    init(view: FeedbackViewController)
}

class FeedbackPresenter: FeedbackPresenterProtocol {
    
    var view: FeedbackViewController
    
    required init(view: FeedbackViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
    func save(source: SourceEditTextField) { }
    
}
