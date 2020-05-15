//
//  CreateProfileStep6Presenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.04.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol CreateProfileStep6PresenterProtocol: Presenter, PickerFieldDelegate {
    init(view: CreateProfileStep6ViewController)
    var isEdit: Bool { get }
    func convertDate(_ birthDate: String) -> String?
    func next()
}

class CreateProfileStep6Presenter: CreateProfileStep6PresenterProtocol {
    
    // MARK: - Dependency
    let view: CreateProfileStep6ViewController
    
    // MARK: - Constants and variables
    var user: UpdateProfileKeyUser?
    var isEdit = false
    var region: Regions?
//    private var city: Cities?
    
    // MARK: - Init
    required init(view: CreateProfileStep6ViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
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
    func next() {
        
        if isEdit {
            print("Пока нет методов обновления информации об образовании")
            guard let controllers = self.view.navigationController?.viewControllers else {
                self.back()
                return
            }
            for viewControllers in controllers where viewControllers is ProfileViewController {
                self.view.navigationController?.popToViewController(viewControllers, animated: true)
            }
        } else {
            let viewController = CreateProfileWorkViewController()
            let presenter = CreateProfileWorkPresenter(view: viewController)
            viewController.presenter = presenter
            presenter.user = user
            presenter.region = region
            view.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - PickerFieldDelegate
extension CreateProfileStep6Presenter {
    
    func pickerField(didOKClick pickerField: PickerField) {
        if pickerField.type == .datePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            guard let datePicker = pickerField.datePicker else { return }
            let date = dateFormatter.string(from: datePicker.date)
            pickerField.text =  "\(date)"
        }
        
    }
    
}
