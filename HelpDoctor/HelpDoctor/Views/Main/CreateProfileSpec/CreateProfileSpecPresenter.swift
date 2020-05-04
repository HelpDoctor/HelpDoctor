//
//  CreateProfileSpecPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 01.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol CreateProfileSpecPresenterProtocol: Presenter {
    init(view: CreateProfileSpecViewController)
    var isEdit: Bool { get }
    func loadPopularInterests(_ spec: String?)
    func selectRows()
    func getInterestTitle(index: Int) -> String?
    func getInterestsCount() -> Int?
    func getInterestFromView()
    func addInterest(index: Int)
    func deleteInterest(index: Int)
    func setInterests(interests: [ListOfInterests])
    func next()
    func toAddInterest()
    func getUser()
}

class CreateProfileSpecPresenter: CreateProfileSpecPresenterProtocol {
    
    // MARK: - Dependency
    let view: CreateProfileSpecViewController
    
    // MARK: - Constants and variables
    var user: UpdateProfileKeyUser?
    var isEdit = false
    var jobArray: [MedicalOrganization?] = []
    var specArray: [MedicalSpecialization?] = []
    var userInterests: [ListOfInterests] = []
    var arrayOfAllInterests: [ListOfInterests]?
    var popularInterests: [ListOfInterests]?
    
    // MARK: - Init
    required init(view: CreateProfileSpecViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    /// Загрузка с сервера первых 10 интересов по основной специализации
    func loadPopularInterests(_ spec: String?) {
        var mainSpec = "general"
        if specArray.count != 0 {
            mainSpec = specArray[0]?.code ?? "general"
        }
        if spec != nil {
            mainSpec = spec ?? "general"
        }
        let getListOfInterest = Profile()
        
        getData(typeOfContent: .getListOfInterestsExtOne,
                returning: ([String: [ListOfInterests]], [Int]?, Int?, String?).self,
                requestParams: ["spec_code": "\(mainSpec)"] ) { [weak self] result in
                    let dispathGroup = DispatchGroup()
                    
                    getListOfInterest.listOfInterests = result?.0
                    
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async { [weak self]  in
                            let interestMainSpec: [ListOfInterests]? = getListOfInterest.listOfInterests?["\(mainSpec)"]
                            let idRelevantInterests = result?.1 ?? []
                            var sliceArray: [ListOfInterests] = []
                            for id in idRelevantInterests {
                                sliceArray += interestMainSpec?.filter { $0.id == id } ?? []
                            }
                            self?.popularInterests = Array(sliceArray)
                            self?.view.reloadCollectionView()
                        }
                    }
        }
    }
    
    /// Проверка совпадения интересов пользователя с общим списком интересов
    func selectRows() {
        
        for element in userInterests {
            guard let index = popularInterests?.firstIndex(where: { $0.id == element.id }) else { return }
            view.setSelected(index: index)
        }
        
    }
    
    /// Установка названия в ячейку коллекции
    /// - Parameter index: индекс ячейки
    func getInterestTitle(index: Int) -> String? {
        return popularInterests?[index].name
    }
    
    /// Подсчет количества ячеек коллекции
    func getInterestsCount() -> Int? {
        return popularInterests?.count
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
    }
    
    /// Добавление интереса в массив интересов пользователя, при выделении ячейки коллекции
    /// - Parameter index: индекс ячейки
    func addInterest(index: Int) {
        guard let interest = popularInterests?[index] else { return }
        userInterests.append(interest)
    }
    
    /// Удаление интереса из массива интересов пользователя, при отмене выделения ячейки коллекции
    /// - Parameter index: индекс ячейки
    func deleteInterest(index: Int) {
        guard let removingInterest = popularInterests?[index] else { return }
        guard let removeIndex = userInterests.firstIndex(where: { $0.id == removingInterest.id }) else { return }
        userInterests.remove(at: removeIndex)
    }
    
    /// Заполнение массива интересов пользователя из формы списка интересов
    /// - Parameter interests: массив интересов
    func setInterests(interests: [ListOfInterests]) {
        self.userInterests = interests
        view.reloadCollectionView()
    }
    
