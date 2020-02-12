//
//  RepeatNotificationsPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 19.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol RepeatNotificationsPresenterProtocol: Presenter {
    init(view: RepeatNotificationsViewController)
    func getInterestsTitle(index: Int) -> String
    func appendIndexArray(index: Int)
    func removeIndexArray(index: Int)
    func selectRows()
}

class RepeatNotificationsPresenter: RepeatNotificationsPresenterProtocol {
    
    // MARK: - Dependency
    let view: RepeatNotificationsViewController
    
    // MARK: - Constants and variables
    var indexArray: [Int] = []
    
    // MARK: - Init
    required init(view: RepeatNotificationsViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    func selectRows() {
        for row in indexArray {
            view.setSelected(index: row)
        }
    }
    
    func appendIndexArray(index: Int) {
        indexArray.append(index)
    }
    
    func removeIndexArray(index: Int) {
        guard let i = indexArray.firstIndex(of: index) else { return }
        indexArray.remove(at: i)
    }
    
    func getInterestsTitle(index: Int) -> String {
        switch index {
        case 0:
            return "Каждый понедельник"
        case 1:
            return "Каждый вторник"
        case 2:
            return "Каждую среду"
        case 3:
            return "Каждый четверг"
        case 4:
            return "Каждую пятницу"
        case 5:
            return "Каждую субботу"
        case 6:
            return "Каждое воскресенье"
        default:
            return ""
        }
    }
    
    // MARK: - Coordinator
    func back() {
        view.navigationController?.popViewController(animated: true)
        let previous = view.navigationController?.viewControllers.last as! EventAddViewController
        let presenter = previous.presenter
        presenter?.setRepeat(repeatArray: indexArray)
    }
    
    func backToRoot() {
        view.navigationController?.popToRootViewController(animated: true)
    }
    
    func save(source: SourceEditTextField) { }
    
}
