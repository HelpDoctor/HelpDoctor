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
    func setInterests(interests: [ProfileInterest])
    func next()
    func toAddInterest()
    func getUser()
}

class CreateProfileSpecPresenter: CreateProfileSpecPresenterProtocol {
    
    // MARK: - Dependency
    let view: CreateProfileSpecViewController
    private let networkManager = NetworkManager()
    
    // MARK: - Constants and variables
    var user: User?
    var isEdit = false
    var jobArray: [Job] = []
    var specArray: [Specialization] = []
    var userInterests: [ProfileInterest] = []
    var arrayOfAllInterests: [ProfileInterest] = []
    var popularInterests: [ProfileInterest]?
    
    // MARK: - Init
    required init(view: CreateProfileSpecViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    /// Загрузка с сервера первых 10 интересов по основной специализации
    func loadPopularInterests(_ spec: String?) {
//        view.startActivityIndicator()
        //TODO: - Fix
        /*
         var mainSpec = "general"
         if specArray.count != 0 {
         mainSpec = specArray[0].specialization?.code ?? "general"
         }
         if spec != nil {
         mainSpec = spec ?? "general"
         }
         let getListOfInterest = Profile()
         
         getData(typeOfContent: .getListOfInterestsExtOne,
         returning: ([String: [Interest]], [Int]?, Int?, String?).self,
         requestParams: ["spec_code": "\(mainSpec)"] ) { [weak self] result in
         let dispathGroup = DispatchGroup()
         
         getListOfInterest.listOfInterests = result?.0
         
         dispathGroup.notify(queue: DispatchQueue.main) {
         DispatchQueue.main.async { [weak self]  in
         let interestMainSpec: [Interest]? = getListOfInterest.listOfInterests?["\(mainSpec)"]
         let idRelevantInterests = result?.1 ?? []
         var sliceArray: [Interest] = []
         for id in idRelevantInterests {
         sliceArray += interestMainSpec?.filter { $0.id == id } ?? []
         }
         self?.popularInterests = Array(sliceArray)
         self?.view.reloadCollectionView()
         self?.view.stopActivityIndicator()
         }
         }
         }
         */
        //        networkManager.getListOfInterests(specArray[0]?.code,
        //                                          specArray[1]?.code) { listOfInterests, error in
        //                                            if let error = error {
        //                                                self.view.showAlert(message: error)
        //                                            }
        //                                            if let listOfInterests = listOfInterests {
        //                                                print("listOfInterests: \(listOfInterests)")
        //                                            }
        //        }
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
        return popularInterests?[index].interest?.name
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
        default:
            var isFirst = true
            specArray.forEach { medicalSpecialization in
                getInterests(mainSpec: medicalSpecialization.specialization?.code ?? "general", isFirst: isFirst)
                isFirst = false
            }
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
    func setInterests(interests: [ProfileInterest]) {
        self.userInterests = interests
        view.reloadCollectionView()
    }
    
    // MARK: - Private methods
    /// Загрузка массива всех интересов по одной специализации пользователя с сервера
    /// - Parameters:
    ///   - mainSpec: основная специализация пользователя
    private func getInterests(mainSpec: String, isFirst: Bool) {
        //TODO: - Fix
        /*
         let getListOfInterest = Profile()
         getData(typeOfContent: .getListOfInterestsExtOne,
         returning: ([String: [Interest]], [Int]?, Int?, String?).self,
         requestParams: ["spec_code": "\(mainSpec)"] ) { [weak self] result in
         let dispathGroup = DispatchGroup()
         
         getListOfInterest.listOfInterests = result?.0
         
         dispathGroup.notify(queue: DispatchQueue.main) {
         DispatchQueue.main.async { [weak self]  in
         if isFirst {
         let generalSpec: [Interest]? = getListOfInterest.listOfInterests?["general"]
         //TODO: - Fix
         //                                self?.arrayOfAllInterests += generalSpec ?? []
         }
         let interestMainSpec: [Interest]? = getListOfInterest.listOfInterests?["\(mainSpec)"]
         //TODO: - Fix
         //                            self?.arrayOfAllInterests += interestMainSpec ?? []
         self?.view.reloadCollectionView()
         }
         }
         }
         */
    }
    
    /// Загрузка информации о пользователе с сервера
    func getUser() {
        networkManager.getUser { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profiles):
                    let specArr = profiles.specializations
                    self?.loadPopularInterests(specArr[0].specialization?.code)
                    switch specArr.count {
                    case 0:
                        self?.view.showAlert(message: "Ошибка! Не заполнена основная специализация!")
                    default:
                        var isFirst = true
                        specArr.forEach { medicalSpecialization in
                            self?.getInterests(mainSpec: medicalSpecialization.specialization?.code ?? "general",
                                               isFirst: isFirst)
                            isFirst = false
                        }
                    }
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
            }
        }
    }
    
    /// Обновление информации о интересах пользователя на сервере
    private func updateInterests() {
        networkManager.updateUser(nil, nil, nil, userInterests) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    guard let controllers = self?.view.navigationController?.viewControllers else {
                        self?.back()
                        return
                    }
                    for viewControllers in controllers where viewControllers is ProfileViewController {
                        self?.view.navigationController?.popToViewController(viewControllers,
                                                                             animated: true)
                    }
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
                self?.view.stopActivityIndicator()
            }
        }
        //        var intArray: [Int] = []
        //        for i in 0 ..< userInterests.count {
        //            intArray.append(userInterests[i].id)
        //        }
        //
        //        let updateProfile = UpdateProfileKeyInterest(arrayInterest: intArray)
        //
        //        getData(typeOfContent: .updateProfile,
        //                returning: (Int?, String?).self,
        //                requestParams: ["json": updateProfile.jsonData as Any]) { [weak self] result in
        //                    let dispathGroup = DispatchGroup()
        //
        //                    updateProfile.responce = result
        //
        //                    dispathGroup.notify(queue: DispatchQueue.main) {
        //                        DispatchQueue.main.async { [weak self]  in
        //                            print("updateInterests = \(String(describing: updateProfile.responce))")
        //                            guard let code = updateProfile.responce?.0 else { return }
        //                            if responceCode(code: code) {
        //                                guard let controllers = self?.view.navigationController?.viewControllers else {
        //                                    self?.back()
        //                                    return
        //                                }
        //                                for viewControllers in controllers where viewControllers is ProfileViewController {
        //                                    self?.view.navigationController?.popToViewController(viewControllers,
        //                                                                                         animated: true)
        //                                }
        //                            } else {
        //                                self?.view.showAlert(message: updateProfile.responce?.1)
        //                            }
        //                        }
        //                    }
        //        }
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
        presenter.filteredArray = arrayOfAllInterests
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
