//
//  ProfilePresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 02.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol ProfilePresenterProtocol: Presenter,
    MedicalOrganizationSearchProtocol,
    MedicalSpecializationSearchProtocol,
    CitiesSearchProtocol {
    init(view: ProfileViewController)
    func editInterests()
    func getUser()
    func back()
}

class ProfilePresenter: ProfilePresenterProtocol {
    
    // MARK: - Dependency
    var view: ProfileViewController
    
    // MARK: - Constants and variables
    private let session = Session.instance
    private var user: ProfileKeyUser?
    private var cityId: Int?
    private var idMainJob: Int?
    private var idAddJob: Int?
    private var idMainSpec: Int?
    private var idAddSpec: Int?
    private var workPlace: MedicalOrganization?
    private var addWorkPlace: MedicalOrganization?
    private var mainSpec: MedicalSpecialization?
    private var addSpec: MedicalSpecialization?
    private var mainJobArray: [[String: Any]] = []
    private var addJobArray: [[String: Any]] = []
    private var mainSpecArray: [[String: Any]] = []
    private var addSpecArray: [[String: Any]] = []
    private var interests: [ProfileKeyInterests]?
    private var interest: [ListOfInterests] = []
    private var arrayOfAllInterests: [ListOfInterests]?
    private var indexArray: [Int] = []
    private var codeMainSpec = "general"
    private var codeAddSpec = "040100"
    
