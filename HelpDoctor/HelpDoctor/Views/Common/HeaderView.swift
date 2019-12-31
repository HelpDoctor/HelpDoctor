//
//  HeaderView.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    private let logoImage = UIImageView()
    private let titleLabel = UILabel()
    
    convenience init(title: String) {
        self.init()
        self.titleLabel.text = title
        setupLogo()
        setupTitle()
    }
    
    private func setupLogo() {
        let logoImageName = "Logo.pdf"
        guard let image = UIImage(named: logoImageName) else {
            assertionFailure("Missing ​​\(logoImageName) asset")
            return
        }
        logoImage.image = image
        self.addSubview(logoImage)
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        logoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupTitle() {
        titleLabel.font = UIFont.titleFont(size: 24)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        self.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
}
