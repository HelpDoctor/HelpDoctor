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
    
    func setGender(_ gender: String) {
        self.gender = gender
    }
    
    // MARK: - Coordinator
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
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
    func save(source: SourceEditTextField) { }
    
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
