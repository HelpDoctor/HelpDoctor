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
    func toEditProfile()
    func getStatusUser()
    func logout()
    func back()
}

class ProfilePresenter: ProfilePresenterProtocol {
    
    // MARK: - Dependency
    let view: ProfileViewController
    let networkManager = NetworkManager()
    
    // MARK: - Constants and variables
    private let session = Session.instance
    private var user: User?
    private var educationArray: [Education] = []
    private var jobArray: [Job?] = [nil, nil, nil, nil, nil]
    private var interestsArray: [ProfileInterest]?
    
    required init(view: ProfileViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    /// Загрузка информации о пользователе с сервера
    func getUser() {
        self.networkManager.getUser { profiles, error in
            if let error = error {
                self.view.showAlert(message: error)
            }
            if let profiles = profiles {
                self.setUser(userData: profiles.user)
                self.setEducation(education: profiles.educations)
                self.setJob(jobData: profiles.job)
                self.setSpec(specData: profiles.specializations)
                self.setInterests(interestData: profiles.interests)
            }
        }
    }
    
    func getStatusUser() {
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
                                self?.toOkVerification()
                                UserDefaults.standard.set("verified", forKey: "userStatus")
                            default:
                                break
                            }
                        }
                    }
        }
    }
    
    func logout() {
        let logout = Registration(email: nil, password: nil, token: myToken)
        
        getData(typeOfContent: .logout,
                returning: (Int?, String?).self,
                requestParams: logout.requestParams) { [weak self] result in
                    let dispathGroup = DispatchGroup()
                    logout.responce = result
                    
                    dispathGroup.notify(queue: DispatchQueue.main) {
                        DispatchQueue.main.async { [weak self]  in
                            print("result=\(String(describing: logout.responce))")
                            guard let code = logout.responce?.0 else { return }
                            if responceCode(code: code) {
                                print("Logout")
                                UserDefaults.standard.set("not_verification", forKey: "userStatus")
                                AppDelegate.shared.rootViewController.switchToLogout()
                            } else {
                                self?.view.showAlert(message: logout.responce?.1)
                            }
                        }
                    }
        }
    }
    
    // MARK: - Private methods
    /// Установка информации о пользователе в форму
    /// - Parameter userData: информация с сервера
    private func setUser(userData: User) {
        self.user = User(id: userData.id,
                         firstName: userData.firstName,
                         lastName: userData.lastName,
                         middleName: userData.middleName,
                         gender: userData.gender,
                         email: userData.email,
                         phoneNumber: userData.phoneNumber,
                         birthday: userData.birthday,
                         cityId: userData.cityId,
                         cityName: userData.cityName,
                         regionId: userData.regionId,
                         regionName: userData.regionName,
                         foto: userData.foto,
                         isMedicWorker: userData.isMedicWorker,
                         verifiedUser: userData.verifiedUser)
        let lastName = user?.lastName ?? ""
        let name = user?.firstName ?? ""
        let middleName = user?.middleName ?? ""
        DispatchQueue.main.async {
            self.view.setName(name: "\(lastName) \(name) \(middleName)")
            self.view.setImage(image: self.user?.foto?.toImage())
            self.session.user = self.user
            self.view.setupGeneralView()
        }
    }
    
    private func setEducation(education: [Education]) {
        session.education?.removeAll()
        session.education = education
        educationArray = education
        DispatchQueue.main.async {
            self.view.setupEducationView()
        }
    }
    
    /// Установка информации о работе пользователя в форму
    /// - Parameter jobData: информация с сервера
    private func setJob(jobData: [Job]) {
        session.userJob?.removeAll()
        session.userJob = jobData
        jobArray = jobData
        DispatchQueue.main.async {
            self.view.setupCareerView()
        }
    }
    
    /// Установка информации о специализации пользователя в форму
    /// - Parameter specData: информация с сервера
    private func setSpec(specData: [Specialization]) {
        guard let indexMainSpec = specData.firstIndex(where: { $0.isMain == true }) else { return }
        DispatchQueue.main.async {
            self.view.setSpec(spec: specData[indexMainSpec].specialization?.name ?? "")
        }
    }
    
    /// Установка интересов в поле ввода, загрузка интересов в массив интересов по специализации пользователя
    /// - Parameter interestData: данные с сервера
    private func setInterests(interestData: [ProfileInterest]) {
        session.userInterests = interestData
        interestsArray = interestData
        DispatchQueue.main.async {
            self.view.setupInterestsView()
        }
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
    
    func toEditProfile() {
        let viewController = EditProfileViewController()
        viewController.presenter = EditProfilePresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
