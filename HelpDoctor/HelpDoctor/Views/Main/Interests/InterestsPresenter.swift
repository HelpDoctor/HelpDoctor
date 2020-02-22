//
//  InterestsPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 03.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol InterestsPresenterProtocol {
    init(view: InterestsViewController)
    func getCountInterests() -> Int?
    func getInterestsTitle(index: Int) -> String?
    func appendIndexArray(index: Int)
    func removeIndexArray(index: Int)
    func selectRows()
    func next()
}

class InterestsPresenter: InterestsPresenterProtocol {
    
    var view: InterestsViewController
    var arrayInterests: [ListOfInterests]?
    var userInterests: [ListOfInterests] = []
    
    required init(view: InterestsViewController) {
        self.view = view
    }
    
    func selectRows() {
        for element in userInterests {
            guard let index = arrayInterests?.firstIndex(where: { $0.id == element.id }) else { return }
            view.setSelected(index: index)
        }
    }
    
    func getCountInterests() -> Int? {
        return arrayInterests?.count
    }
    
    func getInterestsTitle(index: Int) -> String? {
        return arrayInterests?[index].name
    }
    
    func appendIndexArray(index: Int) {
        guard let arrayInterests = arrayInterests else { return }
        userInterests.append(arrayInterests[index])
    }
    
    func removeIndexArray(index: Int) {
        let removingInterest = arrayInterests?[index]
        guard let removeIndex = userInterests.firstIndex(where: { $0.id == removingInterest?.id }) else { return }
        userInterests.remove(at: removeIndex)
    }
    
    // MARK: - Coordinator
    func next() {
        view.navigationController?.popViewController(animated: true)
        //swiftlint:disable force_cast
        let prevVC = view.navigationController?.viewControllers.last
        if prevVC is CreateProfileSpecViewController {
            let previous = view.navigationController?.viewControllers.last as! CreateProfileSpecViewController
            let presenter = previous.presenter
            presenter?.setInterests(interests: userInterests)
        } else if prevVC is ProfileViewController {
            let previous = view.navigationController?.viewControllers.last as! ProfileViewController
            let presenter = previous.presenter
            presenter?.setInterests(interests: userInterests)
            presenter?.save(source: .interest)
        }
    }
    
}
