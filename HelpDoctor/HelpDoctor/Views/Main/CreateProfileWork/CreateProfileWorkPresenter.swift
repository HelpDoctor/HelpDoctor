//
//  CreateProfileWorkPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 01.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol CreateProfileWorkPresenterProtocol: Presenter {
    init(view: CreateProfileWorkViewController)
    var isEdit: Bool { get }
    func jobSearch(_ index: Int)
    func specSearch(_ index: Int)
    func getCountJob() -> Int
    func getCountSpec() -> Int
    func getJob(_ index: Int) -> String
    func getSpec(_ index: Int) -> String
    func setUser()
    func setJob(job: MedicalOrganization)
    func setSpec(spec: MedicalSpecialization)
    func setEmployment(_ employment: Bool)
    func next()
    func back()
}

class CreateProfileWorkPresenter: CreateProfileWorkPresenterProtocol {
    
    // MARK: - Dependency
    let view: CreateProfileWorkViewController
    
    // MARK: - Constants and variables
    var user: UpdateProfileKeyUser?
    var isEdit = false
    var region: Regions?
    private var jobArray: [MedicalOrganization?] = [nil, nil, nil, nil, nil]
    private var specArray: [MedicalSpecialization?] = [nil, nil, nil, nil, nil]
    private var jobIndex = 0
    private var specIndex = 0
    
    required init(view: CreateProfileWorkViewController) {
        self.view = view
    }
    
