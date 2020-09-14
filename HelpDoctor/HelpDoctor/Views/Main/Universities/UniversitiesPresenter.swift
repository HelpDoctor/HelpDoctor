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
        let getUniversities = Profile()
        
        getData(typeOfContent: .getUniversities,
                returning: ([University], Int?, String?).self,
                requestParams: [:]) { [weak self] result in
                    let dispathGroup = DispatchGroup()
                    
                    getUniversities.universities = result?.0
                    
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async { [weak self]  in
                            self?.arrayUniversities = getUniversities.universities
                            self?.filteredArray = getUniversities.universities ?? []
                            self?.view.reloadTableView()
                            self?.view.stopActivityIndicator()
                        }
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
        //swiftlint:disable force_cast
        let previous = view.navigationController?.viewControllers.last as! CreateProfileStep6ViewController
        let presenter = previous.presenter
        presenter?.setUniversity(university: university)
        previous.view.layoutIfNeeded()
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
