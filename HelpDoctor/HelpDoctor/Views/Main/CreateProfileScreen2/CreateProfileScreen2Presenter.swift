//
//  CreateProfileScreen2Presenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 19.03.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol CreateProfileScreen2PresenterProtocol: Presenter {
    init(view: CreateProfileScreen2ViewController)
    func citySearch()
    func regionSearch()
    func setRegion(region: Regions)
    func setCity(city: Cities)
    func next(phone: String)
}

class CreateProfileScreen2Presenter: CreateProfileScreen2PresenterProtocol {
    
    // MARK: - Dependency
    let view: CreateProfileScreen2ViewController
    
    // MARK: - Constants and variables
    var user: UpdateProfileKeyUser?
    private var region: Regions?
    private var city: Cities?
    
    // MARK: - Init
    required init(view: CreateProfileScreen2ViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    func citySearch() {
        guard let regionId = region?.regionId,
            let region = region else {
                view.showAlert(message: "Сначала необходимо выбрать регион")
                return }
        let viewController = CitiesViewController()
        let presenter = CitiesPresenter(view: viewController, region: region)
        viewController.presenter = presenter
        presenter.getCities(regionId: regionId)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func regionSearch() {
        let viewController = RegionsViewController()
        let presenter = RegionsPresenter(view: viewController)
        viewController.presenter = presenter
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setRegion(region: Regions) {
        self.region = region
        view.setRegion(region: region.regionName ?? "")
    }
    
    func setCity(city: Cities) {
        self.city = city
        view.setCity(city: city.cityName ?? "")
        user?.city_id = city.id
    }
    
    // MARK: - Coordinator
    func next(phone: String) {
        if phone == "" {
            view.showAlert(message: "Не заполнен номер телефона")
            return
        }
        guard region != nil else {
            view.showAlert(message: "Не указан регион места жительства")
            return
        }
        guard city != nil else {
            view.showAlert(message: "Не указан город места жительства")
            return
        }
        user?.phone_number = phone
        user?.city_id = city?.id
        let viewController = CreateProfileWorkViewController()
        let presenter = CreateProfileWorkPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.user = user
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
    func save(source: SourceEditTextField) { }
    
}