    // MARK: - Private methods
    /// Загрузка массива всех интересов по одной специализации пользователя с сервера
    /// - Parameters:
    ///   - mainSpec: основная специализация пользователя
    private func getInterestsOneSpec(mainSpec: String) {
        let getListOfInterest = Profile()
        
        getData(typeOfContent: .getListOfInterestsExtOne,
                returning: ([String: [ListOfInterests]], [Int]?, Int?, String?).self,
                requestParams: ["spec_code": "\(mainSpec)"] ) { [weak self] result in
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
                returning: ([String: [ListOfInterests]], [Int]?, Int?, String?).self,
                requestParams: ["spec_code": "\(mainSpec)/\(addSpec)"] ) { [weak self] result in
                    let dispathGroup = DispatchGroup()
                    
                    getListOfInterest.listOfInterests = result?.0
                    
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async { [weak self]  in
                            let generalSpec: [ListOfInterests]? = getListOfInterest.listOfInterests?["general"]
                            let mainSpec: [ListOfInterests]? = getListOfInterest.listOfInterests?["\(mainSpec)"]
                            let addSpec: [ListOfInterests]? = getListOfInterest.listOfInterests?["\(addSpec)"]
                            self?.arrayOfAllInterests = (mainSpec ?? []) + (addSpec ?? []) + (generalSpec ?? [])
                            self?.view.reloadCollectionView()
                        }
                    }
        }
    }
    
    /// Загрузка информации о пользователе с сервера
    func getUser() {
        let getDataProfile = Profile()
        
        getData(typeOfContent: .getDataFromProfile,
                returning: ([String: [AnyObject]], Int?, String?).self,
                requestParams: [:] ) { [weak self] result in
                    let dispathGroup = DispatchGroup()
                    
                    getDataProfile.dataFromProfile = result?.0
                    
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async { [weak self]  in
                            print("getDataProfile = \(String(describing: getDataProfile.dataFromProfile))")
                            let specArr: [ProfileKeySpec] = getDataProfile.dataFromProfile?["spec"] as! [ProfileKeySpec]
                            self?.loadPopularInterests(specArr[0].code)
                            switch specArr.count {
                            case 0:
                                self?.view.showAlert(message: "Ошибка! Не заполнена основная специализация!")
                            case 1:
                                self?.getInterestsOneSpec(mainSpec: specArr[0].code ?? "general")
                            default:
                                self?.getInterestsTwoSpec(mainSpec: specArr[0].code ?? "general",
                                                          addSpec: specArr[1].code ?? "040100")
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
                requestParams: ["json": updateProfile.jsonData as Any]) { [weak self] result in
                    let dispathGroup = DispatchGroup()
                    
                    updateProfile.responce = result
                    
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async { [weak self]  in
                            print("updateInterests = \(String(describing: updateProfile.responce))")
                            guard let code = updateProfile.responce?.0 else { return }
                            if responceCode(code: code) {
                                guard let controllers = self?.view.navigationController?.viewControllers else {
                                    self?.back()
                                    return
                                }
                                for viewControllers in controllers where viewControllers is ProfileViewController {
                                    self?.view.navigationController?.popToViewController(viewControllers,
                                                                                         animated: true)
                                }
                            } else {
                                self?.view.showAlert(message: updateProfile.responce?.1)
                            }
                        }
                    }
        }
    }
    
    // MARK: - Coordinator
    /// Переход к предыдущему экрану
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
    /// Переход к следующему экрану
    func next() {
        
        if isEdit {
            updateInterests()
        } else {
            let viewController = CreateProfileImageViewController()
            let presenter = CreateProfileImagePresenter(view: viewController)
            viewController.presenter = presenter
            presenter.user = user
            presenter.jobArray = jobArray
            presenter.specArray = specArray
            presenter.userInterests = userInterests
            view.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
    
    /// Переход к экрану всех интересов
    func toAddInterest() {
        let viewController = InterestsViewController()
        let presenter = InterestsPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.user = user
        presenter.jobArray = jobArray
        presenter.specArray = specArray
        presenter.arrayInterests = arrayOfAllInterests
        presenter.userInterests = userInterests
        presenter.filteredArray = arrayOfAllInterests ?? []
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
