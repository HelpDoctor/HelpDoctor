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
}

class StartMainPresenter: StartMainPresenterProtocol {
    
    // MARK: - Dependency
    let view: StartMainViewController
    
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
        let checkProfile = Registration(email: nil, password: nil, token: myToken)
        
        getData(typeOfContent: .checkProfile,
                returning: (Int?, String?).self,
                requestParams: checkProfile.requestParams) { [weak self] result in
                    let dispathGroup = DispatchGroup()
                    checkProfile.responce = result
                    
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async { [weak self] in
                            self?.view.stopActivityIndicator()
                            print("result=\(String(describing: checkProfile.responce))")
                            guard let code = checkProfile.responce?.0,
                                let status = checkProfile.responce?.1 else { return }
                            if responceCode(code: code) && status == "True" {
                                //                        self?.view.hideFillProfileButton()
                                self?.view.showFillProfileButton()
                                if UserDefaults.standard.string(forKey: "userStatus") != "verified" {
                                    self?.getStatusUser()
                                }
                            } else {
                                self?.view.showFillProfileButton()
                            }
                        }
                    }
        }
    }
    
    // MARK: - Private methods
    private func getStatusUser() {
        let userStatus = VerificationResponse()
        
        getData(typeOfContent: .userStatus,
                returning: ([Verification], Int?, String?).self,
                requestParams: [:]) { [weak self] result in
                    let dispathGroup = DispatchGroup()
                    userStatus.verification = result?.0
                    
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async { [weak self] in
                            print("result=\(String(describing: userStatus.verification))")
                            guard let status = userStatus.verification?[0].status else { return }
                            switch status {
                            case "denied":
                                UserDefaults.standard.set("denied", forKey: "userStatus")
                                self?.toErrorVerification(userStatus.verification?[0].message)
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
                        }
                    }
        }
    }
    
    /// Загрузка информации о пользователе с сервера
    private func getUser() {
        let getDataProfile = Profile()
        
        getData(typeOfContent: .getDataFromProfile,
                returning: ([String: [AnyObject]], Int?, String?).self,
                requestParams: [:]) { [weak self] result in
                    let dispathGroup = DispatchGroup()
                    
                    getDataProfile.dataFromProfile = result?.0
                    
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async { [weak self]  in
                            print("getDataProfile = \(String(describing: getDataProfile.dataFromProfile))")
                            //swiftlint:disable line_length
                            guard let userData: [ProfileKeyUser] = getDataProfile.dataFromProfile?["user"] as? [ProfileKeyUser] else { return }
                            //swiftlint:enable line_length
                            self?.setUser(userData: userData)
                        }
                    }
        }
    }
    
    /// Установка информации о пользователе в форму
    /// - Parameter userData: информация с сервера
    private func setUser(userData: [ProfileKeyUser]) {
        Session.instance.user = ProfileKeyUser(id: userData[0].id,
                                               first_name: userData[0].first_name,
                                               last_name: userData[0].last_name,
                                               middle_name: userData[0].middle_name,
                                               email: userData[0].email,
                                               phone_number: userData[0].phone_number,
                                               birthday: userData[0].birthday,
                                               city_id: userData[0].city_id,
                                               cityName: userData[0].cityName,
                                               regionId: userData[0].regionId,
                                               regionName: userData[0].regionName,
                                               foto: userData[0].foto,
                                               gender: userData[0].gender)
        view.setImage(image: Session.instance.user?.foto?.toImage())
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
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
