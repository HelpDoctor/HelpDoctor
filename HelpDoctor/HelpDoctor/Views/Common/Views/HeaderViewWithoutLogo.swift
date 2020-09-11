//
//  HeaderViewWithoutLogo.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//
/*
import UIKit

class HeaderViewWithoutLogo: UIView {
    private let backButton = UIButton()
    private var titleLabel = UILabel()
    private var textLabel = UILabel()
    private var userImage = UIImageView()
    private var presenter: Presenter?
    
    convenience init(title: String, text: String?, userImage: String?, presenter: Presenter?) {
        self.init()
        self.titleLabel.text = title
        self.textLabel.text = text
        self.userImage.image = UIImage(named: userImage ?? "Avatar.pdf")
        self.presenter = presenter
        backgroundColor = .tabBarColor
//        UIApplication.statusBarBackgroundColor = .tabBarColor
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
        setupBackButton()
        setupTitle()
        setupUserImage()
        setupText()
    }
    
    convenience init(title: String, presenter: Presenter?) {
        self.init()
        self.titleLabel.text = title
        self.userImage.image = UIImage(named: "Logo.pdf")
        self.presenter = presenter
        backgroundColor = .backgroundColor
        UIApplication.shared.setStatusBarBackgroundColor(color: .backgroundColor)
        setupBackButton()
        setupTitle()
        setupUserImage()
        setupText()
    }
    
    private func setupBackButton() {
        backButton.setImage(UIImage(named: "Back.pdf"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        self.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 13).isActive = true
        backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 13).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    private func setupTitle() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        self.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        if textLabel.text == nil {
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        } else {
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 6).isActive = true
            titleLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        }
    }
    
    private func setupText() {
        textLabel.font = UIFont.systemFontOfSize(size: 12)
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 1
        self.addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 5).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: userImage.leadingAnchor, constant: -5).isActive = true
        textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
    }
    
    private func setupUserImage() {
//        userImage.image = Session.instance.user?.foto?.toImage()
        self.addSubview(userImage)
        
        userImage.layer.cornerRadius = 20
        userImage.contentMode = .scaleAspectFill
        userImage.layer.masksToBounds = true
        
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        userImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc private func backButtonPressed() {
        presenter?.back()
    }
    
}
*/