    // MARK: - Private methods
    /// Обновление информации о пользователе на сервере
    private func updateProfile() {
        let updateProfile = UpdateProfileKeyUser(first_name: user?.first_name,
                                                 last_name: user?.last_name,
                                                 middle_name: user?.middle_name,
                                                 phone_number: user?.phone_number,
                                                 birthday: user?.birthday,
                                                 city_id: user?.city_id,
                                                 foto: user?.foto,
                                                 gender: user?.gender,
                                                 is_medic_worker: user?.is_medic_worker)
        
        getData(typeOfContent: .updateProfile,
                returning: (Int?, String?).self,
                requestParams: ["json": updateProfile.jsonData as Any] ) { [weak self] result in
                    let dispathGroup = DispatchGroup()
                    
                    updateProfile.responce = result
                    
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async { [weak self]  in
                            print("updateProfile = \(String(describing: updateProfile.responce))")
                            guard let code = updateProfile.responce?.0 else { return }
                            if responceCode(code: code) {
                                self?.updateJob()
                            } else {
                                self?.view.showAlert(message: updateProfile.responce?.1)
                            }
                        }
                    }
        }
    }
    
    /// Обновление информации о работе пользователя на сервере
    private func updateJob() {
        if jobArray.count == 0 {
            updateSpec()
        } else {
            guard let oid = jobArray[0]?.oid else { return }
            var updateJob: [[String: Any]] = []
            let job: [String: Any] = ["id": 0, "job_oid": oid, "is_main": true]
            updateJob.append(job)
            for i in 1 ..< jobArray.count {
                updateJob.append(["id": 0, "job_oid": jobArray[i]?.oid as Any, "is_main": false])
            }
            print("Update job: \(updateJob)")
            let updateProfileJob = UpdateProfileKeyJob(arrayJob: updateJob)
            getData(typeOfContent: .updateProfile,
                    returning: (Int?, String?).self,
                    requestParams: ["json": updateProfileJob.jsonData as Any]) { [weak self] result in
                        let dispathGroup = DispatchGroup()
                        
                        updateProfileJob.responce = result
                        
                        dispathGroup.notify(queue: DispatchQueue.main) {
                            DispatchQueue.main.async { [weak self]  in
                                print("updateJobProfile = \(String(describing: updateProfileJob.responce))")
                                guard let code = updateProfileJob.responce?.0 else { return }
                                if responceCode(code: code) {
                                    self?.updateSpec()
                                } else {
                                    self?.view.showAlert(message: updateProfileJob.responce?.1)
                                }
                            }
                        }
            }
        }
    }
    
    /// Обновление информации о специализации пользователя на сервере
    private func updateSpec() {
        guard let specId = specArray[0]?.id else { return }
        var updateSpec: [[String: Any]] = []
        let spec: [String: Any] = ["id": 0, "spec_id": specId as Any, "is_main": true]
        updateSpec.append(spec)
        for i in 1 ..< specArray.count {
            updateSpec.append(["id": 0, "spec_id": specArray[i]?.id as Any, "is_main": false])
        }
        let updateProfileSpec = UpdateProfileKeySpec(arraySpec: updateSpec)
        
        getData(typeOfContent: .updateProfile,
                returning: (Int?, String?).self,
                requestParams: ["json": updateProfileSpec.jsonData as Any]) { [weak self] result in
                    let dispathGroup = DispatchGroup()
                    
                    updateProfileSpec.responce = result
                    
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async { [weak self]  in
                            print("updateProfileSpec = \(String(describing: updateProfileSpec.responce))")
                            guard let code = updateProfileSpec.responce?.0 else { return }
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
                                self?.view.showAlert(message: updateProfileSpec.responce?.1)
                            }
                        }
                    }
        }
    }
    
    // MARK: - Public methods
    func jobSearch(_ index: Int) {
        jobIndex = index
        var idRegion: Int?
//        let viewController = RegionsViewController()
//        let presenter = RegionsPresenter(view: viewController)
//        viewController.presenter = presenter
//        presenter.sender = "Work"
//        view.navigationController?.pushViewController(viewController, animated: true)
        if isEdit {
            idRegion = Session.instance.user?.regionId
        } else {
            idRegion = region?.regionId
        }
        guard let regionId = idRegion else { return }
        let viewController = MedicalOrganizationViewController()
        let presenter = MedicalOrganizationPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.getMedicalOrganization(regionId: regionId, mainWork: true)
        presenter.sender = "Work"
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func specSearch(_ index: Int) {
        specIndex = index
        let viewController = MedicalSpecializationViewController()
        let presenter = MedicalSpecializationPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.getMedicalSpecialization()
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func getCountJob() -> Int {
        return jobArray.count
    }
    
    func getCountSpec() -> Int {
        return specArray.count
    }
    
    func getJob(_ index: Int) -> String {
        if index + 1 > jobArray.count {
            return ""
        } else {
            return jobArray[index]?.nameShort ?? ""
        }
    }
    
    func getSpec(_ index: Int) -> String {
        if index + 1 > specArray.count {
            return ""
        } else {
            return specArray[index]?.name ?? ""
        }
    }
    
    func setUser() {
        user = UpdateProfileKeyUser(first_name: Session.instance.user?.first_name,
                                    last_name: Session.instance.user?.last_name,
                                    middle_name: Session.instance.user?.middle_name,
                                    phone_number: Session.instance.user?.phone_number,
                                    birthday: Session.instance.user?.birthday,
                                    city_id: Session.instance.user?.city_id,
                                    foto: Session.instance.user?.foto,
                                    gender: Session.instance.user?.gender,
                                    is_medic_worker: Session.instance.user?.is_medic_worker)
        guard let isMedic = user?.is_medic_worker else { return }
        if isMedic == 0 {
            view.setEmployment(isMedic: false)
        } else if isMedic == 1 {
            view.setEmployment(isMedic: true)
        }
    }
    
    func setJob(job: MedicalOrganization) {
        jobArray.insert(job, at: jobIndex)
        view.reloadJobTableView()
    }
    
    func setSpec(spec: MedicalSpecialization) {
        specArray.insert(spec, at: specIndex)
        view.reloadSpecTableView()
    }
    
    func setEmployment(_ employment: Bool) {
        user?.is_medic_worker = employment ? 1 : 0
    }
    
    // MARK: - Coordinator
    func next() {
        guard specArray[0] != nil else {
            view.showAlert(message: "Не заполнена основная специализация")
            return
        }
        if user?.is_medic_worker == 1 {
            guard jobArray[0] != nil else {
                view.showAlert(message: "Не заполнено основное место работы")
                return
            }
        }
        
        if isEdit {
            updateProfile()
        } else {
            let viewController = CreateProfileSpecViewController()
            let presenter = CreateProfileSpecPresenter(view: viewController)
            viewController.presenter = presenter
            presenter.user = user
            presenter.jobArray = jobArray.filter {
                $0?.oid != nil
            }
            presenter.specArray = specArray.filter {
                $0?.id != nil
            }
            view.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
