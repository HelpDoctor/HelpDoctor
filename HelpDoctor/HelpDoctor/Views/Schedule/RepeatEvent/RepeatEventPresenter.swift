//
//  RepeatEventPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 02.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol RepeatEventControllerDelegate: AnyObject {
    func callbackDayRepeat()
    func callbackWeekRepeat()
    func callbackMonthRepeat()
    func callbackYearRepeat()
    func callbackNeverRepeat()
    func callbackTimeRepeat()
}

protocol RepeatEventPresenterProtocol: Presenter {
    init(view: RepeatEventViewController)
    func buttonTapped(_ button: RepeatButtons)
}

class RepeatEventPresenter: RepeatEventPresenterProtocol {
    
    // MARK: - Dependency
    let view: RepeatEventViewController
    weak var delegate: RepeatEventControllerDelegate?
    
    // MARK: - Init
    required init(view: RepeatEventViewController) {
        self.view = view
    }
    
    func buttonTapped(_ button: RepeatButtons) {
        view.dismiss(animated: true, completion: nil)
        switch button {
        case .day:
            delegate?.callbackDayRepeat()
        case .week:
            delegate?.callbackWeekRepeat()
        case .month:
            delegate?.callbackMonthRepeat()
        case .year:
            delegate?.callbackYearRepeat()
        case .never:
            delegate?.callbackNeverRepeat()
        case .time:
            delegate?.callbackTimeRepeat()
        }
    }
}

// MARK: - Presenter
extension RepeatEventPresenter {
    func back() { }
    
    func toProfile() {
        if Session.instance.userCheck {
            let viewController = ProfileViewController()
            viewController.presenter = ProfilePresenter(view: viewController)
            view.navigationController?.pushViewController(viewController, animated: true)
        } else {
            let viewController = CreateProfileNameViewController()
            viewController.presenter = CreateProfileNamePresenter(view: viewController)
            view.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
