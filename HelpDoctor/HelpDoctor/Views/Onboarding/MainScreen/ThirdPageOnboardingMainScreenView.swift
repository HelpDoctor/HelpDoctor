//
//  ThirdPageOnboardingMainScreenView.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.02.2021.
//  Copyright © 2021 Mikhail Semerikov. All rights reserved.
//

import UIKit

class ThirdPageOnboardingMainScreenView: UIView {
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        let width = 0.4 * Session.width
        let image = UIImage(named: "MenRightInCircle.pdf")
        let resizedImage = image?.resizeImage(width, opaque: false)
        imageView.image = resizedImage
        return imageView
    }()
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .black)
        label.text = "Эта кнопка приведет Вас к экрану контактов"
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
            Эта кнопка приведет Вас к экрану сообщений. Нажав на нее, Вы сможете просмотреть и ответить на сообщения
            """
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    lazy var leftArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ThirdPageLeftArrow.pdf")
        return imageView
    }()
    
    lazy var rightArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ThirdPageRightArrow.pdf")
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
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            image.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 110),
            image.widthAnchor.constraint(equalToConstant: Session.width * 0.4),
            image.heightAnchor.constraint(equalToConstant: image.image?.size.height ?? 0)
        ]
        
        let topLabelConstraints = [
            topLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            topLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            topLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            topLabel.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let bottomLabelConstraints = [
            bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 20),
            bottomLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            bottomLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            bottomLabel.heightAnchor.constraint(equalToConstant: 55)
        ]
        
        let leftArrowImageConstraints = [
            leftArrowImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            leftArrowImage.trailingAnchor.constraint(equalTo: self.leadingAnchor,
                                                     constant: (Session.width / 5) + (Session.width / 10)),
            leftArrowImage.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 5),
            leftArrowImage.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ]
        
        let rightArrowImageConstraints = [
            rightArrowImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Session.width / 2),
            rightArrowImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -75),
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
