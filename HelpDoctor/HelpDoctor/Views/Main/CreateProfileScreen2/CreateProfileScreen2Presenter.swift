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
    var isEdit: Bool { get }
    func citySearch()
    func regionSearch()
    func setRegion(region: Regions)
    func setRegionFromDevice(_ idRegion: Int)
    func setCity(city: Cities)
    func setLiveInNotRussia()
    func convertDateFromServer(_ birthDate: String) -> String?
    func next(phone: String, birthdate: String)
}

class CreateProfileScreen2Presenter: CreateProfileScreen2PresenterProtocol {
    
    // MARK: - Dependency
    let view: CreateProfileScreen2ViewController
    
    // MARK: - Constants and variables
    var user: UpdateProfileKeyUser?
    var isEdit = false
    private var region: Regions?
    private var city: Cities?
    
    // MARK: - Init
    required init(view: CreateProfileScreen2ViewController) {
        self.view = view
    }
    
    // MARK: - Private methods
    /// Обновление информации о пользователе на сервере
    private func updateProfile(user: UpdateProfileKeyUser) {
        view.startActivityIndicator()
        getData(typeOfContent: .updateProfile,
                returning: (Int?, String?).self,
                requestParams: ["json": user.jsonData as Any] ) { [weak self] result in
                    let dispathGroup = DispatchGroup()
                    user.responce = result
                    
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async { [weak self]  in
                            print("updateProfile = \(String(describing: user.responce))")
                            self?.view.stopActivityIndicator()
                            guard let code = user.responce?.0 else { return }
                            if responceCode(code: code) {
                                guard let controllers = self?.view.navigationController?.viewControllers else {
                                    self?.back()
                                    return
                                }
                                for viewControllers in controllers where viewControllers is ProfileViewController {
                                    self?.view.navigationController?.popToViewController(viewControllers,
                                                                                         animated: true)
                                }
                            } else {
                                self?.view.showAlert(message: user.responce?.1)
                            }
                        }
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
    
    func setLiveInNotRussia() {
        region = nil
        city = nil
    }
    
    /// Конвертация даты из формата yyyy-MM-dd в формат dd.MM.yyyy
    /// - Parameter birthDate: дата в формте yyyy-MM-dd
    /// - Returns: дата в формате dd.MM.yyyy
    func convertDateFromServer(_ birthDate: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale.current
        guard let birthday = dateFormatter.date(from: birthDate) else { return nil }
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: birthday)
    }
    
    /// Конвертация даты из формата dd.MM.yyyy в формат yyyy-MM-dd
    /// - Parameter birthdate: дата в формте dd.MM.yyyy
    /// - Returns: дата в формате yyyy-MM-dd
    func convertDateToServer(_ birthdate: String) -> String? {
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
        user?.phone_number = phone
        user?.city_id = city?.id
        if isEdit {
            let user = UpdateProfileKeyUser(first_name: Session.instance.user?.first_name,
                                            last_name: Session.instance.user?.last_name,
                                            middle_name: Session.instance.user?.middle_name,
                                            phone_number: phone,
                                            birthday: strBirthday,
                                            city_id: city?.id,
                                            foto: Session.instance.user?.foto,
                                            gender: Session.instance.user?.gender,
                                            is_medic_worker: Session.instance.user?.is_medic_worker)
            updateProfile(user: user)
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
