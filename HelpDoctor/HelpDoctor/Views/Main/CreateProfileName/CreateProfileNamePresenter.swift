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
    
    // MARK: - Constants and variables
    var user: UpdateProfileKeyUser?
    var gender: String?
    var isEdit = false
    
    // MARK: - Init
    required init(view: CreateProfileNameViewController) {
        self.view = view
    }
    
    // MARK: - Private methods
    /// Обновление информации о пользователе на сервере
    private func updateProfile(user: UpdateProfileKeyUser) {
        view.startActivityIndicator()
//        let updateProfile = UpdateProfileKeyUser(first_name: user.first_name,
//                                                 last_name: user.last_name,
//                                                 middle_name: user.middle_name,
//                                                 phone_number: Session.instance.user?.phone_number,
//                                                 birthday: Session.instance.user?.birthday,
//                                                 city_id: Session.instance.user?.city_id,
//                                                 foto: Session.instance.user?.foto,
//                                                 gender: user.gender,
//                                                 is_medic_worker: Session.instance.user?.is_medic_worker)
        let updateProfile = UpdateProfileKeyUser(first_name: user.first_name,
                                                 last_name: user.last_name,
                                                 middle_name: user.middle_name,
                                                 phone_number: Session.instance.user?.phoneNumber,
                                                 birthday: Session.instance.user?.birthday,
                                                 city_id: Session.instance.user?.cityId,
                                                 foto: Session.instance.user?.foto,
                                                 gender: user.gender,
                                                 is_medic_worker: Session.instance.user?.isMedicWorker)
        getData(typeOfContent: .updateProfile,
                returning: (Int?, String?).self,
                requestParams: ["json": updateProfile.jsonData as Any] ) { [weak self] result in
                    let dispathGroup = DispatchGroup()
                    updateProfile.responce = result
                    
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async { [weak self]  in
                            print("updateProfile = \(String(describing: updateProfile.responce))")
                            self?.view.stopActivityIndicator()
                            guard let code = updateProfile.responce?.0 else { return }
                            if responceCode(code: code) {
                                guard let controllers = self?.view.navigationController?.viewControllers else {
                                    self?.back()
                                    return
                                }
                                for viewControllers in controllers where viewControllers is ProfileViewController {
                                    self?.view.navigationController?.popToViewController(viewControllers,
                                                                                         animated: true)
                                }
                            } else {
                                self?.view.showAlert(message: updateProfile.responce?.1)
                            }
                        }
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
        user = UpdateProfileKeyUser(first_name: name,
                                    last_name: lastname,
                                    middle_name: middleName,
                                    phone_number: nil,
                                    birthday: nil,
                                    city_id: nil,
                                    foto: nil,
                                    gender: gender,
                                    is_medic_worker: nil)
        
        if isEdit {
            guard let user = user else { return }
            updateProfile(user: user)
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
