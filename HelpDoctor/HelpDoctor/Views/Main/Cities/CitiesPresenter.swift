//
//  CitiesPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 03.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol CitiesPresenterProtocol: Presenter {
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
    private let networkManager = NetworkManager()
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
        if sender != nil {
            view.setTitleButton()
        }
        view.startActivityIndicator()
        networkManager.getCities(regionId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cities):
                    self.arrayCities = cities
                    self.filteredArray = cities
                    self.view.reloadTableView()
                case .failure(let error):
                    self.view.showAlert(message: error.description)
                }
                self.view.stopActivityIndicator()
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
            guard let index = index else {
                    view.showAlert(message: "Выберите один город")
                    return }
            let city = filteredArray[index]
            view.navigationController?.popViewController(animated: true)
            guard let previous = view.navigationController?.viewControllers.last as? CreateProfileScreen2ViewController
                else { return }
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
