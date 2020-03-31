//
//  ProfilePresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 02.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol ProfilePresenterProtocol: Presenter {
    init(view: ProfileViewController)
    func getUser()
    func back()
}

class ProfilePresenter: ProfilePresenterProtocol {
    
    // MARK: - Dependency
    let view: ProfileViewController
    
    // MARK: - Constants and variables
    private let session = Session.instance
    private var user: ProfileKeyUser?
    private var jobArray: [ProfileKeyJob?] = [nil, nil, nil, nil, nil]
    private var interestsArray: [ProfileKeyInterests]?
    
    required init(view: ProfileViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    /// Загрузка информации о пользователе с сервера
    func getUser() {
        let getDataProfile = Profile()
        
        getData(typeOfContent: .getDataFromProfile,
                returning: ([String: [AnyObject]], Int?, String?).self,
                requestParams: [:] ) { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            getDataProfile.dataFromProfile = result?.0
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    print("getDataProfile = \(String(describing: getDataProfile.dataFromProfile))")
                    //swiftlint:disable force_cast
                    let userData: [ProfileKeyUser] = getDataProfile.dataFromProfile?["user"] as! [ProfileKeyUser]
                    let jobData: [ProfileKeyJob] = getDataProfile.dataFromProfile?["job"] as! [ProfileKeyJob]
                    let specData: [ProfileKeySpec] = getDataProfile.dataFromProfile?["spec"] as! [ProfileKeySpec]
                    let interestData: [ProfileKeyInterests] = getDataProfile.dataFromProfile?["interests"] as! [ProfileKeyInterests] //swiftlint:disable:this line_length
                    //swiftlint:enable force_cast
                    self?.setUser(userData: userData)
                    self?.setJob(jobData: jobData)
                    self?.setSpec(specData: specData)
                    self?.setInterests(interestData: interestData)
                }
            }
        }
    }
    
    // MARK: - Private methods
    /// Установка информации о пользователе в форму
    /// - Parameter userData: информация с сервера
    private func setUser(userData: [ProfileKeyUser]) {
        self.user = ProfileKeyUser(id: userData[0].id,
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
        let lastName: String = user?.last_name ?? ""
        let name: String = user?.first_name ?? ""
        let middleName: String = user?.middle_name ?? ""
        view.setName(name: "\(lastName) \(name) \(middleName)")
        view.setImage(image: user?.foto?.toImage())
        session.user = user
        view.setupGeneralView()
        view.setupEducationView()
    }

    /// Установка информации о работе пользователя в форму
    /// - Parameter jobData: информация с сервера
    private func setJob(jobData: [ProfileKeyJob]) {
        session.userJob = jobData
        jobArray = jobData
        view.setupCareerView()
    }
    
    /// Установка информации о специализации пользователя в форму
    /// - Parameter specData: информация с сервера
    private func setSpec(specData: [ProfileKeySpec]) {
        let indexMainSpec = specData.firstIndex(where: { $0.is_main == true })
        
        if indexMainSpec != nil {
            view.setSpec(spec: specData[indexMainSpec!].name ?? "")
        }
        
    }
    
    /// Установка интересов в поле ввода, загрузка интересов в массив интересов по специализации пользователя
    /// - Parameter interestData: данные с сервера
    private func setInterests(interestData: [ProfileKeyInterests]) {
        session.userInterests = interestData
        interestsArray = interestData
        view.setupInterestsView()
    }
    
    /// Конвертирование серверного формата даты для отображения на форме
    /// - Parameter birthday: дата с сервера
    private func convertDate(birthday: String?) -> String {
        guard let birthday = birthday else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale.current
        guard let birthDate = dateFormatter.date(from: birthday) else { return "" }
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: birthDate)
    }
    
    /// Конвертирование формата даты с формы в серверный
    /// - Parameter birthday: дата с формы
    private func convertDateFromView(birthday: String?) -> String {
        guard let birthday = birthday else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale.current
        guard let birthDate = dateFormatter.date(from: birthday) else { return "" }
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: birthDate)
    }
    
    /// Конвертирование серверного формата телефонного номера для отображения на форме
    /// - Parameter phone: номер телефона
    private func convertPhone(phone: String) -> String {
        return "+\(phone[0]) (\(phone[1 ..< 4])) \(phone[4 ..< 7])-\(phone[7 ..< 9])-\(phone[9 ..< 11])"
    }
    
    // MARK: - Coordinator
    /// Переход на предыдущую форму
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
    func save(source: SourceEditTextField) {
        
    }
    
}
