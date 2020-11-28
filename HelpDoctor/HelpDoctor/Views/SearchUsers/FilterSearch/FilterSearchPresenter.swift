//
//  FilterSearchPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 26.11.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol FilterSearchPresenterProtocol: Presenter {
    init(view: FilterSearchViewController)
    func searchUsers(_ query: SearchQuery, _ limit: Int, _ page: Int, _ queryDescription: String)
    func specSearch()
    func setSpec(spec: MedicalSpecialization)
    func getSpecId() -> Int?
    func citySearch()
    func setCity(city: Cities)
    func getCityId() -> Int?
    func jobSearch()
    func setJob(job: MedicalOrganization)
    func getJobId() -> String?
    func universitySearch()
    func setUniversity(university: University)
    func getUniversityId() -> Int?
}

class FilterSearchPresenter: FilterSearchPresenterProtocol {
    
    // MARK: - Dependency
    let view: FilterSearchViewController
    
    // MARK: - Constants and variables
    private var spec: MedicalSpecialization?
    private var city: Cities?
    private var job: MedicalOrganization?
    private var university: University?
    
    required init(view: FilterSearchViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    func searchUsers(_ query: SearchQuery,
                     _ limit: Int,
                     _ page: Int,
                     _ queryDescription: String) {
        view.startActivityIndicator()
        NetworkManager.shared.searchUsers(query, limit, page) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success:
                    let viewController = ResultSearchViewController()
                    let presenter = ResultSearchPresenter(view: viewController)
                    viewController.presenter = presenter
                    viewController.filterParams = queryDescription
                    do {
                        presenter.usersList = try result.get().users
                        presenter.usersCount = try result.get().count
                    } catch {
                        return
                    }
                    self.view.navigationController?.pushViewController(viewController, animated: true)
                case .failure(let error):
                    self.view.showAlert(message: error.description)
                }
                self.view.stopActivityIndicator()
            }
        }
    }
    
    func specSearch() {
        let viewController = MedicalSpecializationViewController()
        let presenter = MedicalSpecializationPresenter(view: viewController)
        presenter.sender = FilterSearchViewController.identifier
        viewController.presenter = presenter
        presenter.getMedicalSpecialization()
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setSpec(spec: MedicalSpecialization) {
        self.spec = spec
        view.setSpec(spec: spec.name ?? "")
    }
    
    func getSpecId() -> Int? {
        return spec?.id
    }
    
    func citySearch() {
        let viewController = RegionsViewController()
        let presenter = RegionsPresenter(view: viewController)
        presenter.sender = FilterSearchViewController.identifier
        viewController.presenter = presenter
        viewController.startActivityIndicator()
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setCity(city: Cities) {
        self.city = city
        view.setCity(city: city.cityName ?? "")
    }
    
    func getCityId() -> Int? {
        return city?.id
    }
    
    func jobSearch() {
        let viewController = RegionsViewController()
        let presenter = RegionsPresenter(view: viewController)
        presenter.sender = "Region for job in filter search"
        viewController.presenter = presenter
        viewController.startActivityIndicator()
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setJob(job: MedicalOrganization) {
        self.job = job
        view.setJob(job: job.nameShort ?? "")
    }
    
    func getJobId() -> String? {
        return job?.oid
    }
    
    func universitySearch() {
        let viewController = UniversitiesViewController()
        let presenter = UniversitiesPresenter(view: viewController)
        presenter.sender = FilterSearchViewController.identifier
        viewController.presenter = presenter
        viewController.startActivityIndicator()
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setUniversity(university: University) {
        self.university = university
        view.setUniversity(university: university.educationName ?? "")
    }
    
    func getUniversityId() -> Int? {
        return university?.educationId
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
}
