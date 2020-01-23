//
//  StartMainPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 31.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol StartMainPresenterProtocol {
    init(view: StartMainViewController)
    func profileCheck()
    func fillProfile()
    func toProfile()
}

class StartMainPresenter: StartMainPresenterProtocol {
    
    // MARK: - Dependency
    var view: StartMainViewController
    
    // MARK: - Constants and variables
    private let session = Session.instance
    
    // MARK: - Init
    required init(view: StartMainViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    /// Производит проверку заполнения всех необходимых полей пользователя
    func profileCheck() {
        view.startAnimating()
        getUser()
        let checkProfile = Registration(email: nil, password: nil, token: myToken)
        
        getData(typeOfContent: .checkProfile,
                returning: (Int?, String?).self,
                requestParams: checkProfile.requestParams)
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            checkProfile.responce = result
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self] in
                    self?.view.stopAnimating()
                    print("result=\(String(describing: checkProfile.responce))")
                    guard let code = checkProfile.responce?.0,
                        let status = checkProfile.responce?.1 else { return }
                    if responceCode(code: code) && status == "True" {
                        self?.view.hideFillProfileButton()
                    } else {
                        self?.view.showFillProfileButton()
                    }
                }
            }
        }
    }
    
    // MARK: - Private methods
    /// Загрузка информации о пользователе с сервера
    private func getUser() {
        let getDataProfile = Profile()
        
        getData(typeOfContent: .getDataFromProfile,
                returning: ([String: [AnyObject]], Int?, String?).self,
                requestParams: [:] )
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            getDataProfile.dataFromProfile = result?.0
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    print("getDataProfile = \(String(describing: getDataProfile.dataFromProfile))")
                    //swiftlint:disable force_cast
                    let userData: [ProfileKeyUser] = getDataProfile.dataFromProfile?["user"] as! [ProfileKeyUser]
                    //swiftlint:enable force_cast
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
                                   foto: userData[0].foto)
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
    
}
