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
    func convertDate(_ birthDate: String) -> String?
    func next(name: String, lastname: String, middleName: String, birthDate: String)
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
    
    /// Конвертация даты из формата yyy-MM-dd в формат dd.MM.yyyy
    /// - Parameter birthDate: дата в формте yyy-MM-dd
    /// - Returns: дата в формате dd.MM.yyyy
    func convertDate(_ birthDate: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale.current
        guard let birthday = dateFormatter.date(from: birthDate) else { return nil }
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: birthday)
    }
    
    // MARK: - Coordinator
    /// Проверка заполнения полей и переход к следующему экрану
    /// - Parameters:
    ///   - name: имя
    ///   - lastname: фамилия
    ///   - middleName: отчество
    ///   - birthDate: дата рождения
    func next(name: String, lastname: String, middleName: String, birthDate: String) {
        if lastname == "" {
            view.showAlert(message: "Не заполнена фамилия")
            return
        } else if name == "" {
            view.showAlert(message: "Не заполнено имя")
            return
        } else if birthDate == "" {
            view.showAlert(message: "Не заполнена дата рождения")
            return
        } else if gender == nil {
            view.showAlert(message: "Не указан пол")
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale.current
        guard let birthday = dateFormatter.date(from: birthDate) else {
            view.showAlert(message: "Не правильно указана дата рождения")
            return
        }
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strBirthday = dateFormatter.string(from: birthday)
        user = UpdateProfileKeyUser(first_name: name,
                                    last_name: lastname,
                                    middle_name: middleName,
                                    phone_number: nil,
                                    birthday: strBirthday,
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

// MARK: - PickerFieldDelegate
extension CreateProfileNamePresenter {
    
    func pickerField(didOKClick pickerField: PickerField) {
        if pickerField.type == .datePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            guard let datePicker = pickerField.datePicker else { return }
            let date = dateFormatter.string(from: datePicker.date)
            pickerField.text =  "\(date)"
        }

    }
    
}
