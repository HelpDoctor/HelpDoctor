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
    private var jobArray: [Job] = []
    private var specArray: [Specialization] = []
    private var jobIndex = 0
    private var specIndex = 0
    
    required init(view: CreateProfileWorkViewController) {
        self.view = view
        jobArray = Session.instance.userJob ?? []
        specArray = Session.instance.specialization ?? []
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
        if jobArray.isEmpty {
            updateSpec()
        } else {
            guard let oid = jobArray[0].organization?.oid else { return }
            var updateJob: [[String: Any]] = []
            let job: [String: Any] = ["id": 0, "job_oid": oid, "is_main": true]
            updateJob.append(job)
            for i in 1 ..< jobArray.count {
                updateJob.append(["id": i + 1, "job_oid": jobArray[i].organization?.oid as Any, "is_main": false])
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
        guard let specId = specArray[0].specialization?.id else { return }
        var updateSpec: [[String: Any]] = []
        let spec: [String: Any] = ["id": 1, "spec_id": specId as Any, "is_main": true]
        updateSpec.append(spec)
        for i in 1 ..< specArray.count {
            updateSpec.append(["id": i + 1, "spec_id": specArray[i].specialization?.id as Any, "is_main": false])
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
            return jobArray[index].organization?.nameShort ?? ""
        }
    }
    
    func getSpec(_ index: Int) -> String {
        if index + 1 > specArray.count {
            return ""
        } else {
            return specArray[index].specialization?.name ?? ""
        }
    }
    
    func setUser() {
        user = UpdateProfileKeyUser(first_name: Session.instance.user?.firstName,
                                    last_name: Session.instance.user?.lastName,
                                    middle_name: Session.instance.user?.middleName,
                                    phone_number: Session.instance.user?.phoneNumber,
                                    birthday: Session.instance.user?.birthday,
                                    city_id: Session.instance.user?.cityId,
                                    foto: Session.instance.user?.foto,
                                    gender: Session.instance.user?.gender,
                                    is_medic_worker: Session.instance.user?.isMedicWorker)
        guard let isMedic = user?.is_medic_worker else { return }
        if isMedic == 0 {
            view.setEmployment(isMedic: false)
        } else if isMedic == 1 {
            view.setEmployment(isMedic: true)
        }
    }
    
    func setJob(job: MedicalOrganization) {
        if jobIndex < jobArray.count {
            let jobId = Session.instance.userJob?[jobIndex].id ?? 0
            jobArray.remove(at: jobIndex)
            jobArray.insert(Job(id: jobId, isMain: jobIndex == 0, organization: job), at: jobIndex)
        } else {
            jobArray.append(Job(id: 0, isMain: jobIndex == 0, organization: job))
        }
        view.reloadJobTableView()
    }
    
    func setSpec(spec: MedicalSpecialization) {
        if specIndex < specArray.count {
            let specId = Session.instance.specialization?[specIndex].id ?? 0
            specArray.remove(at: specIndex)
            specArray.insert(Specialization(id: specId, isMain: specIndex == 0, specialization: spec), at: specIndex)
        } else {
            specArray.append(Specialization(id: 0, isMain: specIndex == 0, specialization: spec))
        }
        view.reloadSpecTableView()
    }
    
    func setEmployment(_ employment: Bool) {
        user?.is_medic_worker = employment ? 1 : 0
    }
    
    // MARK: - Coordinator
    func next() {
        if specArray.isEmpty {
            view.showAlert(message: "Не заполнена основная специализация")
            return
        }
        if user?.is_medic_worker == 1 {
            if jobArray.isEmpty {
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
            presenter.jobArray = jobArray
            presenter.specArray = specArray
            view.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
