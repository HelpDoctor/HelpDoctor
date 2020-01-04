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
    func next(index: [Int]?)
}

class InterestsPresenter: InterestsPresenterProtocol {
    
    var view: InterestsViewController
    var arrayInterests: [ListOfInterests]?
    
    required init(view: InterestsViewController) {
        self.view = view
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
    
    // MARK: - Coordinator
    func next(index: [Int]?) {
//        guard let index = index,
//            let interests = arrayInterests?[index] else {
//                view.showAlert(message: "Укажите область своих научных интересов")
//                return }
//        var interests = index?.forEach({arrayInterests?.append($0)})
//        var interests = index.map({arrayInterests?[$0]})
        let interests = index?.map({arrayInterests?[$0]})
        view.navigationController?.popViewController(animated: true)
        let previous = view.navigationController?.viewControllers.last as! CreateProfileSpecViewController
        let presenter = previous.presenter
        presenter?.setInterests(interests: interests! as! [ListOfInterests])//Убрать force-unwrap
    }
    
}
