//
//  FourthPageOnboardingMainScreenView.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.02.2021.
//  Copyright © 2021 Mikhail Semerikov. All rights reserved.
//

import UIKit

class FourthPageOnboardingMainScreenView: UIView {
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        let width = 0.4 * Session.width
        let image = UIImage(named: "WomenLeftInCircle.pdf")
        let resizedImage = image?.resizeImage(width, opaque: false)
        imageView.image = resizedImage
        return imageView
    }()
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .black)
        label.text =
            """
            Нажав на неё, Вы сможете найти своих знакомых из профессионального сообщества и быть с ними на связи
            """
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .black)
        label.text =
            """
            Эта кнопка Настроек. На этом экране Вы сможете настроить сервис HelpDoctor на комфортный режим использования
            """
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    lazy var leftArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "FourthPageLeftArrow.pdf")
        return imageView
    }()
    
    lazy var rightArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "FourthPageRightArrow.pdf")
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
        [image, topLabel, bottomLabel, leftArrowImage, rightArrowImage]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setupConstraints() {
        let imageConstraints = [
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            image.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 80),
            image.widthAnchor.constraint(equalToConstant: Session.width * 0.4),
            image.heightAnchor.constraint(equalToConstant: image.image?.size.height ?? 0)
        ]
        
        let topLabelConstraints = [
            topLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            topLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            topLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            topLabel.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        let bottomLabelConstraints = [
            bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 80),
            bottomLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            bottomLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            bottomLabel.heightAnchor.constraint(equalToConstant: 70)
        ]
        
        let leftArrowImageConstraints = [
            leftArrowImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            leftArrowImage.trailingAnchor.constraint(equalTo: self.leadingAnchor,
                                                     constant: (Session.width / 5) * 3 + (Session.width / 10)),
            leftArrowImage.topAnchor.constraint(equalTo: topLabel.bottomAnchor),
            leftArrowImage.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ]
        
        let rightArrowImageConstraints = [
            rightArrowImage.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                     constant: (Session.width / 5) * 4 + (Session.width / 10)),
            rightArrowImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            rightArrowImage.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 1),
            rightArrowImage.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ]
        
        [imageConstraints,
         topLabelConstraints,
         bottomLabelConstraints,
         leftArrowImageConstraints,
         rightArrowImageConstraints]
            .forEach(NSLayoutConstraint.activate(_:))
    }
    
}
