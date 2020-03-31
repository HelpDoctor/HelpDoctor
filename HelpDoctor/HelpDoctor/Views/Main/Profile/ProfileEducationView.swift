//
//  ProfileEducationView.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 31.03.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class ProfileEducationView: UIView {
    private let universityLabel = UILabel()
    private let universityDataLabel = UILabel()
    private let dateOfGraduateLabel = UILabel()
    private let dateOfGraduateDataLabel = UILabel()
    private let graduateLabel = UILabel()
    private let graduateDataLabel = UILabel()
    private let leading = 20.f
    private let heightLabel = 15.f
    private let verticalSpacing = 5.f
    private let university = "Дальневосточный государственный медицинский университет" //TODO: - Удалить
    private var universityDataLabelHeight = 0.f
    
    convenience init(user: ProfileKeyUser) {
        self.init()
        self.universityDataLabel.text = university //TODO: - Заменить на данные с сервера
        universityDataLabelHeight = university.height(withConstrainedWidth: Session.width - (2 * leading),
                                                      font: .systemFontOfSize(size: 14))
        self.dateOfGraduateDataLabel.text = "2008" //TODO: - Заменить на данные с сервера
        self.graduateDataLabel.text = "Доцент" //TODO: - Заменить на данные с сервера
        backgroundColor = .white
        setupUniversityLabel()
        setupUniversityDataLabel()
        setupDateOfGraduateLabel()
        setupDateOfGraduateDataLabel()
        setupGraduateLabel()
        setupGraduateDataLabel()
    }
    
    private func setupUniversityLabel() {
        universityLabel.font = .boldSystemFontOfSize(size: 14)
        universityLabel.numberOfLines = 1
        universityLabel.text = "Учебное заведение"
        universityLabel.textColor = .black
        self.addSubview(universityLabel)
        
        universityLabel.translatesAutoresizingMaskIntoConstraints = false
        universityLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        universityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                 constant: leading).isActive = true
        universityLabel.topAnchor.constraint(equalTo: self.topAnchor,
                                             constant: verticalSpacing).isActive = true
        universityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                  constant: -leading).isActive = true
    }
    
    private func setupUniversityDataLabel() {
        universityDataLabel.font = .systemFontOfSize(size: 14)
        universityDataLabel.numberOfLines = 0
        universityDataLabel.textColor = .black
        self.addSubview(universityDataLabel)
        
        universityDataLabel.translatesAutoresizingMaskIntoConstraints = false
        universityDataLabel.heightAnchor.constraint(equalToConstant: universityDataLabelHeight).isActive = true
        universityDataLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                     constant: leading).isActive = true
        universityDataLabel.topAnchor.constraint(equalTo: universityLabel.bottomAnchor,
                                                 constant: verticalSpacing).isActive = true
        universityDataLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                      constant: -leading).isActive = true
    }
    
    private func setupDateOfGraduateLabel() {
        dateOfGraduateLabel.font = .boldSystemFontOfSize(size: 14)
        dateOfGraduateLabel.numberOfLines = 1
        dateOfGraduateLabel.text = "Год выпуска"
        dateOfGraduateLabel.textColor = .black
        self.addSubview(dateOfGraduateLabel)
        
        dateOfGraduateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateOfGraduateLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        dateOfGraduateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                     constant: leading).isActive = true
        dateOfGraduateLabel.topAnchor.constraint(equalTo: universityDataLabel.bottomAnchor,
                                                 constant: verticalSpacing).isActive = true
        dateOfGraduateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                      constant: -leading).isActive = true
    }
    
    private func setupDateOfGraduateDataLabel() {
        dateOfGraduateDataLabel.font = .systemFontOfSize(size: 14)
        dateOfGraduateDataLabel.numberOfLines = 1
        dateOfGraduateDataLabel.textColor = .black
        self.addSubview(dateOfGraduateDataLabel)
        
        dateOfGraduateDataLabel.translatesAutoresizingMaskIntoConstraints = false
        dateOfGraduateDataLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        dateOfGraduateDataLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                         constant: leading).isActive = true
        dateOfGraduateDataLabel.topAnchor.constraint(equalTo: dateOfGraduateLabel.bottomAnchor,
                                                     constant: verticalSpacing).isActive = true
        dateOfGraduateDataLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                          constant: -leading).isActive = true
    }
    
    private func setupGraduateLabel() {
        graduateLabel.font = .boldSystemFontOfSize(size: 14)
        graduateLabel.numberOfLines = 1
        graduateLabel.text = "Ученая степень"
        graduateLabel.textColor = .black
        self.addSubview(graduateLabel)
        
        graduateLabel.translatesAutoresizingMaskIntoConstraints = false
        graduateLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        graduateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                               constant: leading).isActive = true
        graduateLabel.topAnchor.constraint(equalTo: dateOfGraduateDataLabel.bottomAnchor,
                                           constant: verticalSpacing).isActive = true
        graduateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                constant: -leading).isActive = true
    }
    
    private func setupGraduateDataLabel() {
        graduateDataLabel.font = .systemFontOfSize(size: 14)
        graduateDataLabel.numberOfLines = 1
        graduateDataLabel.textColor = .black
        self.addSubview(graduateDataLabel)
        
        graduateDataLabel.translatesAutoresizingMaskIntoConstraints = false
        graduateDataLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        graduateDataLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                   constant: leading).isActive = true
        graduateDataLabel.topAnchor.constraint(equalTo: graduateLabel.bottomAnchor,
                                               constant: verticalSpacing).isActive = true
        graduateDataLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                    constant: -leading).isActive = true
    }
    
}
