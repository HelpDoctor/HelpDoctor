//
//  FirstPageOnboardingMainScreenView.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.02.2021.
//  Copyright © 2021 Mikhail Semerikov. All rights reserved.
//

import UIKit

class FirstPageOnboardingMainScreenView: UIView {
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .black)
        label.text = "Спасибо, что решили воспользоваться приложением HelpDoctor!"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .black)
        label.text = "Цель приложения - помочь медработникам в организации рабочего процесса "
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
    
    lazy var rightImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MenRight.pdf")
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
        [topLabel, bottomLabel, leftImage, rightImage]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setupConstraints() {
        let topLabelConstraints = [
            topLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            topLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            topLabel.widthAnchor.constraint(equalToConstant: Session.width - 50),
            topLabel.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let bottomLabelConstraints = [
            bottomLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 20),
            bottomLabel.widthAnchor.constraint(equalToConstant: Session.width - 50),
            bottomLabel.heightAnchor.constraint(equalToConstant: 55)
        ]
        
        let leftImageConstraints = [
            leftImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            leftImage.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            leftImage.widthAnchor.constraint(equalToConstant: Session.width * 0.3),
            leftImage.heightAnchor.constraint(equalToConstant: leftImage.image?.size.height ?? 0)
        ]

        let rightImageConstraints = [
            rightImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            rightImage.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            rightImage.heightAnchor.constraint(equalTo: leftImage.heightAnchor)
        ]
        
        [topLabelConstraints,
         bottomLabelConstraints,
         leftImageConstraints,
         rightImageConstraints]
            .forEach(NSLayoutConstraint.activate(_:))
    }
    
}
