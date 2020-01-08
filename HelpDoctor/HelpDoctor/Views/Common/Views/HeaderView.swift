//
//  HeaderView.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    private let session = Session.instance
    private let logoImage = UIImageView()
    private let titleLabel = UILabel()
    private let userImage = UIImageView()
    
    convenience init(title: String) {
        self.init()
        self.titleLabel.text = title
        UIApplication.statusBarBackgroundColor = .clear
        userImage.isHidden = true
        setupLogo()
        setupTitle()
    }
    
    convenience init(title: String, withAvatar: Bool = true) {
        self.init()
        self.titleLabel.text = title
        UIApplication.statusBarBackgroundColor = .clear
        userImage.isHidden = !withAvatar
        setupLogo()
        setupTitle()
        setupUserImage()
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
    
    private func setupUserImage() {
        userImage.image = session.user?.foto?.toImage()
        self.addSubview(userImage)
        
        userImage.layer.cornerRadius = 20
        userImage.contentMode = .scaleAspectFill
        userImage.layer.masksToBounds = true
        
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        userImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
}
