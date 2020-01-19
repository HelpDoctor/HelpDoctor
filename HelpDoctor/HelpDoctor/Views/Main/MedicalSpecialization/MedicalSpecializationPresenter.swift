//
//  MedicalSpecializationPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 03.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol MedicalSpecializationPresenterProtocol {
    init(view: MedicalSpecializationViewController)
    func getMedicalSpecialization(mainSpec: Bool)
    func getCountMedicalSpecialization() -> Int?
    func getMedicalSpecializationTitle(index: Int) -> String?
    func next(index: Int?)
}

class MedicalSpecializationPresenter: MedicalSpecializationPresenterProtocol {
    
    var view: MedicalSpecializationViewController
    var arrayMedicalSpecialization: [MedicalSpecialization]?
    var mainSpec: Bool?
    var sender: String?
    
    required init(view: MedicalSpecializationViewController) {
        self.view = view
    }
    
    func getMedicalSpecialization(mainSpec: Bool) {
        view.startAnimating()
        let getMedicalSpecialization = Profile()
        self.mainSpec = mainSpec
        
        getData(typeOfContent: .getMedicalSpecialization,
                returning: ([MedicalSpecialization], Int?, String?).self,
                requestParams: [:])
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            getMedicalSpecialization.medicalSpecialization = result?.0
            getMedicalSpecialization.responce = (result?.1, result?.2)
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    self?.view.stopAnimating()
                    self?.arrayMedicalSpecialization = getMedicalSpecialization.medicalSpecialization
                    self?.view.tableView.reloadData()
                }
            }
        }
    }
    
    func getCountMedicalSpecialization() -> Int? {
        return arrayMedicalSpecialization?.count
    }
    
    func getMedicalSpecializationTitle(index: Int) -> String? {
        return arrayMedicalSpecialization?[index].name
    }
    
    // MARK: - Coordinator
    func next(index: Int?) {
        guard let index = index,
            let medicalSpecialization = arrayMedicalSpecialization?[index] else {
                view.showAlert(message: "Выберите одну специализацию")
                return }
        view.navigationController?.popViewController(animated: true)
        let previous = view.navigationController?.viewControllers.last as! CreateProfileWorkViewController
        let presenter = previous.presenter
        switch sender {
        case "main":
            presenter?.setMedicalSpecialization(medicalSpecialization: medicalSpecialization)
        case "add":
            presenter?.setAddMedicalSpecialization(medicalSpecialization: medicalSpecialization)
        case "third":
            presenter?.setThirdMedicalSpecialization(medicalSpecialization: medicalSpecialization)
        default:
            view.showAlert(message: "Error")
        }
    }
    
}