    required init(view: ProfileViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    /// Открытие формы со списком интересов
    func editInterests() {
        let viewController = InterestsViewController()
        let presenter = InterestsPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.arrayInterests = arrayOfAllInterests
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /// Загрузка информации о пользователе с сервера
    func getUser() {
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
    
    /// Обновление информации о пользователе на сервере
    /// - Parameter source: тип изменений
    func save(source: SourceEditTextField) {
        guard let nameString = view.getName() else { return }
        let result = nameString.split(separator: " ")
        var lastName: String?
        var firstName: String?
        var middleName: String?
        
        switch result.count {
        case 0:
            self.view.showAlert(message: "Заполните фамилию, имя и отчество (при наличии)")
            return
        case 1:
            lastName = String(result[0])
        case 2:
            lastName = String(result[0])
            firstName = String(result[1])
        case 3:
            lastName = String(result[0])
            firstName = String(result[1])
            middleName = String(result[2])
        default:
            print("Слишком много пробелов в имени")
        }
        
        switch source {
        case .user:
            let phoneNumber = view.getPhone()?.westernArabicNumeralsOnly
            let birthday = convertDateFromView(birthday: view.getBirthday())
            let profile = UpdateProfileKeyUser(first_name: firstName,
                                               last_name: lastName,
                                               middle_name: middleName,
                                               phone_number: phoneNumber,
                                               birthday: birthday,
                                               city_id: cityId,
                                               foto: view.getUserPhoto()?.toString())
            updateProfile(profile: profile)
        case .spec:
            updateSpec()
        case .job:
            updateJob()
        case .interest:
            updateInterests()
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
                                   foto: userData[0].foto)
        let lastName: String = user?.last_name ?? ""
        let name: String = user?.first_name ?? ""
        let middleName: String = user?.middle_name ?? ""
        view.setName(name: "\(lastName) \(name) \(middleName)")
        view.setBirthday(birthday: convertDate(birthday: user?.birthday))
        view.setEmail(email: user?.email ?? "")
        view.setPhone(phone: convertPhone(phone: user?.phone_number ?? ""))
        view.setLocation(location: user?.cityName ?? "")
        view.setImage(image: user?.foto?.toImage())
        cityId = user?.city_id
        session.user = user
    }
    //swiftlint:disable force_unwrapping
    /// Установка информации о работе пользователя в форму
    /// - Parameter jobData: информация с сервера
    private func setJob(jobData: [ProfileKeyJob]) {
        let indexMainJob = jobData.firstIndex(where: { $0.is_main == true })
        if indexMainJob != nil {
            idMainJob = jobData[indexMainJob!].id
            view.setMainJob(job: jobData[indexMainJob!].nameShort ?? "")
        }
        let indexAddJob = jobData.firstIndex(where: { $0.is_main == false })
        if indexAddJob != nil {
            idAddJob = jobData[indexAddJob!].id
            view.setAddJob(job: jobData[indexAddJob!].nameShort ?? "")
        }
    }
    
    /// Установка информации о специализации пользователя в форму
    /// - Parameter specData: информация с сервера
    private func setSpec(specData: [ProfileKeySpec]) {
        let indexMainSpec = specData.firstIndex(where: { $0.is_main == true })
        if indexMainSpec != nil {
            idMainSpec = specData[indexMainSpec!].id
            codeMainSpec = specData[indexMainSpec!].code ?? "general"
            view.setSpec(spec: specData[indexMainSpec!].name ?? "")
        }
        let indexAddSpec = specData.firstIndex(where: { $0.is_main == false })
        if indexAddSpec != nil {
            idAddSpec = specData[indexAddSpec!].id
            codeAddSpec = specData[indexAddSpec!].code ?? "040100"
        }
    }
    
    /// Установка интересов в поле ввода, загрузка интересов в массив интересов по специализации пользователя
    /// - Parameter interestData: данные с сервера
    private func setInterests(interestData: [ProfileKeyInterests]) {
        var stringArray: [String] = []
        for i in 0 ..< interestData.count {
            stringArray.append(interestData[i].name ?? "")
        }
        let string = stringArray.joined(separator: " ")
        view.setInterests(interest: string)
        getInterests(mainSpec: codeMainSpec, addSpec: codeAddSpec)
    }
    //swiftlint:enable force_unwrapping
    
    /// Загрузка массива всех интересов по специализациям пользователя с сервера
    /// - Parameters:
    ///   - mainSpec: основная специализация пользователя
    ///   - addSpec: дополнительная специализация пользователя
    private func getInterests(mainSpec: String, addSpec: String) {
        let getListOfInterest = Profile()
        
        getData(typeOfContent: .getListOfInterestsExtTwo,
                returning: ([String: [ListOfInterests]], Int?, String?).self,
                requestParams: ["spec_code": "\(mainSpec)/\(addSpec)"] )
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            getListOfInterest.listOfInterests = result?.0
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    let interestMainSpec: [ListOfInterests]? = getListOfInterest.listOfInterests?["\(mainSpec)"]
                    let interestAddSpec: [ListOfInterests]? = getListOfInterest.listOfInterests?["\(addSpec)"]
                    self?.arrayOfAllInterests = (interestMainSpec ?? []) + (interestAddSpec ?? [])
                }
            }
        }
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
    
    /// Обновление информации о пользователе на сервере
    /// - Parameter profile: информация для обновления
    private func updateProfile(profile: UpdateProfileKeyUser) {
        getData(typeOfContent: .updateProfile,
                returning: (Int?, String?).self,
                requestParams: ["json": profile.jsonData as Any] )
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            profile.responce = result
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    print("updateProfile = \(String(describing: profile.responce))")
                    guard let code = profile.responce?.0 else { return }
                    if responceCode(code: code) {
                        self?.view.showSaved(message: "Сохранено")
                    } else {
                        self?.view.showAlert(message: profile.responce?.1)
                    }
                }
            }
        }
    }
    
    /// Обновление информации о работе пользователя на сервере
    private func updateJob() {
        let jobArray = mainJobArray + addJobArray
        let updateProfileJob = UpdateProfileKeyJob(arrayJob: jobArray)
        print(jobArray)
        getData(typeOfContent: .updateProfile,
                returning: (Int?, String?).self,
                requestParams: ["json": updateProfileJob.jsonData as Any])
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            updateProfileJob.responce = result
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    print("updateJobProfile = \(String(describing: updateProfileJob.responce))")
                    guard let code = updateProfileJob.responce?.0 else { return }
                    if responceCode(code: code) {
                        self?.view.showSaved(message: "Сохранено")
                    } else {
                        self?.view.showAlert(message: updateProfileJob.responce?.1)
                    }
                }
            }
        }
    }
    
    /// Обновление информации о специализации пользователя на сервере
    private func updateSpec() {
        let specArray = mainSpecArray + addSpecArray
        let updateProfileSpec = UpdateProfileKeySpec(arraySpec: specArray)
        print(specArray.count)
        getData(typeOfContent: .updateProfile,
                returning: (Int?, String?).self,
                requestParams: ["json": updateProfileSpec.jsonData as Any])
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            updateProfileSpec.responce = result
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    print("updateProfileSpec = \(String(describing: updateProfileSpec.responce))")
                    guard let code = updateProfileSpec.responce?.0 else { return }
                    if responceCode(code: code) {
                        self?.view.showSaved(message: "Сохранено")
                    } else {
                        self?.view.showAlert(message: updateProfileSpec.responce?.1)
                    }
                }
            }
        }
    }
    
    /// Обновление информации об интересах пользователя на сервере
    private func updateInterests() {
        var intArray: [Int] = []
        for i in 0 ..< interest.count {
            intArray.append(interest[i].id)
        }
        
        let updateProfile = UpdateProfileKeyInterest(arrayInterest: intArray)
        
        getData(typeOfContent: .updateProfile,
                returning: (Int?, String?).self,
                requestParams: ["json": updateProfile.jsonData as Any])
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            updateProfile.responce = result
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    print("updateInterests = \(String(describing: updateProfile.responce))")
                    guard let code = updateProfile.responce?.0 else { return }
                    if responceCode(code: code) {
                        self?.view.showSaved(message: "Сохранено")
                    } else {
                        self?.view.showAlert(message: updateProfile.responce?.1)
                    }
                }
            }
        }
    }
    
    // MARK: - CitiesSearchProtocol
    /// Получение номера региона
    func getRegionId() -> Int? {
        return session.user?.regionId
    }
    
    /// Установка названия города на форму
    /// - Parameter city: город
    func setCity(city: Cities) {
        cityId = city.id
        view.setLocation(location: city.cityName ?? "")
    }
    
    // MARK: - MedicalOrganizationSearchProtocol
    /// Установка основного места работы на форму
    /// - Parameter medicalOrganization: медицинская организация
    func setMedicalOrganization(medicalOrganization: MedicalOrganization) {
        self.workPlace = medicalOrganization
        view.setMainJob(job: medicalOrganization.nameShort ?? "")
        let job: [String: Any] = ["id": idMainJob ?? 0, "job_oid": medicalOrganization.oid as Any, "is_main": true]
        mainJobArray.removeAll()
        mainJobArray.append(job)
    }
    
    /// Установка дополнительного места работы на форму
    /// - Parameter medicalOrganization: медицинская организация
    func setAddMedicalOrganization(medicalOrganization: MedicalOrganization) {
        self.addWorkPlace = medicalOrganization
        view.setAddJob(job: medicalOrganization.nameShort ?? "")
        let job: [String: Any] = ["id": idAddJob ?? 0, "job_oid": medicalOrganization.oid as Any, "is_main": false]
        addJobArray.removeAll()
        addJobArray.append(job)
    }
    
    // MARK: - MedicalSpecializationSearchProtocol
    /// Установка основной специализации на форму
    /// - Parameter medicalSpecialization: медицинская специализация
    func setMedicalSpecialization(medicalSpecialization: MedicalSpecialization) {
        self.mainSpec = medicalSpecialization
        view.setSpec(spec: medicalSpecialization.name ?? "")
        let spec: [String: Any] = ["id": idMainSpec ?? 0, "spec_id": medicalSpecialization.id as Any, "is_main": true]
        mainSpecArray.removeAll()
        mainSpecArray.append(spec)
        codeMainSpec = medicalSpecialization.code ?? "general"
    }
    
    /// Установка дополнительной специлизации на форму
    /// - Parameter medicalSpecialization: медицинская специализация
    func setAddMedicalSpecialization(medicalSpecialization: MedicalSpecialization) {
        self.addSpec = medicalSpecialization
        //        view.addSpecTextField.text = medicalSpecialization.name
        let spec: [String: Any] = ["id": 0, "spec_id": medicalSpecialization.id as Any, "is_main": false]
        addSpecArray.removeAll()
        addSpecArray.append(spec)
        codeAddSpec = medicalSpecialization.code ?? "040100"
    }
    
    // MARK: - Coordinator
    /// Переход на предыдущую форму
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
