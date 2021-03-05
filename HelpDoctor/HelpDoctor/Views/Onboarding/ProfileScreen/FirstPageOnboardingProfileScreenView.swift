//
//  FirstPageOnboardingProfileScreenView.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.03.2021.
//  Copyright © 2021 Mikhail Semerikov. All rights reserved.
//

import UIKit

class FirstPageOnboardingProfileScreenView: UIView {
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .black)
        label.text =
            """
            Здесь Вы можете увидеть информацию о себе или других пользователях.\nНапример, ФИО и специализацию
            """
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .black)
        label.text = "Например: имя и специализацию"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var leftImage: UIImageView = {
        let imageView = UIImageView()
        let width = 0.3 * Session.width
        let image = UIImage(named: "WomenLeft.pdf")
        let resizedImage = image?.resizeImage(width, opaque: false)
        imageView.image = resizedImage
        return imageView
    }()
    
    lazy var arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "FirstPageArrow.pdf")
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
        [topLabel, bottomLabel, leftImage, arrowImage]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setupConstraints() {
        let topLabelConstraints = [
            topLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 66),
            topLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            topLabel.widthAnchor.constraint(equalToConstant: Session.width - 40),
            topLabel.heightAnchor.constraint(equalToConstant: 55)
        ]
        
        let bottomLabelConstraints = [
            bottomLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            bottomLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                                constant: (Session.height / 2) - 65),
            bottomLabel.widthAnchor.constraint(equalToConstant: Session.width - 40),
            bottomLabel.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        let leftImageConstraints = [
            leftImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            leftImage.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            leftImage.widthAnchor.constraint(equalToConstant: Session.width * 0.3),
            leftImage.heightAnchor.constraint(equalToConstant: leftImage.image?.size.height ?? 0)
        ]

        let arrowImageConstraints = [
            arrowImage.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                 constant: -50),
            arrowImage.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor),
            arrowImage.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                constant: Session.width / 2 + 60),
            arrowImage.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                               constant: (Session.height / 2) - 25)
        ]
        
        [topLabelConstraints,
         bottomLabelConstraints,
         leftImageConstraints,
         arrowImageConstraints]
            .forEach(NSLayoutConstraint.activate(_:))
    }
    
}
