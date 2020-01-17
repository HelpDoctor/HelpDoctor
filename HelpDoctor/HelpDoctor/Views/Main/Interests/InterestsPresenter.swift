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
    func getInterests(mainSpec: String, addSpec: String)
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
    
    func getInterests(mainSpec: String, addSpec: String) {
        let getListOfInterest = Profile()
        
        getData(typeOfContent: .getListOfInterestsExtTwo,
                returning: ([String: [ListOfInterests]], Int?, String?).self,
                requestParams: ["spec_code": "\(mainSpec)/\(addSpec)"] )
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            getListOfInterest.listOfInterests = result?.0
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    let interestMainSpec: [ListOfInterests]? = getListOfInterest.listOfInterests?["\(mainSpec)"]
                    let interestAddSpec: [ListOfInterests]? = getListOfInterest.listOfInterests?["\(addSpec)"]
                    self?.arrayInterests = (interestMainSpec ?? []) + (interestAddSpec ?? [])
                    self?.view.tableView.reloadData()
                }
            }
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
        let previous = view.navigationController?.viewControllers.last as! CreateProfileSpecViewController
        let presenter = previous.presenter
        presenter?.setInterests(interests: interests as! [ListOfInterests])
        presenter?.setIndexArray(indexes: indexArray)
    }
    
}
