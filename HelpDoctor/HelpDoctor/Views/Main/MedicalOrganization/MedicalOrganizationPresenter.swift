//
//  MedicalOrganizationPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 03.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol MedicalOrganizationPresenterProtocol {
    init(view: MedicalOrganizationViewController)
    func getMedicalOrganization(regionId: Int, mainWork: Bool)
    func getCountMedicalOrganizations() -> Int?
    func getMedicalOrganizationTitle(index: Int) -> String?
    func next(index: Int?)
}

class MedicalOrganizationPresenter: MedicalOrganizationPresenterProtocol {
    
    var view: MedicalOrganizationViewController
    var arrayMedicalOrganizations: [MedicalOrganization]?
    var mainWork: Bool?
    var sender: String?
    
    required init(view: MedicalOrganizationViewController) {
        self.view = view
    }
    
    func getMedicalOrganization(regionId: Int, mainWork: Bool) {
        view.startActivityIndicator()
        let getMedicalOrganization = Profile()
        self.mainWork = mainWork
        
        getData(typeOfContent: .getMedicalOrganization,
                returning: ([MedicalOrganization], Int?, String?).self,
                requestParams: ["region": "\(regionId)"])
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            getMedicalOrganization.medicalOrganization = result?.0
            getMedicalOrganization.responce = (result?.1, result?.2)
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    self?.view.stopActivityIndicator()
                    self?.arrayMedicalOrganizations = getMedicalOrganization.medicalOrganization
                    self?.view.tableView.reloadData()
                }
            }
        }
    }
    
    func getCountMedicalOrganizations() -> Int? {
        return arrayMedicalOrganizations?.count
    }
    
    func getMedicalOrganizationTitle(index: Int) -> String? {
        return arrayMedicalOrganizations?[index].nameShort
    }
    
    // MARK: - Coordinator
    func next(index: Int?) {
        guard let index = index,
            let medicalOrganization = arrayMedicalOrganizations?[index] else {
                view.showAlert(message: "Выберите одну организацию")
                return
        }
        let previous = view.navigationController?.viewControllers[2] as! CreateProfileWorkViewController
        let presenter = previous.presenter
        presenter?.setJob(job: medicalOrganization)
        view.navigationController?.popToViewController(previous, animated: true)
    }
    
}
