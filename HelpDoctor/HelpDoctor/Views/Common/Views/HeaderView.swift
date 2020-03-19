//
//  HeaderView.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    private let backButton = UIButton()
    private let logoImage = UIImageView()
    private let titleLabel = UILabel()
    private var presenter: Presenter?
    private var heightHeader = 0.f
    
    convenience init(title: String, color: UIColor, height: CGFloat, presenter: Presenter?) {
        self.init()
        self.titleLabel.text = title
        self.presenter = presenter
        self.heightHeader = height
        backgroundColor = color
        UIApplication.statusBarBackgroundColor = .tabBarColor
        setupBackButton()
        setupTitle()
        setupLogo()
    }
    
    private func setupBackButton() {
        let leading = 10.f
        let width = 20.f
        backButton.setImage(UIImage(named: "Back.pdf"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        self.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                            constant: leading).isActive = true
        backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: width).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: width).isActive = true
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
    
    private func setupLogo() {
        let top = 10.f
        let height = heightHeader - (2 * top)
        let logoImageName = "Logo.pdf"
        guard let image = UIImage(named: logoImageName) else {
            assertionFailure("Missing ​​\(logoImageName) asset")
            return
        }
        logoImage.image = image
        self.addSubview(logoImage)
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.topAnchor.constraint(equalTo: self.topAnchor,
                                       constant: top).isActive = true
        logoImage.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                            constant: -top).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: height).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    @objc private func backButtonPressed() {
        presenter?.back()
    }
    
}
