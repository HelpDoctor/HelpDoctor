//
//  InterestsPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 03.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol InterestsPresenterProtocol: Presenter {
    init(view: InterestsViewController)
    func getCountInterests() -> Int?
    func getInterestsTitle(index: Int) -> String?
    func appendIndexArray(index: Int)
    func removeIndexArray(index: Int)
    func selectRows()
    func searchTextIsEmpty()
    func filter(searchText: String)
    func createInterest(interest: String?)
}

class InterestsPresenter: InterestsPresenterProtocol {
    
    var view: InterestsViewController
    var arrayInterests: [ListOfInterests]?
    var userInterests: [ListOfInterests] = []
    var filteredArray: [ListOfInterests] = []
    
    required init(view: InterestsViewController) {
        self.view = view
    }
    
    /// Проверка совпадения интересов пользователя с общим списком интересов
    func selectRows() {
        for element in userInterests {
            guard let index = arrayInterests?.firstIndex(where: { $0.id == element.id }) else { return }
            view.setSelected(index: index)
        }
        
        for value in userInterests {
            guard let index = filteredArray.firstIndex(where: { $0.id == value.id }) else { continue }
            view.setSelected(index: index)
        }
    }
    
    /// Возврат количества строк
    func getCountInterests() -> Int? {
        return filteredArray.count
    }
    
    /// Возврат наименования интереса
    /// - Parameter index: индекс строки
    func getInterestsTitle(index: Int) -> String? {
        return filteredArray[index].name
    }
    
    /// Добавление интереса в массив интересов пользователя
    /// - Parameter index: индекс строки
    func appendIndexArray(index: Int) {
        userInterests.append(filteredArray[index])
    }
    
    /// Удаление интереса из массива интересов пользователя
    /// - Parameter index: индекс строки
    func removeIndexArray(index: Int) {
        let removingInterest = filteredArray[index]
        guard let removeIndex = userInterests.firstIndex(where: { $0.id == removingInterest.id }) else { return }
        userInterests.remove(at: removeIndex)
    }
    
    /// Запись в фильтрованный массив интересов полного массива интересов при обнулении строки поиска
    func searchTextIsEmpty() {
        filteredArray = arrayInterests ?? []
        view.reloadTableView()
        selectRows()
    }
    
    /// Фильтрация массива интересов
    /// - Parameter searchText: строка поиска
    func filter(searchText: String) {
        guard let arrayInterests = arrayInterests else { return }
        filteredArray = arrayInterests.filter({ interest -> Bool in
            return (interest.name?.lowercased().contains(searchText.lowercased()) ?? false)
        })
        view.reloadTableView()
        selectRows()
    }
    
    /// Добавление нового интереса
    /// - Parameter interest: новый интерес из поля ввода
    func createInterest(interest: String?) {
        guard let interest = interest else {
            view.showAlert(message: "Заполните поле интереса")
            return
        }
        view.startActivityIndicator()
        let addInterest = Profile()
        getData(typeOfContent: .addProfileInterest,
                returning: ([ListOfInterests], Int?, String?).self,
                requestParams: ["interest": interest]) { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            addInterest.addInterests = result?.0
            addInterest.responce = (result?.1, result?.2)
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    print("addInterestResponce = \(String(describing: addInterest.responce))")
                    print("addInterest \(String(describing: addInterest.addInterests))")
                    guard let code = addInterest.responce?.0 else { return }
                    if responceCode(code: code) {
                        self?.callback(interests: addInterest.addInterests ?? [])
                    } else {
                        self?.view.showAlert(message: addInterest.responce?.1)
                    }
                    self?.view.stopActivityIndicator()
                }
            }
        }
    }
    
    /// Добавление вновь созданного интереса в массив интересов пользователя и обновление таблицы
    /// - Parameter interests: массив интересов с сервера
    func callback(interests: [ListOfInterests]) {
        interests.forEach {
            userInterests.append($0.self)
            arrayInterests?.append($0.self)
        }
        view.reloadTableView()
    }
    
    // MARK: - Presenter
    func back() {
        view.navigationController?.popViewController(animated: true)
        let prevVC = view.navigationController?.viewControllers.last
        if prevVC is CreateProfileSpecViewController {
            let previous = view.navigationController?.viewControllers.last as! CreateProfileSpecViewController
//            let presenter = previous.presenter
//            presenter?.setInterests(interests: userInterests)
        } 
    }
    
}
