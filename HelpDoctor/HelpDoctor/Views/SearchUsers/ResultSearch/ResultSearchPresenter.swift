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
    func newSearch()
    func nextPage()
    func getCountContacts() -> Int
    func getCountAllContacts() -> Int
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
    var searchString: String?
    var searchQuery: SearchQuery?
    private let limit = 20
    private var currentPage = 1
    private var hasNextPage = true
    
    // MARK: - Init
    required init(view: ResultSearchViewController) {
        self.view = view
    }
    
    func newSearch() {
        usersList.removeAll()
        usersCount = 1
        hasNextPage = true
        currentPage = 1
        searchQuery = nil
        searchString = ""
        nextPage()
    }
    
    func nextPage() {
        if usersCount == usersList.count {
            hasNextPage = false
        }
        if searchString != nil && hasNextPage {
            currentPage += 1
            searchUsers(searchString ?? "")
        }
        guard let searchQuery = searchQuery else { return }
        if hasNextPage {
            currentPage += 1
            searchUsers(searchQuery)
        }
    }
    
    private func searchUsers(_ query: String) {
        view.startActivityIndicator()
        NetworkManager.shared.searchUsers(query, limit, currentPage) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success:
                    do {
                        self.usersList += try result.get().users
                        self.usersCount = try result.get().count
                        self.searchString = query
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
    
    private func searchUsers(_ query: SearchQuery) {
        view.startActivityIndicator()
        NetworkManager.shared.searchUsers(query, limit, currentPage) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success:
                    do {
                        self.usersList += try result.get().users
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
    
    func getCountContacts() -> Int {
        return usersList.count
    }
    
    func getCountAllContacts() -> Int {
        return usersCount
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
}

// MARK: - Presenter
extension ResultSearchPresenter {
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
    func toProfile() {
        if Session.instance.userCheck {
            let viewController = ProfileViewController()
            viewController.presenter = ProfilePresenter(view: viewController)
            view.navigationController?.pushViewController(viewController, animated: true)
        } else {
            let viewController = CreateProfileNameViewController()
            viewController.presenter = CreateProfileNamePresenter(view: viewController)
            view.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
