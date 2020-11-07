//
//  RegionsPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 02.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol RegionsPresenterProtocol: Presenter {
    init(view: RegionsViewController)
    func getRegions()
    func getCountRegions() -> Int?
    func getRegionTitle(index: Int) -> String?
    func searchTextIsEmpty()
    func filter(searchText: String)
    func next(index: Int?)
}

class RegionsPresenter: RegionsPresenterProtocol {
    
    var view: RegionsViewController
    var arrayRegions: [Regions]?
    var filteredArray: [Regions] = []
    var sender: String?
    
    required init(view: RegionsViewController) {
        self.view = view
    }
    
    func getRegions() {
        if sender != nil {
            view.setTitleButton()
        }
        NetworkManager.shared.getRegions { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let regions):
                    self?.arrayRegions = regions
                    self?.filteredArray = regions
                    self?.view.reloadTableView()
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
                self?.view.stopActivityIndicator()
            }
        }
    }
    
    func getCountRegions() -> Int? {
        return filteredArray.count
    }
    
    func getRegionTitle(index: Int) -> String? {
        return filteredArray[index].regionName
    }
    
    func searchTextIsEmpty() {
        filteredArray = arrayRegions ?? []
        view.reloadTableView()
    }
    
    func filter(searchText: String) {
        guard let arrayRegions = arrayRegions else { return }
        filteredArray = arrayRegions.filter({ region -> Bool in
            return (region.regionName?.lowercased().contains(searchText.lowercased()) ?? false)
        })
        view.reloadTableView()
    }
    
    // MARK: - Coordinator
    func next(index: Int?) {
        if sender == nil {
            guard let index = index else {
                view.showAlert(message: "Выберите один регион")
                return
            }
            let region = filteredArray[index]
            view.navigationController?.popViewController(animated: true)
            guard let previous = view.navigationController?.viewControllers.last as? CreateProfileScreen2ViewController
            else { return }
            let presenter = previous.presenter
            presenter?.setRegion(region: region)
            previous.view.layoutIfNeeded()
        }
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
