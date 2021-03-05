//
//  SecondPageOnboardingMainScreenView.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.02.2021.
//  Copyright © 2021 Mikhail Semerikov. All rights reserved.
//

import UIKit

class SecondPageOnboardingMainScreenView: UIView {
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        let width = 0.4 * Session.width
        let image = UIImage(named: "WomenRightInCircle.pdf")
        let resizedImage = image?.resizeImage(width, opaque: false)
        imageView.image = resizedImage
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .black)
        label.text = "Нажав на эту кнопку, Вы попадете на экран расписания"
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    lazy var arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SecondPageArrow.pdf")
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
        [image, label, arrowImage]
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
        
        let labelConstraints = [
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            label.widthAnchor.constraint(equalToConstant: Session.width - 40),
            label.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let arrowImageConstraints = [
            arrowImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Session.width / 5),
            arrowImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            arrowImage.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            arrowImage.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ]
        
        [imageConstraints,
         labelConstraints,
         arrowImageConstraints]
            .forEach(NSLayoutConstraint.activate(_:))
    }
    
}
