//
//  FourthPageOnboardingProfileScreenView.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.03.2021.
//  Copyright © 2021 Mikhail Semerikov. All rights reserved.
//

import UIKit

class FourthPageOnboardingProfileScreenView: UIView {
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .black)
        label.text =
            """
            Последнее, посмотрите на этот значок. Он означает, что профиль не прошел проверку,\
            а значит ряд функций приложения HelpDoctor Вам не доступен
            """
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .black)
        label.text =
            """
            Чтобы подтвердить свой врачебный статус, выберите опцию "Верифицировать профиль"\
            и загрузите запрошенную информацию
            """
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var leftImage: UIImageView = {
        let imageView = UIImageView()
        let width = 0.3 * Session.width
        let image = UIImage(named: "WomenLeftInCircle.pdf")
        let resizedImage = image?.resizeImage(width, opaque: false)
        imageView.image = resizedImage
        return imageView
    }()
    
    lazy var rightImage: UIImageView = {
        let imageView = UIImageView()
        let width = 0.3 * Session.width
        let image = UIImage(named: "WomenRightInCircle.pdf")
        let resizedImage = image?.resizeImage(width, opaque: false)
        imageView.image = resizedImage
        return imageView
    }()
    
    lazy var leftArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "FourthPageLeftArrow.pdf")
        return imageView
    }()
    
    lazy var rightArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ThirdPageArrow.pdf")
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.85)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [leftImage, rightImage, topLabel, bottomLabel, leftArrowImage, rightArrowImage]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setupConstraints() {
        let leftImageConstraints = [
            leftImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            leftImage.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                              constant: (Session.height / 2) + 40),
            leftImage.widthAnchor.constraint(equalToConstant: Session.width * 0.3),
            leftImage.heightAnchor.constraint(equalToConstant: leftImage.image?.size.height ?? 0)
        ]
        
        let rightImageConstraints = [
            rightImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            rightImage.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                                              constant: -70),
            rightImage.widthAnchor.constraint(equalToConstant: Session.width * 0.3),
            rightImage.heightAnchor.constraint(equalToConstant: rightImage.image?.size.height ?? 0)
        ]
        
        let topLabelConstraints = [
            topLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            topLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            topLabel.widthAnchor.constraint(equalToConstant: Session.width - 40),
            topLabel.heightAnchor.constraint(equalToConstant: 67)
        ]
        
        let bottomLabelConstraints = [
            bottomLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            bottomLabel.topAnchor.constraint(equalTo: leftImage.bottomAnchor,
                                                constant: 20),
            bottomLabel.widthAnchor.constraint(equalToConstant: Session.width - 40),
            bottomLabel.heightAnchor.constraint(equalToConstant: 67)
        ]
        
        let bottom = Session.height * 9 / 24
        let trailing = (Session.width - ((Session.width / 2) - ((Session.height / 2 - 90) / 3)) - 10 - (Session.height / 2 - 90) / 12) - (Session.height / 24 + 2.5) / 2
        let leftArrowImageConstraints = [
            leftArrowImage.trailingAnchor.constraint(equalTo: self.leadingAnchor,
                                                     constant: trailing),
            leftArrowImage.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                                   constant: bottom - 35),
            leftArrowImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60),
            leftArrowImage.topAnchor.constraint(equalTo: topLabel.bottomAnchor)
        ]
        
        let rightArrowImageConstraints = [
            rightArrowImage.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                 constant: -25),
            rightArrowImage.bottomAnchor.constraint(equalTo: bottomLabel.topAnchor),
            rightArrowImage.widthAnchor.constraint(equalToConstant: 52),
            rightArrowImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                            constant: (Session.height / 2) - 25)
        ]
        
        [leftImageConstraints,
         rightImageConstraints,
         topLabelConstraints,
         bottomLabelConstraints,
         leftArrowImageConstraints,
         rightArrowImageConstraints]
            .forEach(NSLayoutConstraint.activate(_:))
    }
    
}
