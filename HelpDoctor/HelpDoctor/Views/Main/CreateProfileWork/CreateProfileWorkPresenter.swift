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
    var user: User?
    var isEdit = false
    var region: Regions?
    var educationArray: [Education] = []
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
    /// Обновление информации о работе пользователя на сервере
    private func updateJob() {
        if jobArray.isEmpty {
            updateSpec()
        } else {
            NetworkManager.shared.updateUser(nil, jobArray, nil, nil, nil) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self?.updateSpec()
                    case .failure(let error):
                        self?.view.showAlert(message: error.description)
                    }
                    self?.view.stopActivityIndicator()
                }
            }
        }
    }
    
    /// Обновление информации о специализации пользователя на сервере
    private func updateSpec() {
        NetworkManager.shared.updateUser(nil, nil, specArray, nil, nil) { [weak self] result in
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
        presenter.sender = CreateProfileWorkViewController.identifier
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
        user = Session.instance.user
        guard let isMedic = user?.isMedicWorker else { return }
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
        user?.isMedicWorker = employment ? 1 : 0
    }
    
    // MARK: - Coordinator
    func next() {
        if specArray.isEmpty {
            view.showAlert(message: "Не заполнена основная специализация")
            return
        }
        if user?.isMedicWorker == 1 {
            if jobArray.isEmpty {
                view.showAlert(message: "Не заполнено основное место работы")
                return
            }
        }
        
        if isEdit {
            updateJob()
        } else {
            let viewController = CreateProfileSpecViewController()
            let presenter = CreateProfileSpecPresenter(view: viewController)
            viewController.presenter = presenter
            presenter.user = user
            presenter.jobArray = jobArray
            presenter.specArray = specArray
            presenter.educationArray = educationArray
            view.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
