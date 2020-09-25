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
    var isEdit: Bool { get }
    func citySearch()
    func regionSearch()
    func setRegion(region: Regions)
    func setRegionFromDevice(_ idRegion: Int)
    func setCity(city: Cities)
    func setLiveInNotRussia()
    func next(phone: String, birthdate: String)
}

class CreateProfileScreen2Presenter: CreateProfileScreen2PresenterProtocol {
    
    // MARK: - Dependency
    let view: CreateProfileScreen2ViewController
    private let networkManager = NetworkManager()
    
    // MARK: - Constants and variables
    var user: User?
    var isEdit = false
    private var region: Regions?
    private var city: Cities?
    
    // MARK: - Init
    required init(view: CreateProfileScreen2ViewController) {
        self.view = view
    }
    
    // MARK: - Private methods
    /// Обновление информации о пользователе на сервере
    private func updateProfile(phone: String, birthday: String?, cityId: Int?) {
        view.startActivityIndicator()
        let editedUser = User(firstName: Session.instance.user?.firstName,
                              lastName: Session.instance.user?.lastName,
                              middleName: Session.instance.user?.middleName,
                              gender: Session.instance.user?.gender,
                              phoneNumber: phone,
                              birthday: birthday,
                              cityId: cityId,
                              foto: Session.instance.user?.foto,
                              isMedicWorker: Session.instance.user?.isMedicWorker)
        networkManager.updateUser(editedUser, nil, nil, nil) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    guard let controllers = self?.view.navigationController?.viewControllers else {
                        self?.back()
                        return
                    }
                    for viewControllers in controllers where viewControllers is ProfileViewController {
                        self?.view.navigationController?.popToViewController(viewControllers,
                                                                             animated: true)
                    }
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
                self?.view.stopActivityIndicator()
            }
        }
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
        viewController.startActivityIndicator()
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setRegion(region: Regions) {
        self.region = region
        view.setRegion(region: region.regionName ?? "")
    }
    
    func setRegionFromDevice(_ idRegion: Int) {
        networkManager.getRegions { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let regions):
                    self?.region = regions.first(where: { $0.regionId == idRegion })
                    guard let cityId = Session.instance.user?.cityId else { return }
                    self?.setCityFromDevice(cityId)
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
            }
        }
    }
    
    func setCity(city: Cities) {
        self.city = city
        view.setCity(city: city.cityName ?? "")
        user?.cityId = city.id
    }
    
    func setLiveInNotRussia() {
        region = nil
        city = nil
    }

    /// Конвертация даты из формата dd.MM.yyyy в формат yyyy-MM-dd
    /// - Parameter birthdate: дата в формте dd.MM.yyyy
    /// - Returns: дата в формате yyyy-MM-dd
    private func convertDateToServer(_ birthdate: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale.current
        guard let birthday = dateFormatter.date(from: birthdate) else {
            view.showAlert(message: "Не правильно указана дата рождения")
            return nil
        }
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: birthday)
    }
    
    private func setCityFromDevice(_ idCity: Int) {
        guard let regionId = region?.regionId else { return }
        networkManager.getCities(regionId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cities):
                    self?.city = cities.first(where: { $0.id == idCity })
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
            }
        }
    }
    
    // MARK: - Coordinator
    func next(phone: String, birthdate: String) {
        if birthdate == "" {
            view.showAlert(message: "Не заполнена дата рождения")
            return
        } else if phone == "" {
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
        
        let strBirthday = convertDateToServer(birthdate)
        
        user?.birthday = strBirthday
        user?.phoneNumber = phone
        user?.cityId = city?.id
        if isEdit {
            updateProfile(phone: phone, birthday: strBirthday, cityId: city?.id)
        } else {
            let viewController = CreateProfileStep6ViewController()
            let presenter = CreateProfileStep6Presenter(view: viewController)
            viewController.presenter = presenter
            presenter.user = user
            presenter.region = region
            view.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
