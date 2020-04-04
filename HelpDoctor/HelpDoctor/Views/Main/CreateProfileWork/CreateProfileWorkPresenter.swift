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
    func jobSearch(_ index: Int)
    func specSearch(_ index: Int)
    func getCountJob() -> Int
    func getCountSpec() -> Int
    func getJob(_ index: Int) -> String
    func getSpec(_ index: Int) -> String
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
    private var jobArray: [MedicalOrganization?] = [nil, nil, nil, nil, nil]
    private var specArray: [MedicalSpecialization?] = [nil, nil, nil, nil, nil]
    private var jobIndex = 0
    private var specIndex = 0
    
    required init(view: CreateProfileWorkViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    func jobSearch(_ index: Int) {
        jobIndex = index
        let viewController = RegionsViewController()
        let presenter = RegionsPresenter(view: viewController)
        viewController.presenter = presenter
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
        guard (user?.is_medic_worker) != nil else {
            view.showAlert(message: "Поле занятость не заполнено")
            return
        }
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
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
