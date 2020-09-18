//
//  MedicalSpecializationPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 03.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol MedicalSpecializationPresenterProtocol: Presenter {
    init(view: MedicalSpecializationViewController)
    func getMedicalSpecialization()
    func getCountMedicalSpecialization() -> Int?
    func getMedicalSpecializationTitle(index: Int) -> String?
    func searchTextIsEmpty()
    func filter(searchText: String)
    func next(index: Int?)
}

class MedicalSpecializationPresenter: MedicalSpecializationPresenterProtocol {
    
    var view: MedicalSpecializationViewController
    let networkManager = NetworkManager()
    var arrayMedicalSpecialization: [MedicalSpecialization]?
    var filteredArray: [MedicalSpecialization] = []
    
    required init(view: MedicalSpecializationViewController) {
        self.view = view
    }
    
    func getMedicalSpecialization() {
        view.startActivityIndicator()
        networkManager.getMedicalSpecializations { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let medicalSpecializations):
                    self?.arrayMedicalSpecialization = medicalSpecializations
                    self?.filteredArray = medicalSpecializations
                    self?.view.reloadTableView()
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
                self?.view.stopActivityIndicator()
            }
        }
    }
    
    func getCountMedicalSpecialization() -> Int? {
        return filteredArray.count
    }
    
    func getMedicalSpecializationTitle(index: Int) -> String? {
        return filteredArray[index].name
    }
    
    func searchTextIsEmpty() {
        filteredArray = arrayMedicalSpecialization ?? []
        view.reloadTableView()
    }
    
    func filter(searchText: String) {
        guard let arrayMedicalSpecialization = arrayMedicalSpecialization else { return }
        filteredArray = arrayMedicalSpecialization.filter({ specialization -> Bool in
            return (specialization.name?.lowercased().contains(searchText.lowercased()) ?? false)
        })
        view.reloadTableView()
    }
    
    // MARK: - Coordinator
    func next(index: Int?) {
        guard let index = index else {
            view.showAlert(message: "Выберите одну специализацию")
            return
        }
        let medicalSpecialization = filteredArray[index]
        view.navigationController?.popViewController(animated: true)
        guard let previous = view.navigationController?.viewControllers.last as? CreateProfileWorkViewController else {
            return
        }
        let presenter = previous.presenter
        presenter?.setSpec(spec: medicalSpecialization)
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
