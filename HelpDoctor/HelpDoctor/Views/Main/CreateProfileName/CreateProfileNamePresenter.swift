//
//  CreateProfileNamePresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 31.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol CreateProfileNamePresenterProtocol {
    init(view: CreateProfileNameViewController)
    func next(name: String, lastname: String, middleName: String, birthDate: String, phone: String)
}

class CreateProfileNamePresenter: CreateProfileNamePresenterProtocol {
    
    var view: CreateProfileNameViewController
    var user: UpdateProfileKeyUser?
    
    required init(view: CreateProfileNameViewController) {
        self.view = view
    }
    
    // MARK: - Coordinator
    func next(name: String, lastname: String, middleName: String, birthDate: String, phone: String) {
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
                                    phone_number: phone,
                                    birthday: strBirthday,
                                    city_id: nil,
                                    foto: nil)
        let viewController = CreateProfileWorkViewController()
        let presenter = CreateProfileWorkPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.user = user
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
