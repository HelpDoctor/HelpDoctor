//
//  SearchResultPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 23.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol SearchResultPresenterProtocol: Presenter {
    init(view: SearchResultViewController)
}

class SearchResultPresenter: SearchResultPresenterProtocol {

    // MARK: - Dependency
    let view: SearchResultViewController
    
    // MARK: - Constants and variables
    
    
    // MARK: - Init
    required init(view: SearchResultViewController) {
        self.view = view
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
