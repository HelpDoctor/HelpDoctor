//
//  CreateProfileWorkPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 01.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol CreateProfileWorkPresenterProtocol {
    init(view: CreateProfileWorkViewController)
    func medicalSpecializationSearch(mainSpec: Bool)
    func medicalOrganizationSearch(mainWork: Bool)
    func citySearch()
    func regionSearch()
    func setRegion(region: Regions)
    func setCity(city: Cities)
    func setMedicalOrganization(medicalOrganization: MedicalOrganization)
    func setAddMedicalOrganization(medicalOrganization: MedicalOrganization)
    func setMedicalSpecialization(medicalSpecialization: MedicalSpecialization)
    func setAddMedicalSpecialization(medicalSpecialization: MedicalSpecialization)
    func next()
    func back()
}

class CreateProfileWorkPresenter: CreateProfileWorkPresenterProtocol {
    
    var view: CreateProfileWorkViewController
    var user: UpdateProfileKeyUser?
    var jobArray: [[String: Any]] = []
    var specArray: [[String: Any]] = []
    var job: UpdateProfileKeyJob?
    var region: Regions?
    var city: Cities?
    var workPlace: MedicalOrganization?
    var addWorkPlace: MedicalOrganization?
    var mainSpec: MedicalSpecialization?
    var addSpec: MedicalSpecialization?
    
    required init(view: CreateProfileWorkViewController) {
        self.view = view
    }
    
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
        view.regionTextField.text = region.regionName
    }
    
    func setCity(city: Cities) {
        self.city = city
        view.cityTextField.text = city.cityName
        user?.city_id = city.id
    }
    
    func setMedicalOrganization(medicalOrganization: MedicalOrganization) {
        self.workPlace = medicalOrganization
        view.workTextField.text = medicalOrganization.nameShort
        let job: [String: Any] = ["id": medicalOrganization.id, "job_oid": medicalOrganization.oid, "is_main": true]
        jobArray.append(job)
    }
    
    func setAddMedicalOrganization(medicalOrganization: MedicalOrganization) {
        self.addWorkPlace = medicalOrganization
        view.addWorkTextField.text = medicalOrganization.nameShort
        let job: [String: Any] = ["id": medicalOrganization.id, "job_oid": medicalOrganization.oid, "is_main": false]
        jobArray.append(job)
    }
    
    func setMedicalSpecialization(medicalSpecialization: MedicalSpecialization) {
        self.mainSpec = medicalSpecialization
        view.specTextField.text = medicalSpecialization.name
        let spec: [String: Any] = ["id": medicalSpecialization.id, "spec_id": medicalSpecialization.parent_id, "is_main": true]
        specArray.append(spec)
    }
    
    func setAddMedicalSpecialization(medicalSpecialization: MedicalSpecialization) {
        self.addSpec = medicalSpecialization
        view.addSpecTextField.text = medicalSpecialization.name
        let spec: [String: Any] = ["id": medicalSpecialization.id, "spec_id": medicalSpecialization.parent_id, "is_main": false]
        specArray.append(spec)
    }
    
    // MARK: - Coordinator
    func next() {
        let viewController = CreateProfileSpecViewController()
        let presenter = CreateProfileSpecPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.user = user
        presenter.jobArray = jobArray
        presenter.specArray = specArray
        presenter.mainSpec = mainSpec?.code
        presenter.addSpec = addSpec?.code
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
