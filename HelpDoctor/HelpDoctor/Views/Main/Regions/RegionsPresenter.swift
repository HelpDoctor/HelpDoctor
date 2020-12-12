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
        guard let index = index else {
            view.showAlert(message: "Выберите один регион")
            return
        }
        let region = filteredArray[index]
        if sender == nil {
            view.navigationController?.popViewController(animated: true)
            guard let previous = view.navigationController?.viewControllers.last as? CreateProfileScreen2ViewController
            else { return }
            let presenter = previous.presenter
            presenter?.setRegion(region: region)
            previous.view.layoutIfNeeded()
        } else if sender == FilterSearchViewController.identifier {
            let viewController = CitiesViewController()
            let presenter = CitiesPresenter(view: viewController, region: region)
            presenter.sender = sender
            viewController.presenter = presenter
            presenter.getCities(regionId: region.regionId)
            view.navigationController?.pushViewController(viewController, animated: true)
        } else if sender == "Region for job in filter search" {
            let viewController = MedicalOrganizationViewController()
            let presenter = MedicalOrganizationPresenter(view: viewController)
            presenter.sender = sender
            viewController.presenter = presenter
            presenter.getMedicalOrganization(regionId: region.regionId, mainWork: true)
            view.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - Presenter
extension RegionsPresenter {
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
    func toProfile() {
        if Session.instance.userCheck {
            let viewController = ProfileViewController()
            viewController.presenter = ProfilePresenter(view: viewController)
            view.navigationController?.pushViewController(viewController, animated: true)
        } else {
            let viewController = CreateProfileNameViewController()
            viewController.presenter = CreateProfileNamePresenter(view: viewController)
            view.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
