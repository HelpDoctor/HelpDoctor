//
//  EditProfilePresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 03.05.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol EditProfilePresenterProtocol: Presenter {
    init(view: EditProfileViewController)
    func toChangeName()
    func toChangeContacts()
    func toChangeEducation()
    func toChangeJob()
    func toChangeInterest()
    func toChangePhoto()
}

class EditProfilePresenter: EditProfilePresenterProtocol {
    
    var view: EditProfileViewController
    
    required init(view: EditProfileViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
    func toChangeName() {
        let viewController = CreateProfileNameViewController()
        let presenter = CreateProfileNamePresenter(view: viewController)
        viewController.presenter = presenter
        presenter.isEdit = true
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func toChangeContacts() {
        let viewController = CreateProfileScreen2ViewController()
        let presenter = CreateProfileScreen2Presenter(view: viewController)
        viewController.presenter = presenter
        presenter.isEdit = true
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func toChangeEducation() {
        let viewController = CreateProfileStep6ViewController()
        let presenter = CreateProfileStep6Presenter(view: viewController)
        viewController.presenter = presenter
        presenter.isEdit = true
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func toChangeJob() {
        let viewController = CreateProfileWorkViewController()
        let presenter = CreateProfileWorkPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.isEdit = true
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func toChangeInterest() {
        let viewController = CreateProfileSpecViewController()
        let presenter = CreateProfileSpecPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.isEdit = true
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func toChangePhoto() {
        let viewController = CreateProfileImageViewController()
        let presenter = CreateProfileImagePresenter(view: viewController)
        viewController.presenter = presenter
        presenter.isEdit = true
        view.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Presenter
extension EditProfilePresenter {
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
