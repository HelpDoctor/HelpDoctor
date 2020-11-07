//
//  UniversitiesPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 19.08.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol UniversitiesPresenterProtocol: Presenter {
    init(view: UniversitiesViewController)
    func getUniversities()
    func getCountUniversities() -> Int?
    func getUniversityTitle(index: Int) -> String?
    func searchTextIsEmpty()
    func filter(searchText: String)
    func next(index: Int?)
}

class UniversitiesPresenter: UniversitiesPresenterProtocol {
    
    private let networkManager = NetworkManager()
    var view: UniversitiesViewController
    var arrayUniversities: [University]?
    var filteredArray: [University] = []
    var sender: String?
    
    required init(view: UniversitiesViewController) {
        self.view = view
    }
    
    func getUniversities() {
        if sender != nil {
            view.setTitleButton()
        }
        
        networkManager.getUniversities { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let universities):
                    self?.arrayUniversities = universities
                    self?.filteredArray = universities
                    self?.view.reloadTableView()
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
                self?.view.stopActivityIndicator()
            }
        }
    }
    
    
    func getCountUniversities() -> Int? {
        return filteredArray.count
    }
    
    func getUniversityTitle(index: Int) -> String? {
        return filteredArray[index].educationName
    }
    
    func searchTextIsEmpty() {
        filteredArray = arrayUniversities ?? []
        view.reloadTableView()
    }
    
    func filter(searchText: String) {
        guard let arrayUniversities = arrayUniversities else { return }
        filteredArray = arrayUniversities.filter({ university -> Bool in
            return (university.educationName?.lowercased().contains(searchText.lowercased()) ?? false)
        })
        view.reloadTableView()
    }
    
    // MARK: - Coordinator
    func next(index: Int?) {
        guard let index = index else {
            view.showAlert(message: "Выберите одно учебное заведение")
            return
        }
        let university = filteredArray[index]
        view.navigationController?.popViewController(animated: true)
        guard let prev = view.navigationController?.viewControllers.last as? CreateProfileStep6ViewController else {
            return
        }
        let presenter = prev.presenter
        presenter?.setUniversity(university: university)
        prev.view.layoutIfNeeded()
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
