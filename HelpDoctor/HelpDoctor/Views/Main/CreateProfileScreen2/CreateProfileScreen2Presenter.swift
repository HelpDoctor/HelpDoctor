//
//  CreateProfileScreen2Presenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 19.03.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol CreateProfileScreen2PresenterProtocol: Presenter, PickerFieldDelegate {
    init(view: CreateProfileScreen2ViewController)
    func citySearch()
    func regionSearch()
    func setRegion(region: Regions)
    func setRegionFromDevice(_ idRegion: Int)
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
    
    func setRegionFromDevice(_ idRegion: Int) {
        let getRegions = Profile()
        
        getData(typeOfContent: .getRegions,
                returning: ([Regions], Int?, String?).self,
                requestParams: [:]) { [weak self] result in
                    let dispathGroup = DispatchGroup()
                    
                    getRegions.regions = result?.0
                    
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async { [weak self]  in
                            self?.region = getRegions.regions?.first(where: { $0.regionId == idRegion })
                            guard let cityId = Session.instance.user?.city_id else { return }
                            self?.setCityFromDevice(cityId)
                        }
                    }
        }
    }
    
    func setCity(city: Cities) {
        self.city = city
        view.setCity(city: city.cityName ?? "")
        user?.city_id = city.id
    }
    
    private func setCityFromDevice(_ idCity: Int) {
        let getCities = Profile()
        guard let regionId = region?.regionId else { return }
        
        getData(typeOfContent: .getListCities,
                returning: ([Cities], Int?, String?).self,
                requestParams: ["region": "\(regionId)"]) { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            getCities.cities = result?.0
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self] in
                    self?.city = getCities.cities?.first(where: { $0.id == idCity })
                }
            }
        }
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
    
}

// MARK: - PickerFieldDelegate
extension CreateProfileScreen2Presenter {
    
    func pickerField(didOKClick pickerField: PickerField) {
        if pickerField.type == .datePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            guard let datePicker = pickerField.datePicker else { return }
            let date = dateFormatter.string(from: datePicker.date)
            pickerField.text =  "\(date)"
        }

    }
    
}
