//
//  StartMainPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 31.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol StartMainPresenterProtocol: Presenter {
    init(view: StartMainViewController)
    func profileCheck()
    func fillProfile()
    func toProfile()
    func toContacts()
    func toSearchContacts()
}

class StartMainPresenter: StartMainPresenterProtocol {
    
    // MARK: - Dependency
    let view: StartMainViewController
    private let networkManager = NetworkManager()
    
    // MARK: - Constants and variables
    private let session = Session.instance
    
    // MARK: - Init
    required init(view: StartMainViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    /// Производит проверку заполнения всех необходимых полей пользователя
    func profileCheck() {
        view.startActivityIndicator()
        getUser()
        networkManager.checkProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let status):
                    if status {
                        self?.view.hideFillProfileButton()
                        self?.getStatusUser()
                    } else {
                        self?.view.showFillProfileButton()
                    }
                case .failure:
                    AppDelegate.shared.rootViewController.switchToLogout()
                }
                self?.view.stopActivityIndicator()
            }
        }
    }
    
    // MARK: - Private methods
    private func getStatusUser() {
        networkManager.getUserStatus { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let networkResponse):
                    let status = networkResponse.status
                    switch status {
                    case "denied":
                        UserDefaults.standard.set("denied", forKey: "userStatus")
                        self?.toErrorVerification(networkResponse.message)
                    case "not_verification":
                        UserDefaults.standard.set("not_verification", forKey: "userStatus")
                        self?.toVerification()
                    case "processing":
                        UserDefaults.standard.set("processing", forKey: "userStatus")
                        self?.toEndVerification()
                    case "verified":
                        if UserDefaults.standard.string(forKey: "userStatus") != "verified" {
                            self?.toOkVerification()
                        }
                        UserDefaults.standard.set("verified", forKey: "userStatus")
                    default:
                        break
                    }
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
            }
        }
    }
    
    private func getUser() {
        networkManager.getUser { [weak self] result in
            switch result {
            case .success(let profiles):
                self?.session.user = profiles.user
                self?.session.education = profiles.educations
                self?.session.userJob = profiles.job
                self?.session.specialization = profiles.specializations
            case .failure(let error):
                self?.view.showAlert(message: error.description)
            }
        }
    }
    
    /// Переход на первый экран заполнения профиля
    func fillProfile() {
        let viewController = CreateProfileNameViewController()
        viewController.presenter = CreateProfileNamePresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /// Переход на экран профиля
    func toProfile() {
        let viewController = ProfileViewController()
        viewController.presenter = ProfilePresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func toVerification() {
        let viewController = VerificationViewController()
        viewController.presenter = VerificationPresenter(view: viewController)
        view.present(viewController, animated: true, completion: nil)
    }
    
    func toEndVerification() {
        let viewController = VerificationEndViewController()
        viewController.presenter = VerificationEndPresenter(view: viewController)
        view.present(viewController, animated: true, completion: nil)
    }
    
    func toErrorVerification(_ message: String?) {
        let viewController = VerificationErrorViewController()
        viewController.presenter = VerificationErrorPresenter(view: viewController)
        viewController.messageFromServer = message
        view.present(viewController, animated: true, completion: nil)
    }
    
    func toOkVerification() {
        let viewController = VerificationOkViewController()
        viewController.presenter = VerificationOkPresenter(view: viewController)
        view.present(viewController, animated: true, completion: nil)
    }
    
    func toContacts() {
        let viewController = ContactsViewController()
        viewController.presenter = ContactsPresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func toSearchContacts() {
        let viewController = StartSearchUserViewController()
        viewController.presenter = StartSearchUserPresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
