//
//  CreateProfileNamePresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 31.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol CreateProfileNamePresenterProtocol: Presenter, PickerFieldDelegate {
    init(view: CreateProfileNameViewController)
    var isEdit: Bool { get }
    func setGender(_ gender: String)
    func next(name: String, lastname: String, middleName: String)
}

class CreateProfileNamePresenter: CreateProfileNamePresenterProtocol {
    
    // MARK: - Dependency
    let view: CreateProfileNameViewController
    private let networkManager = NetworkManager()
    
    // MARK: - Constants and variables
    var user: User?
    var gender: String?
    var isEdit = false
    
    // MARK: - Init
    required init(view: CreateProfileNameViewController) {
        self.view = view
    }
    
    // MARK: - Private methods
    /// Обновление информации о пользователе на сервере
    private func updateProfile(name: String, lastname: String, middlename: String) {
        view.startActivityIndicator()
        let editedUser = User(firstName: name,
                              lastName: lastname,
                              middleName: middlename,
                              gender: gender,
                              phoneNumber: Session.instance.user?.phoneNumber,
                              birthday: Session.instance.user?.birthday,
                              cityId: Session.instance.user?.cityId,
                              foto: Session.instance.user?.foto,
                              isMedicWorker: Session.instance.user?.isMedicWorker)
        networkManager.updateUser(editedUser, nil, nil, nil) { [weak self] result in
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
    }
    
    // MARK: - Public methods
    /// Установка пола пользователя
    /// - Parameter gender: пол пользователя
    func setGender(_ gender: String) {
        self.gender = gender
    }
    
    // MARK: - Coordinator
    /// Проверка заполнения полей и переход к следующему экрану
    /// - Parameters:
    ///   - name: имя
    ///   - lastname: фамилия
    ///   - middleName: отчество
    func next(name: String, lastname: String, middleName: String) {
        if lastname == "" {
            view.showAlert(message: "Не заполнена фамилия")
            return
        } else if name == "" {
            view.showAlert(message: "Не заполнено имя")
            return
        } else if gender == nil {
            view.showAlert(message: "Не указан пол")
            return
        }
        user = User(firstName: name,
                    lastName: lastname,
                    middleName: middleName,
                    gender: gender,
                    phoneNumber: nil,
                    birthday: nil,
                    cityId: nil,
                    foto: nil,
                    isMedicWorker: nil)
        if isEdit {
            updateProfile(name: name, lastname: lastname, middlename: middleName)
        } else {
            let viewController = CreateProfileScreen2ViewController()
            let presenter = CreateProfileScreen2Presenter(view: viewController)
            viewController.presenter = presenter
            presenter.user = user
            view.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    /// Переход к предыдущему экрану
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
