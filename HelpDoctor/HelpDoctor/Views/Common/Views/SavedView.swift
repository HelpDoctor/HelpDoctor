//
//  SavedView.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 04.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class SavedView: UIView {
    private let icon = UIImageView()
    private let message = UILabel()
    
    convenience init(message: String) {
        self.init()
        self.message.text = message
        setupView()
        setupIcon()
        setupLabel()
    }
    
    private func setupView() {
        backgroundColor = .savedColor
        layer.cornerRadius = 5
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 4.0
        layer.masksToBounds = false
    }
    
    private func setupIcon() {
        let logoImageName = "Saved.pdf"
        guard let image = UIImage(named: logoImageName) else {
            assertionFailure("Missing ​​\(logoImageName) asset")
            return
        }
        icon.image = image
        addSubview(icon)
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        icon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupLabel() {
        message.font = UIFont.systemFontOfSize(size: 14)
        message.textColor = .white
        message.textAlignment = .center
        message.numberOfLines = 1
        addSubview(message)
        
        message.translatesAutoresizingMaskIntoConstraints = false
        message.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        message.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10).isActive = true
        message.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
}
