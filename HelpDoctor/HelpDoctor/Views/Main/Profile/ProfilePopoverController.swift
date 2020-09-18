//
//  ProfilePopoverController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 02.04.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol ProfilePopoverDelegate: class {
    func toEditProfile()
    func getStatusUser()
    func logout()
}

class ProfilePopoverController: UIViewController {
    
    weak var delegate: ProfilePopoverDelegate?
    private let editProfileButton = ProfilePopoverButton(text: "Редактировать профиль",
                                                         image: UIImage(named: "EditProfile"))
    private let verificateProfileButton = ProfilePopoverButton(text: "Верифицировать профиль",
                                                               image: UIImage(named: "VerificationMarkPopover"))
    private let exitProfileButton = ProfilePopoverButton(text: "Выйти из профиля",
                                                         image: UIImage(named: "ExitProfile"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.171, green: 0.521, blue: 0.758, alpha: 1)
        setupEditProfileButton()
        setupVerificateButton()
        setupExitProfileButton()
    }
    
    override var preferredContentSize: CGSize {
        get {
            return super.preferredContentSize
        }
        set {
            super.preferredContentSize = newValue
        }
    }
    
    private func setupEditProfileButton() {
        let editTap = UITapGestureRecognizer(target: self, action: #selector(editProfilePressed(tap:)))
        editProfileButton.addGestureRecognizer(editTap)
        editProfileButton.isUserInteractionEnabled = true
        view.addSubview(editProfileButton)
        
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        editProfileButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        editProfileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        editProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        editProfileButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 3).isActive = true
    }
    
    private func setupVerificateButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(verificateProfilePressed(tap:)))
        verificateProfileButton.addGestureRecognizer(tap)
        verificateProfileButton.isUserInteractionEnabled = true
        view.addSubview(verificateProfileButton)
        
        verificateProfileButton.translatesAutoresizingMaskIntoConstraints = false
        verificateProfileButton.topAnchor.constraint(equalTo: editProfileButton.bottomAnchor).isActive = true
        verificateProfileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        verificateProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        verificateProfileButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 3).isActive = true
    }
    
    private func setupExitProfileButton() {
        let exitTap = UITapGestureRecognizer(target: self, action: #selector(exitProfilePressed(tap:)))
        exitProfileButton.addGestureRecognizer(exitTap)
        exitProfileButton.isUserInteractionEnabled = true
        view.addSubview(exitProfileButton)
        
        exitProfileButton.translatesAutoresizingMaskIntoConstraints = false
        exitProfileButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        exitProfileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        exitProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        exitProfileButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 3).isActive = true
    }
    
    @objc private func editProfilePressed(tap: UITapGestureRecognizer) {
        delegate?.toEditProfile()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func verificateProfilePressed(tap: UITapGestureRecognizer) {
        delegate?.getStatusUser()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func exitProfilePressed(tap: UITapGestureRecognizer) {
        delegate?.logout()
        dismiss(animated: true, completion: nil)
    }
    
}
