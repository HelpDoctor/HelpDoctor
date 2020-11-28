//
//  StartSearchPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 25.11.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol StartSearchPresenterProtocol: Presenter {
    init(view: StartSearchViewController)
    func searchUsers(_ query: String, _ limit: Int, _ page: Int)
    func toFilter()
}

class StartSearchPresenter: StartSearchPresenterProtocol {
    
    // MARK: - Dependency
    let view: StartSearchViewController
    
    // MARK: - Constants and variables
    private let session = Session.instance
    
    // MARK: - Init
    required init(view: StartSearchViewController) {
        self.view = view
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
                    let viewController = ResultSearchViewController()
                    let presenter = ResultSearchPresenter(view: viewController)
                    viewController.presenter = presenter
                    viewController.filterParams = query
                    do {
                        presenter.usersList = try result.get().users
                        presenter.usersCount = try result.get().count
                    } catch {
                        return
                    }
                    self.view.navigationController?.pushViewController(viewController, animated: true)
                case .failure(let error):
                    self.view.showAlert(message: error.description)
                }
                self.view.stopActivityIndicator()
            }
        }
    }
    
    func toFilter() {
        let viewController = FilterSearchViewController()
        let presenter = FilterSearchPresenter(view: viewController)
        viewController.presenter = presenter
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
