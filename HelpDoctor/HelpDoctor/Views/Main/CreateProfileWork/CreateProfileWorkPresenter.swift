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
    func medicalSpecializationSearch(mainSpec: Bool, tag: String)
    func medicalOrganizationSearch(mainWork: Bool, tag: String)
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
    private var thirdJobArray: [[String: Any]] = []
    private var mainSpecArray: [[String: Any]] = []
    private var addSpecArray: [[String: Any]] = []
    private var thirdSpecArray: [[String: Any]] = []
    private var job: UpdateProfileKeyJob?
    private var region: Regions?
    private var city: Cities?
    private var workPlace: MedicalOrganization?
    private var addWorkPlace: MedicalOrganization?
    private var thirdWorkPlace: MedicalOrganization?
    private var mainSpec: MedicalSpecialization?
    private var addSpec: MedicalSpecialization?
    private var thirdSpec: MedicalSpecialization?
    
    required init(view: CreateProfileWorkViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    func medicalSpecializationSearch(mainSpec: Bool, tag: String) {
        let viewController = MedicalSpecializationViewController()
        let presenter = MedicalSpecializationPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.getMedicalSpecialization(mainSpec: mainSpec)
        switch tag {
        case "main":
            presenter.sender = "main"
        case "add":
            presenter.sender = "add"
        case "third":
            presenter.sender = "third"
        default:
            view.showAlert(message: "Error")
        }
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func medicalOrganizationSearch(mainWork: Bool, tag: String) {
        let viewController = RegionsViewController()
        let presenter = RegionsPresenter(view: viewController)
        viewController.presenter = presenter
        switch tag {
        case "main":
            presenter.sender = "MainWork"
        case "add":
            presenter.sender = "AddWork"
        case "third":
            presenter.sender = "ThirdWork"
        default:
            view.showAlert(message: "Ошибка")
        }
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
    
    func setThirdMedicalOrganization(medicalOrganization: MedicalOrganization) {
        self.thirdWorkPlace = medicalOrganization
        view.setThirdJob(job: medicalOrganization.nameShort ?? "")
        let job: [String: Any] = ["id": 0, "job_oid": medicalOrganization.oid as Any, "is_main": false]
        thirdJobArray.removeAll()
        thirdJobArray.append(job)
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
    
    func setThirdMedicalSpecialization(medicalSpecialization: MedicalSpecialization) {
        self.thirdSpec = medicalSpecialization
        view.setThirdSpec(spec: medicalSpecialization.name ?? "")
        let spec: [String: Any] = ["id": 0, "spec_id": medicalSpecialization.id as Any, "is_main": false]
        thirdSpecArray.removeAll()
        thirdSpecArray.append(spec)
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
        presenter.addJobArray = addJobArray + thirdJobArray
        presenter.mainSpecArray = mainSpecArray
        presenter.addSpecArray = addSpecArray + thirdSpecArray
        presenter.mainSpec = mainSpec?.code
        presenter.addSpec = addSpec?.code
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
}
