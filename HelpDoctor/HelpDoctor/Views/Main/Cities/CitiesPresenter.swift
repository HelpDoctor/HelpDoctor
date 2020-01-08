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
    func next(index: Int?)
    func back()
}

class CitiesPresenter: CitiesPresenterProtocol {
    
    var view: CitiesViewController
    var arrayCities: [Cities]?
    
    required init(view: CitiesViewController) {
        self.view = view
    }
    
    func getCities(regionId: Int) {
        let getCities = Profile()
        
        getData(typeOfContent: .getListCities,
                returning: ([Cities], Int?, String?).self,
                requestParams: ["region": "\(regionId)"] )
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            getCities.cities = result?.0
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self] in
                    self?.arrayCities = getCities.cities
                    self?.view.tableView.reloadData()
                }
            }
        }
    }
    
    func getCountCities() -> Int? {
        return arrayCities?.count
    }
    
    func getCityTitle(index: Int) -> String? {
        return arrayCities?[index].cityName
    }
    
    // MARK: - Coordinator
    func next(index: Int?) {
        guard let index = index,
            let city = arrayCities?[index] else {
                view.showAlert(message: "Выберите один город")
                return }
        view.navigationController?.popViewController(animated: true)
        //swiftlint:disable force_cast
        let previous = view.navigationController?.viewControllers.last as! CreateProfileWorkViewController
        let presenter = previous.presenter
        presenter?.setCity(city: city)
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
