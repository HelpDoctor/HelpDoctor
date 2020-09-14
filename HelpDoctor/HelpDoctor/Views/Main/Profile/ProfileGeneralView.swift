//
//  ProfileGeneralView.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 31.03.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class ProfileGeneralView: UIView {
    private let birthdayLabel = UILabel()
    private let birthdayDataLabel = UILabel()
    private let genderLabel = UILabel()
    private let genderDataLabel = UILabel()
    private let contactsLabel = UILabel()
    private let emailImageView = UIImageView()
    private let emailLabel = UILabel()
    private let phoneImageView = UIImageView()
    private let phoneLabel = UILabel()
    private let addressLabel = UILabel()
    private let addressDataLabel = UILabel()
    private let leading = 20.f
    private let heightLabel = 15.f
    private var verticalSpacing = 5.f
    
//    convenience init(user: ProfileKeyUser, height: CGFloat) {
    convenience init(user: User, height: CGFloat) {
        self.init()
        verticalSpacing = (height - heightLabel * 9) / 10
        self.birthdayDataLabel.text = convertDate(user.birthday)
        self.genderDataLabel.text = formatGender(user.gender)
        self.emailLabel.text = user.email
//        self.phoneLabel.text = user.phone_number
        self.phoneLabel.text = user.phoneNumber
        self.addressDataLabel.text = "\(user.regionName ?? ""), \(user.cityName ?? "")"
        backgroundColor = .white
        setupBirthdayLabel()
        setupBirthdayDataLabel()
        setupGenderLabel()
        setupGenderDataLabel()
        setupContactsLabel()
        setupEmailImageView()
        setupEmailLabel()
        setupPhoneImageView()
        setupPhoneLabel()
        setupAddressLabel()
        setupAddressDataLabel()
    }
    
    private func setupBirthdayLabel() {
        birthdayLabel.font = .boldSystemFontOfSize(size: 14)
        birthdayLabel.numberOfLines = 1
        birthdayLabel.text = "Дата рождения"
        birthdayLabel.textColor = .black
        self.addSubview(birthdayLabel)
        
        birthdayLabel.translatesAutoresizingMaskIntoConstraints = false
        birthdayLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        birthdayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                               constant: leading).isActive = true
        birthdayLabel.topAnchor.constraint(equalTo: self.topAnchor,
                                           constant: verticalSpacing).isActive = true
        birthdayLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                constant: -leading).isActive = true
    }
    
    private func setupBirthdayDataLabel() {
        birthdayDataLabel.font = .systemFontOfSize(size: 14)
        birthdayDataLabel.numberOfLines = 1
        birthdayDataLabel.textColor = .black
        self.addSubview(birthdayDataLabel)
        
        birthdayDataLabel.translatesAutoresizingMaskIntoConstraints = false
        birthdayDataLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        birthdayDataLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                   constant: leading).isActive = true
        birthdayDataLabel.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor,
                                               constant: verticalSpacing).isActive = true
        birthdayDataLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                    constant: -leading).isActive = true
    }
    
    private func setupGenderLabel() {
        genderLabel.font = .boldSystemFontOfSize(size: 14)
        genderLabel.numberOfLines = 1
        genderLabel.text = "Пол"
        genderLabel.textColor = .black
        self.addSubview(genderLabel)
        
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        genderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                             constant: leading).isActive = true
        genderLabel.topAnchor.constraint(equalTo: birthdayDataLabel.bottomAnchor,
                                         constant: verticalSpacing).isActive = true
        genderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                              constant: -leading).isActive = true
    }
    
    private func setupGenderDataLabel() {
        genderDataLabel.font = .systemFontOfSize(size: 14)
        genderDataLabel.numberOfLines = 1
        genderDataLabel.textColor = .black
        self.addSubview(genderDataLabel)
        
        genderDataLabel.translatesAutoresizingMaskIntoConstraints = false
        genderDataLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        genderDataLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                 constant: leading).isActive = true
        genderDataLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor,
                                             constant: verticalSpacing).isActive = true
        genderDataLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                  constant: -leading).isActive = true
    }
    
    private func setupContactsLabel() {
        contactsLabel.font = .boldSystemFontOfSize(size: 14)
        contactsLabel.numberOfLines = 1
        contactsLabel.text = "Контакты"
        contactsLabel.textColor = .black
        self.addSubview(contactsLabel)
        
        contactsLabel.translatesAutoresizingMaskIntoConstraints = false
        contactsLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        contactsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                               constant: leading).isActive = true
        contactsLabel.topAnchor.constraint(equalTo: genderDataLabel.bottomAnchor,
                                           constant: verticalSpacing).isActive = true
        contactsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                constant: -leading).isActive = true
    }
    
    private func setupEmailImageView() {
        emailImageView.image = UIImage(named: "EmailIcon")
        self.addSubview(emailImageView)
        
        emailImageView.translatesAutoresizingMaskIntoConstraints = false
        emailImageView.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        emailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                constant: leading).isActive = true
        emailImageView.topAnchor.constraint(equalTo: contactsLabel.bottomAnchor,
                                            constant: verticalSpacing).isActive = true
        emailImageView.widthAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupEmailLabel() {
        emailLabel.font = .systemFontOfSize(size: 14)
        emailLabel.numberOfLines = 1
        emailLabel.textColor = .black
        self.addSubview(emailLabel)
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: emailImageView.trailingAnchor,
                                            constant: 5).isActive = true
        emailLabel.topAnchor.constraint(equalTo: contactsLabel.bottomAnchor,
                                        constant: verticalSpacing).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                             constant: -leading).isActive = true
    }
    
    private func setupPhoneImageView() {
        phoneImageView.image = UIImage(named: "PhoneIcon")
        self.addSubview(phoneImageView)
        
        phoneImageView.translatesAutoresizingMaskIntoConstraints = false
        phoneImageView.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        phoneImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                constant: leading).isActive = true
        phoneImageView.topAnchor.constraint(equalTo: emailImageView.bottomAnchor,
                                            constant: verticalSpacing).isActive = true
        phoneImageView.widthAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupPhoneLabel() {
        phoneLabel.font = .systemFontOfSize(size: 14)
        phoneLabel.numberOfLines = 1
        phoneLabel.textColor = .black
        self.addSubview(phoneLabel)
        
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        phoneLabel.leadingAnchor.constraint(equalTo: phoneImageView.trailingAnchor,
                                            constant: 5).isActive = true
        phoneLabel.topAnchor.constraint(equalTo: emailImageView.bottomAnchor,
                                        constant: verticalSpacing).isActive = true
        phoneLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                             constant: -leading).isActive = true
    }
    
    private func setupAddressLabel() {
        addressLabel.font = .boldSystemFontOfSize(size: 14)
        addressLabel.numberOfLines = 1
        addressLabel.text = "Место жительства"
        addressLabel.textColor = .black
        self.addSubview(addressLabel)
        
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                              constant: leading).isActive = true
        addressLabel.topAnchor.constraint(equalTo: phoneImageView.bottomAnchor,
                                          constant: verticalSpacing).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                               constant: -leading).isActive = true
    }
    
    private func setupAddressDataLabel() {
        addressDataLabel.font = .systemFontOfSize(size: 14)
        addressDataLabel.numberOfLines = 1
        addressDataLabel.textColor = .black
        self.addSubview(addressDataLabel)
        
        addressDataLabel.translatesAutoresizingMaskIntoConstraints = false
        addressDataLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        addressDataLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                  constant: leading).isActive = true
        addressDataLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor,
                                              constant: verticalSpacing).isActive = true
        addressDataLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                   constant: -leading).isActive = true
    }
    
    private func formatGender(_ gender: String?) -> String? {
        switch gender {
        case "male":
            return "Мужской"
        case "female":
            return "Женский"
        default:
            return "Не указан"
        }
    }
    
    /// Конвертирование серверного формата даты для отображения на форме
    /// - Parameter birthday: дата с сервера
    private func convertDate(_ birthday: String?) -> String {
        guard let birthday = birthday else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale.current
        guard let birthDate = dateFormatter.date(from: birthday) else { return "" }
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: birthDate)
    }
    
}
