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
    func save(source: SourceEditTextField)
}

class ProfilePresenter: ProfilePresenterProtocol {
    
    var view: ProfileViewController
    var user: ProfileKeyUser?
    var interests: [ProfileKeyInterests]?
    
    required init(view: ProfileViewController) {
        self.view = view
    }
    
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
                    let userData: [ProfileKeyUser] = getDataProfile.dataFromProfile?["user"] as! [ProfileKeyUser]
                    self?.user = ProfileKeyUser(id: userData[0].id,
                                                first_name: userData[0].first_name,
                                                last_name: userData[0].last_name,
                                                middle_name: userData[0].middle_name,
                                                email: userData[0].email,
                                                phone_number: userData[0].phone_number,
                                                birthday: userData[0].birthday,
                                                city_id: userData[0].city_id,
                                                cityName: userData[0].cityName,
                                                foto: userData[0].foto)
                    let lastName: String = self?.user?.last_name ?? ""
                    let name: String = self?.user?.first_name ?? ""
                    let middleName: String = self?.user?.middle_name ?? ""
                    self?.view.nameTextField.textField.text = "\(lastName) \(name) \(middleName)"
                    self?.view.birthDateTextField.textField.text = self?.convertDate(birthday: self?.user?.birthday)
                    self?.view.emailTextField.textField.text = self?.user?.email ?? ""
                    self?.view.phoneTextField.textField.text = self?.user?.phone_number ?? ""
                    self?.view.locationTextField.textField.text = self?.user?.cityName ?? ""
                    self?.view.userPhoto.image = self?.user?.foto?.toImage() ?? UIImage(named: "Avatar.pdf")
                    //swiftlint:disable line_length
                    let interestData: [ProfileKeyInterests] = getDataProfile.dataFromProfile?["interests"] as! [ProfileKeyInterests]
                    var stringArray: [String] = []
                    for i in 0 ..< interestData.count {
                        stringArray.append(interestData[i].name ?? "")
                    }
                    let string = stringArray.joined(separator: " ")
                    self?.view.interestsTextView.textView.text = string
                }
            }
        }
    }
    
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
    
    func save(source: SourceEditTextField) {
        guard let nameString = view.nameTextField.textField.text else { return }
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
            let profile = UpdateProfileKeyUser(first_name: firstName,
            last_name: lastName,
            middle_name: middleName,
            phone_number: view.phoneTextField.textField.text,
            birthday: convertDateFromView(birthday: view.birthDateTextField.textField.text),
            city_id: user?.city_id,
            foto: nil)
            updateProfile(profile: profile)
        case .spec:
            print("В разработке")
        case .job:
            print("В разработке")
        }
    }
    
    func updateProfile(profile: UpdateProfileKeyUser) {
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
    
    // MARK: - Coordinator
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
