//
//  ResultSearchPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 26.11.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol ResultSearchPresenterProtocol: Presenter {
    init(view: ResultSearchViewController)
    func getCountContacts() -> Int
    func getContact(index: Int) -> Contacts?
    func toFilter()
    func searchUsers(_ query: String, _ limit: Int, _ page: Int)
}

class ResultSearchPresenter: ResultSearchPresenterProtocol {

    // MARK: - Dependency
    let view: ResultSearchViewController
    
    // MARK: - Constants and variables
    var usersList: [Contacts] = []
    var usersCount = 0
    
    // MARK: - Init
    required init(view: ResultSearchViewController) {
        self.view = view
    }
    
    func getCountContacts() -> Int {
        return usersList.count
    }
    
    func getContact(index: Int) -> Contacts? {
        return usersList[index]
    }
    
    func toFilter() {
        let viewController = FilterSearchViewController()
        let presenter = FilterSearchPresenter(view: viewController)
        viewController.presenter = presenter
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func searchUsers(_ query: String,
                     _ limit: Int = 0,
                     _ page: Int = 1) {
        view.startActivityIndicator()
        NetworkManager.shared.searchUsers(query, limit, page) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.usersList.removeAll()
                    do {
                        self.usersList = try result.get().users
                        self.usersCount = try result.get().count
                    } catch {
                        return
                    }
                    self.view.reloadTableView()
                case .failure(let error):
                    self.view.showAlert(message: error.description)
                }
                self.view.stopActivityIndicator()
            }
        }
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
}
