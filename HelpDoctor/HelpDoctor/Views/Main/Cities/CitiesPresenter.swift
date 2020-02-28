//
//  CitiesPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 03.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol CitiesPresenterProtocol {
    init(view: CitiesViewController)
    func getCities(regionId: Int)
    func getCountCities() -> Int?
    func getCityTitle(index: Int) -> String?
    func searchTextIsEmpty()
    func filter(searchText: String)
    func getRegionName() -> String
    func next(index: Int?)
    func back()
}

class CitiesPresenter: CitiesPresenterProtocol {
        
    var view: CitiesViewController
    var arrayCities: [Cities]?
    var filteredArray: [Cities] = []
    var sender: String?
    var regionId: Int?
    var region: Regions?
    
    required init(view: CitiesViewController) {
        self.view = view
    }
    
    required init(view: CitiesViewController, region: Regions) {
        self.view = view
        self.region = region
    }
    
    func getCities(regionId: Int) {
        view.startActivityIndicator()
        let getCities = Profile()
        
        getData(typeOfContent: .getListCities,
                returning: ([Cities], Int?, String?).self,
                requestParams: ["region": "\(regionId)"] )
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            getCities.cities = result?.0
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self] in
                    self?.view.stopActivityIndicator()
                    self?.arrayCities = getCities.cities
                    self?.filteredArray = getCities.cities ?? []
                    self?.view.tableView.reloadData()
                }
            }
        }
    }
    
    func getCountCities() -> Int? {
        return filteredArray.count
    }
    
    func getCityTitle(index: Int) -> String? {
        return filteredArray[index].cityName
    }
    
    func searchTextIsEmpty() {
        filteredArray = arrayCities ?? []
        view.reloadTableView()
    }
    
    func filter(searchText: String) {
        guard let arrayCities = arrayCities else { return }
        filteredArray = arrayCities.filter({ city -> Bool in
            return (city.cityName?.lowercased().contains(searchText.lowercased()) ?? false)
        })
        view.reloadTableView()
    }
    
    func getRegionName() -> String {
        return region?.regionName ?? ""
    }
    
    // MARK: - Coordinator
    func next(index: Int?) {
        if sender == nil {
            guard let index = index/*,
                let city = arrayCities?[index]*/ else {
                    view.showAlert(message: "Выберите один город")
                    return }
            let city = filteredArray[index]
            view.navigationController?.popViewController(animated: true)
            //swiftlint:disable force_cast
            let previous = view.navigationController?.viewControllers.last as! CreateProfileWorkViewController
            let presenter = previous.presenter
            presenter?.setCity(city: city)
        } else if sender == "MainWork" || sender == "AddWork" || sender == "ThirdWork" {
            guard let regionId = regionId else {
                view.showAlert(message: "Сначала необходимо выбрать регион")
                return }
            let viewController = MedicalOrganizationViewController()
            let presenter = MedicalOrganizationPresenter(view: viewController)
            viewController.presenter = presenter
            presenter.getMedicalOrganization(regionId: regionId, mainWork: true)
            presenter.sender = sender
            view.navigationController?.pushViewController(viewController, animated: true)
        } else if sender == "Work" {
            guard let regionId = regionId else {
                view.showAlert(message: "Сначала необходимо выбрать регион")
                return }
            let viewController = MedicalOrganizationViewController()
            let presenter = MedicalOrganizationPresenter(view: viewController)
            viewController.presenter = presenter
            presenter.getMedicalOrganization(regionId: regionId, mainWork: true)
            presenter.sender = sender
            view.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
