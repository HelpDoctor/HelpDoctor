//
//  MedicalOrganizationPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 03.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol MedicalOrganizationPresenterProtocol: Presenter {
    init(view: MedicalOrganizationViewController)
    func getMedicalOrganization(regionId: Int, mainWork: Bool)
    func getCountMedicalOrganizations() -> Int?
    func getMedicalOrganizationTitle(index: Int) -> String?
    func searchTextIsEmpty()
    func filter(searchText: String)
    func next(index: Int?)
}

class MedicalOrganizationPresenter: MedicalOrganizationPresenterProtocol {
    
    var view: MedicalOrganizationViewController
    private let networkManager = NetworkManager()
    var arrayMedicalOrganizations: [MedicalOrganization]?
    var filteredArray: [MedicalOrganization] = []
    var mainWork: Bool?
    var sender: String?
    
    required init(view: MedicalOrganizationViewController) {
        self.view = view
    }
    
    func getMedicalOrganization(regionId: Int, mainWork: Bool) {
        view.startActivityIndicator()
        self.mainWork = mainWork
        networkManager.getMedicalOrganizations(regionId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let medicalOrganizations):
                    self?.arrayMedicalOrganizations = medicalOrganizations
                    self?.filteredArray = medicalOrganizations
                    self?.view.reloadTableView()
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
                self?.view.stopActivityIndicator()
            }
        }
    }
    
    func getCountMedicalOrganizations() -> Int? {
        return filteredArray.count
    }
    
    func getMedicalOrganizationTitle(index: Int) -> String? {
        return filteredArray[index].nameShort
    }
    
    func searchTextIsEmpty() {
        filteredArray = arrayMedicalOrganizations ?? []
        view.reloadTableView()
    }
    
    func filter(searchText: String) {
        guard let arrayMedicalOrganizations = arrayMedicalOrganizations else { return }
        filteredArray = arrayMedicalOrganizations.filter({ organization -> Bool in
            return (organization.nameShort?.lowercased().contains(searchText.lowercased()) ?? false)
        })
        view.reloadTableView()
    }
    
    // MARK: - Coordinator
    func next(index: Int?) {
        guard let index = index else {
            view.showAlert(message: "Выберите одну организацию")
            return
        }
        let medicalOrganization = filteredArray[index]
        
        guard let controllers = view.navigationController?.viewControllers else { return }
        for viewControllers in controllers where viewControllers is CreateProfileWorkViewController {
            guard let previous = viewControllers as? CreateProfileWorkViewController else { return }
            let presenter = previous.presenter
            presenter?.setJob(job: medicalOrganization)
            view.navigationController?.popToViewController(viewControllers, animated: true)
        }
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
