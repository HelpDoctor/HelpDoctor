//
//  RegionsPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 02.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol RegionsPresenterProtocol {
    init(view: RegionsViewController)
    func getRegions()
    func getCountRegions() -> Int?
    func getRegionTitle(index: Int) -> String?
    func next(index: Int?)
}

class RegionsPresenter: RegionsPresenterProtocol {
    
    var view: RegionsViewController
    var arrayRegions: [Regions]?
    
    required init(view: RegionsViewController) {
        self.view = view
    }
    
    func getRegions() {
        let getRegions = Profile()
        
        getData(typeOfContent: .getRegions,
                returning: ([Regions], Int?, String?).self,
                requestParams: [:] )
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            getRegions.regions = result?.0
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    self?.arrayRegions = getRegions.regions
                    self?.view.tableView.reloadData()
                }
            }
        }
    }
    
    func getCountRegions() -> Int? {
        return arrayRegions?.count
    }
    
    func getRegionTitle(index: Int) -> String? {
        return arrayRegions?[index].regionName
    }
    
    // MARK: - Coordinator
    func next(index: Int?) {
        guard let index = index,
        let region = arrayRegions?[index] else {
            view.showAlert(message: "Выберите один регион")
            return }
        view.navigationController?.popViewController(animated: true)
        let previous = view.navigationController?.viewControllers.last as! CreateProfileWorkViewController
        let presenter = previous.presenter
        presenter?.setRegion(region: region)
        previous.view.layoutIfNeeded()
    }
    
}
