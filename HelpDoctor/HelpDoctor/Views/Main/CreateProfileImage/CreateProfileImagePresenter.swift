//
//  CreateProfileImagePresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 03.04.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol CreateProfileImagePresenterProtocol: Presenter {
    init(view: CreateProfileImageViewController)
    var isEdit: Bool { get }
    func save()
    func setUser()
    func setPhoto(photoString: String?)
}

class CreateProfileImagePresenter: CreateProfileImagePresenterProtocol {
    
    // MARK: - Dependency
    let view: CreateProfileImageViewController
    private let networkManager = NetworkManager()
    
    // MARK: - Constants and variables
    var user: User?
    var isEdit = false
    var jobArray: [Job] = []
    var specArray: [Specialization] = []
    var userInterests: [ProfileInterest] = []
    
    // MARK: - Init
    required init(view: CreateProfileImageViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    /// Сохранение всей введенной информации и переход к следующему экрану
    func save() {
        view.startActivityIndicator()
        if isEdit {
            updateProfile()
        } else {
            updateUser()
        }
        
    }
    
    func setUser() {
        user = Session.instance.user
    }
    
    /// Установка фотографии в классе UpdateProfileKeyUser
    /// - Parameter photoString: фотография пользователя в строковом виде
    func setPhoto(photoString: String?) {
        user?.foto = photoString
    }
    
    // MARK: - Private methods
    /// Обновление информации о пользователе на сервере
    private func updateUser() {
        networkManager.updateUser(user, nil, nil, nil) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.updateJob()
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
                self?.view.stopActivityIndicator()
            }
        }
    }
    // TODO: - Попробовать объединить все методы обновления пользователя
    /// Обновление информации о работе пользователя на сервере
    private func updateJob() {
        if jobArray.count == 0 {
            updateSpec()
        } else {
            networkManager.updateUser(nil, jobArray, nil, nil) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self?.updateSpec()
                    case .failure(let error):
                        self?.view.showAlert(message: error.description)
                    }
                    self?.view.stopActivityIndicator()
                }
            }
        }
    }
    
    /// Обновление информации о специализации пользователя на сервере
    private func updateSpec() {
        networkManager.updateUser(nil, nil, specArray, nil) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.updateInterests()
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
                self?.view.stopActivityIndicator()
            }
        }
    }
    
    /// Обновление информации о интересах пользователя на сервере
    private func updateInterests() {
        networkManager.updateUser(nil, nil, nil, userInterests) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.next()
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
                self?.view.stopActivityIndicator()
            }
        }
        //        var intArray: [Int] = []
        //        for i in 0 ..< userInterests.count {
        //            intArray.append(userInterests[i].id)
        //        }
        //
        //        let updateProfile = UpdateProfileKeyInterest(arrayInterest: intArray)
        //
        //        getData(typeOfContent: .updateProfile,
        //                returning: (Int?, String?).self,
        //                requestParams: ["json": updateProfile.jsonData as Any]) { [weak self] result in
        //                    let dispathGroup = DispatchGroup()
        //
        //                    updateProfile.responce = result
        //
        //                    dispathGroup.notify(queue: DispatchQueue.main) {
        //                        DispatchQueue.main.async { [weak self]  in
        //                            print("updateInterests = \(String(describing: updateProfile.responce))")
        //                            self?.view.stopActivityIndicator()
        //                            guard let code = updateProfile.responce?.0 else { return }
        //                            if responceCode(code: code) {
        //                                self?.next()
        //                            } else {
        //                                self?.view.showAlert(message: updateProfile.responce?.1)
        //                            }
        //                        }
        //                    }
        //        }
    }
    
    /// Обновление информации о пользователе на сервере
    /// - Parameter profile: информация для обновления
    private func updateProfile() {
        let editedUser = User(firstName: Session.instance.user?.firstName,
                              lastName: Session.instance.user?.lastName,
                              middleName: Session.instance.user?.middleName,
                              gender: Session.instance.user?.gender,
                              phoneNumber: Session.instance.user?.phoneNumber,
                              birthday: Session.instance.user?.birthday,
                              cityId: Session.instance.user?.cityId,
                              foto: user?.foto,
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
    
    // MARK: - Coordinator
    /// Переход к предыдущему экрану
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
    /// Переход к следующему экрану
    private func next() {
        let viewController = ProfileViewController()
        viewController.presenter = ProfilePresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
