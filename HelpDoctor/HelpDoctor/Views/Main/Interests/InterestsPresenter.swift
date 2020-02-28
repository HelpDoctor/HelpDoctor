//
//  InterestsPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 03.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol InterestsPresenterProtocol: Presenter {
    init(view: InterestsViewController)
    func getCountInterests() -> Int?
    func getInterestsTitle(index: Int) -> String?
    func appendIndexArray(index: Int)
    func removeIndexArray(index: Int)
    func selectRows()
    func searchTextIsEmpty()
    func filter(searchText: String)
}

class InterestsPresenter: InterestsPresenterProtocol {
    
    var view: InterestsViewController
    var arrayInterests: [ListOfInterests]?
    var userInterests: [ListOfInterests] = []
    var filteredArray: [ListOfInterests] = []
    
    required init(view: InterestsViewController) {
        self.view = view
    }
    
    func selectRows() {
        for element in userInterests {
            guard let index = arrayInterests?.firstIndex(where: { $0.id == element.id }) else { return }
            view.setSelected(index: index)
        }
        
        for value in userInterests {
            guard let index = filteredArray.firstIndex(where: { $0.id == value.id }) else { continue }
            view.setSelected(index: index)
        }
    }
    
    func getCountInterests() -> Int? {
        return filteredArray.count
    }
    
    func getInterestsTitle(index: Int) -> String? {
        return filteredArray[index].name
    }
    
    func appendIndexArray(index: Int) {
        userInterests.append(filteredArray[index])
    }
    
    func removeIndexArray(index: Int) {
        let removingInterest = filteredArray[index]
        guard let removeIndex = userInterests.firstIndex(where: { $0.id == removingInterest.id }) else { return }
        userInterests.remove(at: removeIndex)
    }
    
    func searchTextIsEmpty() {
        filteredArray = arrayInterests ?? []
        view.reloadTableView()
        selectRows()
    }
    
    func filter(searchText: String) {
        guard let arrayInterests = arrayInterests else { return }
        filteredArray = arrayInterests.filter({ interest -> Bool in
            return (interest.name?.lowercased().contains(searchText.lowercased()) ?? false)
        })
        view.reloadTableView()
        selectRows()
    }
    
    // MARK: - Presenter
    func back() {
        view.navigationController?.popViewController(animated: true)
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
    
    func save(source: SourceEditTextField) {
        print("Not available")
    }
    
}
