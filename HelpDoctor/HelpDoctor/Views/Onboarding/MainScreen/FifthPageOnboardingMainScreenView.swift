//
//  FifthPageOnboardingMainScreenView.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.02.2021.
//  Copyright © 2021 Mikhail Semerikov. All rights reserved.
//

import UIKit

class FifthPageOnboardingMainScreenView: UIView {
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        let width = 0.4 * Session.width
        let image = UIImage(named: "MenLeftInCircle.pdf")
        let resizedImage = image?.resizeImage(width, opaque: false)
        imageView.image = resizedImage
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .black)
        label.text =
            """
            В любой момент Вы сможете перейти к своему профилю, нажав на эту иконку.
            Когда Вы загрузите в профиль свою фотографию, она отобразится и здесь
            """
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    lazy var arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "FifthPageArrow.pdf")
        return imageView
    }()
    
    lazy var doneButton: HDButton = {
        let button = HDButton(title: "Понятно. Спасибо", fontSize: 16)
        return button
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
        [image, label, arrowImage, doneButton]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setupConstraints() {
        let imageConstraints = [
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            image.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 140),
            image.widthAnchor.constraint(equalToConstant: Session.width * 0.4),
            image.heightAnchor.constraint(equalToConstant: image.image?.size.height ?? 0)
        ]
        
        let labelConstraints = [
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            label.heightAnchor.constraint(equalToConstant: 100)
        ]
    
        
        let arrowImageConstraints = [
            arrowImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Session.width * 0.68),
            arrowImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -23),
            arrowImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            arrowImage.bottomAnchor.constraint(equalTo: label.topAnchor)
        ]
        
        let doneButtonConstraints = [
            doneButton.widthAnchor.constraint(equalToConstant: 148),
            doneButton.heightAnchor.constraint(equalToConstant: 44),
            doneButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            doneButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -44)
        ]
        
        [imageConstraints,
         labelConstraints,
         arrowImageConstraints,
         doneButtonConstraints]
            .forEach(NSLayoutConstraint.activate(_:))
    }
}
