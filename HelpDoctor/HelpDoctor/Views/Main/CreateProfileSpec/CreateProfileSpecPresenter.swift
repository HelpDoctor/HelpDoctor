//
//  CreateProfileSpecPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 01.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol CreateProfileSpecPresenterProtocol: InterestsSearchProtocol {
    init(view: CreateProfileSpecViewController)
    func setPhoto(photoString: String?)
    func interestsSearch()
    func back()
    func save()
}

class CreateProfileSpecPresenter: CreateProfileSpecPresenterProtocol {

    // MARK: - Dependency
    var view: CreateProfileSpecViewController
    
    // MARK: - Constants and variables
    var user: UpdateProfileKeyUser?
    var mainJobArray: [[String: Any]]?
    var addJobArray: [[String: Any]]?
    var mainSpecArray: [[String: Any]]?
    var addSpecArray: [[String: Any]]?
    private var interest: [ListOfInterests]?
    var mainSpec: String?
    var addSpec: String?
    
    required init(view: CreateProfileSpecViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    func interestsSearch() {
        guard let mainSpec = mainSpec else {
            view.showAlert(message: "Необходимо заполнить основную специализацию на предыдущем экране")
            return
        }
        let viewController = InterestsViewController()
        let presenter = InterestsPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.getInterests(mainSpec: mainSpec, addSpec: addSpec ?? "040100")
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setPhoto(photoString: String?) {
        user?.foto = photoString?.toBase64()
    }
    
    func save() {
        updateUser()
    }
    
    // MARK: - Private methods
    private func updateUser() {
        let updateProfile = UpdateProfileKeyUser(first_name: user?.first_name,
                                                 last_name: user?.last_name,
                                                 middle_name: user?.middle_name,
                                                 phone_number: user?.phone_number,
                                                 birthday: user?.birthday,
                                                 city_id: user?.city_id,
                                                 foto: user?.foto)
        
        getData(typeOfContent: .updateProfile,
                returning: (Int?, String?).self,
                requestParams: ["json": updateProfile.jsonData as Any] )
        { [weak self] result in
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
    
    private func updateJob() {
        guard let mainJobArray = mainJobArray else { return }
        let jobArray = mainJobArray + (addJobArray ?? [])
        let updateProfileJob = UpdateProfileKeyJob(arrayJob: jobArray)
        print(jobArray.count)
        print(jobArray)
        getData(typeOfContent: .updateProfile,
                returning: (Int?, String?).self,
                requestParams: ["json": updateProfileJob.jsonData as Any])
        { [weak self] result in
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
    
    private func updateSpec() {
        guard let mainSpecArray = mainSpecArray else { return }
        let specArray = mainSpecArray + (addSpecArray ?? [])
        print(specArray)
        let updateProfileSpec = UpdateProfileKeySpec(arraySpec: specArray)
        print(specArray.count)
        getData(typeOfContent: .updateProfile,
                returning: (Int?, String?).self,
                requestParams: ["json": updateProfileSpec.jsonData as Any])
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            updateProfileSpec.responce = result
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    print("updateProfileSpec = \(String(describing: updateProfileSpec.responce))")
                    guard let code = updateProfileSpec.responce?.0 else { return }
                    if responceCode(code: code) {
                        self?.updateInterests()
                    } else {
                        self?.view.showAlert(message: updateProfileSpec.responce?.1)
                    }
                }
            }
        }
    }
    
    private func updateInterests() {
        guard let interest = interest else {
            self.next()
            return
        }
        var intArray: [Int] = []
        for i in 0 ..< interest.count {
            intArray.append(interest[i].id)
        }
        
        let updateProfile = UpdateProfileKeyInterest(arrayInterest: intArray)
        
        getData(typeOfContent: .updateProfile,
                returning: (Int?, String?).self,
                requestParams: ["json": updateProfile.jsonData as Any])
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            updateProfile.responce = result
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    print("updateInterests = \(String(describing: updateProfile.responce))")
                    guard let code = updateProfile.responce?.0 else { return }
                    if responceCode(code: code) {
                        self?.next()
                    } else {
                        self?.view.showAlert(message: updateProfile.responce?.1)
                    }
                }
            }
        }
    }
    
    // MARK: - InterestsSearchProtocol
    func getSpecs() -> (String?, String?) {
        return (mainSpec, addSpec)
    }
    
    func setInterests(interests: [ListOfInterests]) {
        self.interest = interests
        guard let interest = interest else { return }
        var stringArray: [String] = []
        for i in 0 ..< interest.count {
            stringArray.append(interest[i].name ?? "")
        }
        let string = stringArray.joined(separator: " ")
        view.specTextField.text = string
    }
    
    // MARK: - Coordinator
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
    private func next() {
        let viewController = ProfileViewController()
        viewController.presenter = ProfilePresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
}