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
    
    // MARK: - Constants and variables
    var user: UpdateProfileKeyUser?
    var isEdit = false
    var jobArray: [MedicalOrganization?] = []
    var specArray: [MedicalSpecialization?] = []
    var userInterests: [ListOfInterests] = []
    
    // MARK: - Init
    required init(view: CreateProfileImageViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    /// Сохранение всей введенной информации и переход к следующему экрану
    func save() {
        
        if isEdit {
            updateProfile()
        } else {
            updateUser()
        }
        
    }
    
    func setUser() {
        user = UpdateProfileKeyUser(first_name: Session.instance.user?.first_name,
                                    last_name: Session.instance.user?.last_name,
                                    middle_name: Session.instance.user?.middle_name,
                                    phone_number: Session.instance.user?.phone_number,
                                    birthday: Session.instance.user?.birthday,
                                    city_id: Session.instance.user?.city_id,
                                    foto: Session.instance.user?.foto,
                                    gender: Session.instance.user?.gender,
                                    is_medic_worker: Session.instance.user?.is_medic_worker)
    }
    
    /// Установка фотографии в классе UpdateProfileKeyUser
    /// - Parameter photoString: фотография пользователя в строковом виде
    func setPhoto(photoString: String?) {
        user?.foto = photoString
    }
    
    // MARK: - Private methods
    /// Обновление информации о пользователе на сервере
    private func updateUser() {
        let updateProfile = UpdateProfileKeyUser(first_name: user?.first_name,
                                                 last_name: user?.last_name,
                                                 middle_name: user?.middle_name,
                                                 phone_number: user?.phone_number,
                                                 birthday: user?.birthday,
                                                 city_id: user?.city_id,
                                                 foto: user?.foto,
                                                 gender: user?.gender,
                                                 is_medic_worker: user?.is_medic_worker)
        
        getData(typeOfContent: .updateProfile,
                returning: (Int?, String?).self,
                requestParams: ["json": updateProfile.jsonData as Any] ) { [weak self] result in
                    let dispathGroup = DispatchGroup()
                    
                    updateProfile.responce = result
                    
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async { [weak self]  in
                            print("updateProfile = \(String(describing: updateProfile.responce))")
                            guard let code = updateProfile.responce?.0 else { return }
                            if responceCode(code: code) {
                                self?.updateJob()
                            } else {
                                self?.view.showAlert(message: updateProfile.responce?.1)
                            }
                        }
                    }
        }
    }
    
    /// Обновление информации о работе пользователя на сервере
    private func updateJob() {
        if jobArray.count == 0 {
            updateSpec()
        } else {
            guard let oid = jobArray[0]?.oid else { return }
            var updateJob: [[String: Any]] = []
            let job: [String: Any] = ["id": 0, "job_oid": oid, "is_main": true]
            updateJob.append(job)
            for i in 1 ..< jobArray.count {
                updateJob.append(["id": 0, "job_oid": jobArray[i]?.oid as Any, "is_main": false])
            }
            print("Update job: \(updateJob)")
            let updateProfileJob = UpdateProfileKeyJob(arrayJob: updateJob)
            getData(typeOfContent: .updateProfile,
                    returning: (Int?, String?).self,
                    requestParams: ["json": updateProfileJob.jsonData as Any]) { [weak self] result in
                        let dispathGroup = DispatchGroup()
                        
                        updateProfileJob.responce = result
                        
                        dispathGroup.notify(queue: DispatchQueue.main) {
                            DispatchQueue.main.async { [weak self]  in
                                print("updateJobProfile = \(String(describing: updateProfileJob.responce))")
                                guard let code = updateProfileJob.responce?.0 else { return }
                                if responceCode(code: code) {
                                    self?.updateSpec()
                                } else {
                                    self?.view.showAlert(message: updateProfileJob.responce?.1)
                                }
                            }
                        }
            }
        }
    }
    
    /// Обновление информации о специализации пользователя на сервере
    private func updateSpec() {
        guard let specId = specArray[0]?.id else { return }
        var updateSpec: [[String: Any]] = []
        let spec: [String: Any] = ["id": 0, "spec_id": specId as Any, "is_main": true]
        updateSpec.append(spec)
        for i in 1 ..< specArray.count {
            updateSpec.append(["id": 0, "spec_id": specArray[i]?.id as Any, "is_main": false])
        }
        let updateProfileSpec = UpdateProfileKeySpec(arraySpec: updateSpec)
        
        getData(typeOfContent: .updateProfile,
                returning: (Int?, String?).self,
                requestParams: ["json": updateProfileSpec.jsonData as Any]) { [weak self] result in
                    let dispathGroup = DispatchGroup()
                    
                    updateProfileSpec.responce = result
                    
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async { [weak self]  in
                            print("updateProfileSpec = \(String(describing: updateProfileSpec.responce))")
                            guard let code = updateProfileSpec.responce?.0 else { return }
                            if responceCode(code: code) {
                                self?.updateInterests()
                            } else {
                                self?.view.showAlert(message: updateProfileSpec.responce?.1)
                            }
                        }
                    }
        }
    }
    
    /// Обновление информации о интересах пользователя на сервере
    private func updateInterests() {
        var intArray: [Int] = []
        for i in 0 ..< userInterests.count {
            intArray.append(userInterests[i].id)
        }
        
        let updateProfile = UpdateProfileKeyInterest(arrayInterest: intArray)
        
        getData(typeOfContent: .updateProfile,
                returning: (Int?, String?).self,
                requestParams: ["json": updateProfile.jsonData as Any]) { [weak self] result in
                    let dispathGroup = DispatchGroup()
                    
                    updateProfile.responce = result
                    
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async { [weak self]  in
                            print("updateInterests = \(String(describing: updateProfile.responce))")
                            guard let code = updateProfile.responce?.0 else { return }
                            if responceCode(code: code) {
                                self?.next()
                            } else {
                                self?.view.showAlert(message: updateProfile.responce?.1)
                            }
                        }
                    }
        }
    }
    
    /// Обновление информации о пользователе на сервере
    /// - Parameter profile: информация для обновления
    private func updateProfile() {
        let profile = UpdateProfileKeyUser(first_name: Session.instance.user?.first_name,
                                           last_name: Session.instance.user?.last_name,
                                           middle_name: Session.instance.user?.middle_name,
                                           phone_number: Session.instance.user?.phone_number,
                                           birthday: Session.instance.user?.birthday,
                                           city_id: Session.instance.user?.city_id,
                                           foto: user?.foto,
                                           gender: Session.instance.user?.gender,
                                           is_medic_worker: Session.instance.user?.is_medic_worker)
        
        getData(typeOfContent: .updateProfile,
                returning: (Int?, String?).self,
                requestParams: ["json": profile.jsonData as Any] ) { [weak self] result in
                    let dispathGroup = DispatchGroup()
                    profile.responce = result
                    
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async { [weak self]  in
                            print("updateProfile = \(String(describing: profile.responce))")
                            guard let code = profile.responce?.0 else { return }
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
                                self?.view.showAlert(message: profile.responce?.1)
                            }
                        }
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
