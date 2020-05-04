//
//  InfoView.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 30.04.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class InfoView: UIView {
    private let contentView = UIView()
    private let topView = UIView()
    private let problemIcon = UIImageView()
    private let message = UILabel()
    private let button = HDButton(title: "Закрыть", fontSize: 14)
    private let inset = 10.f
    private let topViewHeight = 45.f
    private var labelHeight = 0.f
    private let contentViewWidth = Session.width - 60
    private var contentViewHeight = 180.f
    private let buttonHeight = 44.f
    
//    convenience init(message: String) {
//        self.init()
//        self.message.text = message
//        labelHeight = message.height(withConstrainedWidth: contentViewWidth, font: .systemFontOfSize(size: 12))
//        contentViewHeight = topViewHeight + (inset * 3) + labelHeight + buttonHeight
//        backgroundColor = .clear
//        setupView()
//        setupProblemIcon()
//        setupLabel()
//        setupButton()
//    }
    
    convenience init(message: String, buttonTitle: String, iconName: String) {
        self.init()
        self.message.text = message
        button.setTitle(buttonTitle, for: .normal)
        labelHeight = message.height(withConstrainedWidth: contentViewWidth, font: .systemFontOfSize(size: 12))
        contentViewHeight = topViewHeight + (inset * 3) + labelHeight + buttonHeight
        backgroundColor = .clear
        setupView()
        setupProblemIcon(iconName)
        setupLabel()
        setupButton()
    }
    
    private func setupView() {
        let cornerRadius = 15.f
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowOpacity = 1.0
        contentView.layer.shadowRadius = 10.0
        contentView.layer.masksToBounds = false
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: contentViewWidth).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: contentViewHeight).isActive = true
        
        topView.backgroundColor = .hdButtonColor
        topView.layer.cornerRadius = cornerRadius
        topView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        contentView.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: topViewHeight).isActive = true
    }
    
    private func setupProblemIcon(_ iconName: String) {
//        let logoImageName = "Problem.pdf"
        guard let image = UIImage(named: iconName) else {
            assertionFailure("Missing ​​\(iconName) asset")
            return
        }
        problemIcon.image = image
        topView.addSubview(problemIcon)
        
        problemIcon.translatesAutoresizingMaskIntoConstraints = false
        problemIcon.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        problemIcon.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        problemIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        problemIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupLabel() {
        message.font = .systemFontOfSize(size: 11)
        message.textColor = .black
        message.textAlignment = .left
        message.numberOfLines = 0
        contentView.addSubview(message)
        
        message.translatesAutoresizingMaskIntoConstraints = false
        message.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: inset).isActive = true
        message.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset).isActive = true
        message.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset).isActive = true
        message.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true
    }
    
    private func setupButton() {
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        contentView.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset).isActive = true
        button.widthAnchor.constraint(equalToConstant: 110).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
}
