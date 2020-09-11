//
//  AlertView.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class AlertView: UIView {
    private let problemIcon = UIImageView()
    private let message = UILabel()
    
    convenience init(message: String) {
        self.init()
        self.message.text = message
        setupView()
        setupProblemIcon()
        setupLabel()
    }
    
    private func setupView() {
        backgroundColor = .alertColor
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.shadowColor.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 4.0
        layer.masksToBounds = false
    }
    
    private func setupProblemIcon() {
        let logoImageName = "Problem.pdf"
        guard let image = UIImage(named: logoImageName) else {
            assertionFailure("Missing ​​\(logoImageName) asset")
            return
        }
        problemIcon.image = image
        addSubview(problemIcon)
        
        problemIcon.translatesAutoresizingMaskIntoConstraints = false
        problemIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 9).isActive = true
        problemIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 9).isActive = true
        problemIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        problemIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupLabel() {
        message.font = UIFont.systemFontOfSize(size: 12)
        message.textColor = .white
        message.textAlignment = .left
        message.numberOfLines = 0
        addSubview(message)
        
        message.translatesAutoresizingMaskIntoConstraints = false
        message.topAnchor.constraint(equalTo: self.topAnchor, constant: 7).isActive = true
        message.leadingAnchor.constraint(equalTo: problemIcon.trailingAnchor, constant: 5).isActive = true
        message.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        message.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7).isActive = true
    }
}
