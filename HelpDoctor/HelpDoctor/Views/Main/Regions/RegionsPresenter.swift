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
    var sender: String?
    
    required init(view: RegionsViewController) {
        self.view = view
    }
    
    func getRegions() {
        view.startActivityIndicator()
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
                    self?.view.stopActivityIndicator()
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
        if sender == nil {
            guard let index = index,
                let region = arrayRegions?[index] else {
                    view.showAlert(message: "Выберите один регион")
                    return }
            view.navigationController?.popViewController(animated: true)
            //swiftlint:disable force_cast
            let previous = view.navigationController?.viewControllers.last as! CreateProfileWorkViewController
            let presenter = previous.presenter
            presenter?.setRegion(region: region)
            previous.view.layoutIfNeeded()
        } else if sender == "MainWork" || sender == "AddWork" || sender == "ThirdWork" {
            guard let index = index,
                let regionId = arrayRegions?[index].regionId else {
                    view.showAlert(message: "Выберите один регион")
                    return }
            let viewController = CitiesViewController()
            let presenter = CitiesPresenter(view: viewController)
            viewController.presenter = presenter
            presenter.getCities(regionId: regionId)
            presenter.sender = sender
            presenter.regionId = regionId
            view.navigationController?.pushViewController(viewController, animated: true)
        } else if sender == "Work" {
            guard let index = index,
                let regionId = arrayRegions?[index].regionId else {
                    view.showAlert(message: "Выберите один регион")
                    return }
            let viewController = CitiesViewController()
            let presenter = CitiesPresenter(view: viewController)
            viewController.presenter = presenter
            presenter.getCities(regionId: regionId)
            presenter.sender = sender
            presenter.regionId = regionId
            view.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
