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
    func interestsSearch()
    func setPhoto(photoString: String?)
    func save()
    func getInterestTitle(index: Int) -> String?
    func getInterestsCount() -> Int?
    func getInterestFromView()
    func deleteInterest(index: Int)
    func back()
}

class CreateProfileSpecPresenter: CreateProfileSpecPresenterProtocol {
    
    // MARK: - Dependency
    let view: CreateProfileSpecViewController
    
    // MARK: - Constants and variables
    var user: UpdateProfileKeyUser?
    var jobArray: [MedicalOrganization?] = []
    var specArray: [MedicalSpecialization?] = []
//    var mainSpecArray: [[String: Any]]?
//    var addSpecArray: [[String: Any]]?
    var userInterests: [ListOfInterests] = []
    var arrayOfAllInterests: [ListOfInterests]?
//    var mainSpec: String?
//    var addSpec: String?
    
    // MARK: - Init
    required init(view: CreateProfileSpecViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    /// Открытие формы со списком интересов
    func interestsSearch() {
        guard specArray.count != 0 else {
            view.showAlert(message: "Необходимо заполнить основную специализацию на предыдущем экране")
            return
        }
//        guard mainSpec != nil else {
//            view.showAlert(message: "Необходимо заполнить основную специализацию на предыдущем экране")
//            return
//        }
        let viewController = InterestsViewController()
        let presenter = InterestsPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.arrayInterests = arrayOfAllInterests
        presenter.userInterests = userInterests
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /// Установка фотографии в классе UpdateProfileKeyUser
    /// - Parameter photoString: фотография пользователя в строковом виде
    func setPhoto(photoString: String?) {
        user?.foto = photoString
    }
    
    /// Сохранение всей введенной информации и переход к следующему экрану
    func save() {
        updateUser()
    }
    
    /// Установка названия в ячейку коллекции
    /// - Parameter index: индекс ячейки
    func getInterestTitle(index: Int) -> String? {
        return userInterests[index].name
    }
    
    /// Подсчет количества ячеек коллекции
    func getInterestsCount() -> Int? {
        return userInterests.count
    }
    
    /// Заполнение массива интересов
    func getInterestFromView() {
        switch specArray.count {
        case 0:
            view.showAlert(message: "Необходимо заполнить основную специализацию на предыдущем экране")
        case 1:
            getInterestsOneSpec(mainSpec: specArray[0]?.code ?? "general")
        default:
            getInterestsTwoSpec(mainSpec: specArray[0]?.code ?? "general", addSpec: specArray[1]?.code ?? "040100")
        }
//        if addSpec == nil {
//            getInterestsOneSpec(mainSpec: mainSpec ?? "general")
//        } else {
//            getInterestsTwoSpec(mainSpec: mainSpec ?? "general", addSpec: addSpec ?? "040100")
//        }
    }
    
    /// Удаление интереса из массива интересов пользователя, при отмене выделения ячейки коллекции
    /// - Parameter index: индекс ячейки
    func deleteInterest(index: Int) {
        guard (arrayOfAllInterests?[index].id) != nil else { return }
        userInterests.remove(at: index)
//        indexArray.remove(at: index)
        view.reloadCollectionView()
    }
    
    // MARK: - Private methods
    /// Загрузка массива всех интересов по одной специализации пользователя с сервера
    /// - Parameters:
    ///   - mainSpec: основная специализация пользователя
    private func getInterestsOneSpec(mainSpec: String) {
        let getListOfInterest = Profile()
        
        getData(typeOfContent: .getListOfInterestsExtOne,
                returning: ([String: [ListOfInterests]], Int?, String?).self,
                requestParams: ["spec_code": "\(mainSpec)"] )
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            getListOfInterest.listOfInterests = result?.0
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    let generalSpec: [ListOfInterests]? = getListOfInterest.listOfInterests?["general"]
                    let interestMainSpec: [ListOfInterests]? = getListOfInterest.listOfInterests?["\(mainSpec)"]
                    self?.arrayOfAllInterests = (interestMainSpec ?? []) + (generalSpec ?? [])
                    self?.view.reloadCollectionView()
                }
            }
        }
    }
    
    /// Загрузка массива всех интересов по двум специализациям пользователя с сервера
    /// - Parameters:
    ///   - mainSpec: основная специализация пользователя
    ///   - addSpec: дополнительная специализация пользователя
    private func getInterestsTwoSpec(mainSpec: String, addSpec: String) {
        let getListOfInterest = Profile()
        
        getData(typeOfContent: .getListOfInterestsExtTwo,
                returning: ([String: [ListOfInterests]], Int?, String?).self,
                requestParams: ["spec_code": "\(mainSpec)/\(addSpec)"] )
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            getListOfInterest.listOfInterests = result?.0
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    let generalSpec: [ListOfInterests]? = getListOfInterest.listOfInterests?["general"]
                    let interestMainSpec: [ListOfInterests]? = getListOfInterest.listOfInterests?["\(mainSpec)"]
                    let interestAddSpec: [ListOfInterests]? = getListOfInterest.listOfInterests?["\(addSpec)"]
                    self?.arrayOfAllInterests = (interestMainSpec ?? []) + (interestAddSpec ?? []) + (generalSpec ?? [])
                    self?.view.reloadCollectionView()
                }
            }
        }
    }
    
    /// Обновление информации о пользователе на сервере
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
    
    /// Обновление информации о работе пользователя на сервере
    private func updateJob() {
        guard let oid = jobArray[0]?.oid else { return }
        var updateJob: [[String: Any]] = []
        let job: [String: Any] = ["id": 0, "job_oid": oid, "is_main": true]
        updateJob.append(job)
        for i in 1 ..< jobArray.count {
            updateJob.append(["id": 0, "job_oid": jobArray[i]?.oid as Any, "is_main": false])
        }
        
        let updateProfileJob = UpdateProfileKeyJob(arrayJob: updateJob)
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
    
    /// Обновление информации о специализации пользователя на сервере
    private func updateSpec() {
//        guard let mainSpecArray = mainSpecArray else { return }
//        let specArray = mainSpecArray + (addSpecArray ?? [])
//        let updateProfileSpec = UpdateProfileKeySpec(arraySpec: specArray)
        
        guard let specId = specArray[0]?.id else { return }
        var updateSpec: [[String: Any]] = []
        let spec: [String: Any] = ["id": 0, "spec_id": specId as Any, "is_main": true]
        updateSpec.append(spec)
        for i in 1 ..< specArray.count {
            updateSpec.append(["id": 0, "spec_id": specArray[i]?.id as Any, "is_main": false])
        }
        let updateProfileSpec = UpdateProfileKeySpec(arraySpec: updateSpec)
        
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
    
    /// Обновление информации о интересах пользователя на сервере
    private func updateInterests() {
        var intArray: [Int] = []
        for i in 0 ..< userInterests.count {
            intArray.append(userInterests[i].id)
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
    /// Отправка специализации пользователя для заполнения таблицы под строкой
    func getSpecs() -> (String?, String?) {
        switch specArray.count {
        case 0:
            return (nil, nil)
        case 1:
            return (specArray[0]?.code, nil)
        default:
            return (specArray[0]?.code, specArray[1]?.code)
        }
    }
    
    /// Заполнение массива интересов пользователя из формы списка интересов
    /// - Parameter interests: массив интересов
    func setInterests(interests: [ListOfInterests]) {
        self.userInterests = interests
        view.reloadCollectionView()
    }
    
    /// Добавление в массив интересов пользователя значения из таблицы под строкой
    /// - Parameter interest: выбранный интерес
    func addInterest(interest: ListOfInterests) {
        view.setSpecTextField(text: "")
        userInterests.append(interest)
        view.reloadCollectionView()
    }
    
    func createInterest() {
        let viewController = CreateInterestViewController()
        let presenter = CreateInterestPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.delegate = self
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Coordinator
    /// Переход к предыдущему экрану
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
    /// Переход к следующему экрану
    private func next() {
        let viewController = ProfileViewController()
        viewController.presenter = ProfilePresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension CreateProfileSpecPresenter: CreateInterestPresenterDelegate {
    
    func callback(interests: [ListOfInterests]) {
        interests.forEach {
            userInterests.append($0.self)
            arrayOfAllInterests?.append($0.self)
        }
        view.reloadCollectionView()
    }
    
}
