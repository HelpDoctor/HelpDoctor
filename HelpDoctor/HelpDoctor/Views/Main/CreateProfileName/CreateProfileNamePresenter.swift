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
    func setGender(_ gender: String)
    func next(name: String, lastname: String, middleName: String)
}

class CreateProfileNamePresenter: CreateProfileNamePresenterProtocol {
    
    // MARK: - Dependency
    let view: CreateProfileNameViewController
    
    // MARK: - Constants and variables
    var user: UpdateProfileKeyUser?
    var gender: String?
    
    // MARK: - Init
    required init(view: CreateProfileNameViewController) {
        self.view = view
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
        user = UpdateProfileKeyUser(first_name: name,
                                    last_name: lastname,
                                    middle_name: middleName,
                                    phone_number: nil,
                                    birthday: nil,
                                    city_id: nil,
                                    foto: nil,
                                    gender: gender,
                                    is_medic_worker: nil)
        let viewController = CreateProfileScreen2ViewController()
        let presenter = CreateProfileScreen2Presenter(view: viewController)
        viewController.presenter = presenter
        presenter.user = user
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /// Переход к предыдущему экрану
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
