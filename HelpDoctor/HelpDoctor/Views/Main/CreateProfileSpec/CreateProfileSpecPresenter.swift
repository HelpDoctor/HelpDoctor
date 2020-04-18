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
    func loadPopularInterests()
    func selectRows()
    func getInterestTitle(index: Int) -> String?
    func getInterestsCount() -> Int?
    func getInterestFromView()
    func addInterest(index: Int)
    func deleteInterest(index: Int)
    func setInterests(interests: [ListOfInterests])
    func next()
    func toAddInterest()
}

class CreateProfileSpecPresenter: CreateProfileSpecPresenterProtocol {
    
    // MARK: - Dependency
    let view: CreateProfileSpecViewController
    
    // MARK: - Constants and variables
    var user: UpdateProfileKeyUser?
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
    func loadPopularInterests() {
        var mainSpec = "general"
        if specArray.count != 0 {
            mainSpec = specArray[0]?.code ?? "general"
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
    
    // MARK: - Coordinator
    /// Переход к предыдущему экрану
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
    /// Переход к следующему экрану
    func next() {
        let viewController = CreateProfileImageViewController()
        let presenter = CreateProfileImagePresenter(view: viewController)
        viewController.presenter = presenter
        presenter.user = user
        presenter.jobArray = jobArray
        presenter.specArray = specArray
        presenter.userInterests = userInterests
        view.navigationController?.pushViewController(viewController, animated: true)
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
