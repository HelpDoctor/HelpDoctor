//
//  CreateProfileWorkPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 01.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol CreateProfileWorkPresenterProtocol: MedicalOrganizationSearchProtocol,
    MedicalSpecializationSearchProtocol,
CitiesSearchProtocol {
    init(view: CreateProfileWorkViewController)
    func medicalSpecializationSearch(mainSpec: Bool)
    func medicalOrganizationSearch(mainWork: Bool)
    func citySearch()
    func regionSearch()
    func setRegion(region: Regions)
    func next()
    func back()
}

class CreateProfileWorkPresenter: CreateProfileWorkPresenterProtocol {
    
    // MARK: - Dependency
    var view: CreateProfileWorkViewController
    
    // MARK: - Constants and variables
    var user: UpdateProfileKeyUser?
    private var mainJobArray: [[String: Any]] = []
    private var addJobArray: [[String: Any]] = []
    private var mainSpecArray: [[String: Any]] = []
    private var addSpecArray: [[String: Any]] = []
    private var job: UpdateProfileKeyJob?
    private var region: Regions?
    private var city: Cities?
    private var workPlace: MedicalOrganization?
    private var addWorkPlace: MedicalOrganization?
    private var mainSpec: MedicalSpecialization?
    private var addSpec: MedicalSpecialization?
    
    required init(view: CreateProfileWorkViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    func medicalSpecializationSearch(mainSpec: Bool) {
        let viewController = MedicalSpecializationViewController()
        let presenter = MedicalSpecializationPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.getMedicalSpecialization(mainSpec: mainSpec)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func medicalOrganizationSearch(mainWork: Bool) {
        guard let regionId = region?.regionId else {
            view.showAlert(message: "Сначала необходимо выбрать регион")
            return }
        let viewController = MedicalOrganizationViewController()
        let presenter = MedicalOrganizationPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.getMedicalOrganization(regionId: regionId, mainWork: mainWork)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func citySearch() {
        guard let regionId = region?.regionId else {
            view.showAlert(message: "Сначала необходимо выбрать регион")
            return }
        let viewController = CitiesViewController()
        let presenter = CitiesPresenter(view: viewController)
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
    
    // MARK: - CitiesSearchProtocol
    func getRegionId() -> Int? {
        return region?.regionId
    }
    
    func setCity(city: Cities) {
        self.city = city
        view.setCity(city: city.cityName ?? "")
        user?.city_id = city.id
    }
    
    // MARK: - MedicalOrganizationSearchProtocol
    func setMedicalOrganization(medicalOrganization: MedicalOrganization) {
        self.workPlace = medicalOrganization
        view.setMainJob(job: medicalOrganization.nameShort ?? "")
        let job: [String: Any] = ["id": 0, "job_oid": medicalOrganization.oid as Any, "is_main": true]
        mainJobArray.removeAll()
        mainJobArray.append(job)
    }
    
    func setAddMedicalOrganization(medicalOrganization: MedicalOrganization) {
        self.addWorkPlace = medicalOrganization
        view.setAddJob(job: medicalOrganization.nameShort ?? "")
        let job: [String: Any] = ["id": 0, "job_oid": medicalOrganization.oid as Any, "is_main": false]
        addJobArray.removeAll()
        addJobArray.append(job)
    }
    
    // MARK: - MedicalSpecializationSearchProtocol
    func setMedicalSpecialization(medicalSpecialization: MedicalSpecialization) {
        self.mainSpec = medicalSpecialization
        view.setMainSpec(spec: medicalSpecialization.name ?? "")
        let spec: [String: Any] = ["id": 0, "spec_id": medicalSpecialization.id as Any, "is_main": true]
        mainSpecArray.removeAll()
        mainSpecArray.append(spec)
    }
    
    func setAddMedicalSpecialization(medicalSpecialization: MedicalSpecialization) {
        self.addSpec = medicalSpecialization
        view.setAddSpec(spec: medicalSpecialization.name ?? "")
        let spec: [String: Any] = ["id": 0, "spec_id": medicalSpecialization.id as Any, "is_main": false]
        addSpecArray.removeAll()
        addSpecArray.append(spec)
    }
    
    // MARK: - Coordinator
    func next() {
        guard region != nil else {
            view.showAlert(message: "Не указан регион места жительства")
            return
        }
        guard city != nil else {
            view.showAlert(message: "Не указан город места жительства")
            return
        }
        guard workPlace != nil else {
            view.showAlert(message: "Не указано основное место работы")
            return
        }
        guard mainSpec != nil else {
            view.showAlert(message: "Не указана основная специализация")
            return
        }
        
        let viewController = CreateProfileSpecViewController()
        let presenter = CreateProfileSpecPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.user = user
        presenter.mainJobArray = mainJobArray
        presenter.addJobArray = addJobArray
        presenter.mainSpecArray = mainSpecArray
        presenter.addSpecArray = addSpecArray
        presenter.mainSpec = mainSpec?.code
        presenter.addSpec = addSpec?.code
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
}
