//
//  UserPopoverController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 30.11.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol UserPopoverDelegate: class {
    func addContact()
    func shareContact()
    func blockContact()
}

class UserPopoverController: UIViewController {
    
    weak var delegate: UserPopoverDelegate?
    private let addButton = ProfilePopoverButton(text: "Добавить в контакты",
                                                 image: UIImage(named: "AddContact"))
    private let shareButton = ProfilePopoverButton(text: "Поделится контактом",
                                                   image: UIImage(named: "ShareContact"))
    private let blockButton = ProfilePopoverButton(text: "Заблокировать пользователя",
                                                   image: UIImage(named: "BlockContact"))
    
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
        addButton.addGestureRecognizer(editTap)
        addButton.isUserInteractionEnabled = true
        view.addSubview(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        addButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 3).isActive = true
    }
    
    private func setupVerificateButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(verificateProfilePressed(tap:)))
        shareButton.addGestureRecognizer(tap)
        shareButton.isUserInteractionEnabled = true
        view.addSubview(shareButton)
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.topAnchor.constraint(equalTo: addButton.bottomAnchor).isActive = true
        shareButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        shareButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 3).isActive = true
    }
    
    private func setupExitProfileButton() {
        let exitTap = UITapGestureRecognizer(target: self, action: #selector(exitProfilePressed(tap:)))
        blockButton.addGestureRecognizer(exitTap)
        blockButton.isUserInteractionEnabled = true
        view.addSubview(blockButton)
        
        blockButton.translatesAutoresizingMaskIntoConstraints = false
        blockButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        blockButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        blockButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        blockButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 3).isActive = true
    }
    
    @objc private func editProfilePressed(tap: UITapGestureRecognizer) {
        delegate?.addContact()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func verificateProfilePressed(tap: UITapGestureRecognizer) {
        delegate?.shareContact()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func exitProfilePressed(tap: UITapGestureRecognizer) {
        delegate?.blockContact()
        dismiss(animated: true, completion: nil)
    }
}
