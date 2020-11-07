//
//  SearchUsersPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 23.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol SearchUsersPresenterProtocol: Presenter {
    init(view: SearchUsersViewController)
    func findUsers()
}

class SearchUsersPresenter: SearchUsersPresenterProtocol {

    // MARK: - Dependency
    let view: SearchUsersViewController
    
    // MARK: - Constants and variables
    
    
    // MARK: - Init
    required init(view: SearchUsersViewController) {
        self.view = view
    }
    
    func findUsers() {
//        let user = User(firstName: "",
//                        lastName: "",
//                        middleName: "",
//                        gender: "",
//                        phoneNumber: "",
//                        birthday: "",
//                        cityId: nil,
//                        foto: "",
//                        isMedicWorker: nil)
//        let query = Profiles(user: user, educations: [], job: [], specializations: [], interests: [])
//        networkManager.findUsers(query) { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let profiles):
//                    print(profiles)
//                case .failure(let error):
//                    self?.view.showAlert(message: error.description)
//                }
//            }
//        }
        toResult()
    }
    
    func toResult() {
        let viewController = SearchResultViewController()
        let presenter = SearchResultPresenter(view: viewController)
        viewController.presenter = presenter
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
