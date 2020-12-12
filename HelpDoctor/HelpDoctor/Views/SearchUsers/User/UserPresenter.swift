//
//  UserPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 30.11.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol UserPresenterProtocol: Presenter {
    init(view: UserViewController)
    func getUser(by id: Int)
    func addContact(with id: Int)
    func addToBlockList(with id: Int)
    func back()
}

class UserPresenter: UserPresenterProtocol {
    
    // MARK: - Dependency
    let view: UserViewController
    
    required init(view: UserViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    /// Загрузка информации о пользователе с сервера
    func getUser(by id: Int) {
        NetworkManager.shared.getUser(by: id) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let profiles):
                    self.view.setName(name: profiles.user.fullName ?? "")
                    self.view.setImage(image: profiles.user.foto?.toImage())
                    self.view.setupGeneralView(profiles.user)
                    self.view.setupEducationView(profiles.educations)
                    self.view.setupCareerView(profiles.job)
                    self.view.setupInterestsView(profiles.interests)
                    guard let index = profiles.specializations.firstIndex(where: { $0.isMain == true }) else { return }
                    self.view.setSpec(spec: profiles.specializations[index].specialization?.name ?? "")
                case .failure(let error):
                    self.view.showAlert(message: error.description)
                }
            }
        }
    }
    
    func addContact(with id: Int) {
        NetworkManager.shared.addContact(with: id) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.view.showSaved(message: "Пользователь добавлен в Ваш контакт-лист")
                case .failure(let error):
                    self.view.showAlert(message: error.description)
                }
            }
        }
    }
    
    func addToBlockList(with id: Int) {
        NetworkManager.shared.addToBlockList(with: id) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.view.showSaved(message: "Пользователь добавлен в Ваш блок-лист")
                case .failure(let error):
                    self.view.showAlert(message: error.description)
                }
            }
        }
    }
    
    // MARK: - Private methods
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
}

// MARK: - Presenter
extension UserPresenter {
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
    func toProfile() {
        if Session.instance.userCheck {
            let viewController = ProfileViewController()
            viewController.presenter = ProfilePresenter(view: viewController)
            view.navigationController?.pushViewController(viewController, animated: true)
        } else {
            let viewController = CreateProfileNameViewController()
            viewController.presenter = CreateProfileNamePresenter(view: viewController)
            view.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
