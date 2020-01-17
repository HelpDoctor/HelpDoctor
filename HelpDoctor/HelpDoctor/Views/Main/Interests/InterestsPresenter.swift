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
    var indexArray: [Int] = []
    
    required init(view: InterestsViewController) {
        self.view = view
    }
    
    func selectRows() {
        for row in indexArray {
            view.setSelected(index: row)
        }
    }
    
    func getCountInterests() -> Int? {
        return arrayInterests?.count
    }
    
    func getInterestsTitle(index: Int) -> String? {
        return arrayInterests?[index].name
    }
    
    func appendIndexArray(index: Int) {
        indexArray.append(index)
    }
    
    func removeIndexArray(index: Int) {
        guard let i = indexArray.firstIndex(of: index) else { return }
        indexArray.remove(at: i)
    }
    
    // MARK: - Coordinator
    func next() {
        let interests = indexArray.map( { arrayInterests?[$0] })
        view.navigationController?.popViewController(animated: true)
        //swiftlint:disable force_cast
        let prevVC = view.navigationController?.viewControllers.last
        if prevVC is CreateProfileSpecViewController {
            let previous = view.navigationController?.viewControllers.last as! CreateProfileSpecViewController
            let presenter = previous.presenter
            presenter?.setInterests(interests: interests as! [ListOfInterests])
            presenter?.setIndexArray(indexes: indexArray)
        } else if prevVC is ProfileViewController {
            let previous = view.navigationController?.viewControllers.last as! ProfileViewController
            let presenter = previous.presenter
            presenter?.setInterests(interests: interests as! [ListOfInterests])
            presenter?.setIndexArray(indexes: indexArray)
            presenter?.save(source: .interest)
        }
    }
    
}
