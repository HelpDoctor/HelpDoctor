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
    let titleLabel = UILabel()
    private weak var presenter: Presenter?
    private var font = UIFont.titleFont(size: 24)
    private var heightHeader = 0.f
    
    convenience init(title: String, color: UIColor, height: CGFloat, presenter: Presenter?) {
        self.init()
        self.titleLabel.text = title
        self.presenter = presenter
        self.heightHeader = height
        backgroundColor = color
        UIApplication.shared.setStatusBarBackgroundColor(color: color)
        setupBackButton()
        setupTitle()
        setupLogo()
    }
    
    convenience init(title: String, color: UIColor, height: CGFloat, presenter: Presenter?, font: UIFont) {
        self.init()
        self.titleLabel.text = title
        self.presenter = presenter
        self.heightHeader = height
        self.font = font
        backgroundColor = color
        UIApplication.shared.setStatusBarBackgroundColor(color: color)
        setupBackButton()
        setupTitle()
        setupLogo()
    }
    
    convenience init(height: CGFloat, presenter: Presenter?) {
        self.init()
        self.titleLabel.text = "HelpDoctor"
        self.presenter = presenter
        self.heightHeader = height
        self.font = .titleFont(size: 24)
        backgroundColor = UIColor.backgroundColor
        UIApplication.shared.setStatusBarBackgroundColor(color: UIColor.backgroundColor)
        setupBackButton()
        setupTitle()
        setupLogo()
        backButton.setImage(UIImage(named: "Cross"), for: .normal)
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
        titleLabel.font = font
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        self.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    private func setupLogo() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLogo))
        let trailing = heightHeader * 0.2
        let height = heightHeader * 0.75
        let logoImageName = "Logo.pdf"
        guard let image = UIImage(named: logoImageName) else {
            assertionFailure("Missing ​​\(logoImageName) asset")
            return
        }
        logoImage.addGestureRecognizer(tap)
        logoImage.image = image
        logoImage.isUserInteractionEnabled = true
        self.addSubview(logoImage)
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        logoImage.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                            constant: -trailing).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: height).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    @objc private func tapLogo() {
        presenter?.toProfile()
    }
    
    @objc private func backButtonPressed() {
        presenter?.back()
    }
}
