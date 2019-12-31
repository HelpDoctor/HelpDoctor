//
//  StartMainViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 30.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class StartMainViewController: UIViewController {

    var coordinator: StartMainCoordinatorProtocol?
    var presenter: StartMainPresenterProtocol?
    
    private let backgroundImage = UIImageView()
    private var headerView = HeaderView()
    private var enterProfileButton = EnterProfileButton()
    private let newUserLabel = UILabel()
    private let topLine = UIView()
    private let userView = UIView() //Temporary
    private let newEventLabel = UILabel()
    private let bottomLine = UIView()
    private let eventView = UIView() //Temporary
    private let bottomLabel = UILabel()
    private var fillProfileButton = HDButton()
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupHeaderView()
        setupEnterProfileButton()
        setupNewUserLabel()
        setupTopLine()
        setupUserView() //Temporary
        setupNewEventLabel()
        setupBottomLine()
        setupEventView() //Temporary
        setupBottomLabel()
        setupFillProfileButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupBackground() {
        let backgroundImageName = "Background.png"
        guard let image = UIImage(named: backgroundImageName) else {
            assertionFailure("Missing ​​\(backgroundImageName) asset")
            return
        }
        backgroundImage.image = image
        backgroundImage.frame = CGRect(x: 0, y: 0, width: width, height: height)
        view.addSubview(backgroundImage)
    }
    
    private func setupHeaderView() {
        headerView = HeaderView(title: "HelpDoctor")
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let leadingConstraint = headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingConstraint = headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let heightConstraint = headerView.heightAnchor.constraint(equalToConstant: 60)
        view.addConstraints([topConstraint, leadingConstraint, trailingConstraint, heightConstraint])
    }
    
    private func setupEnterProfileButton() {
        enterProfileButton = EnterProfileButton(icon: UIImage(named: "Enter_Profile_Button.pdf"))
        enterProfileButton.addTarget(self, action: #selector(fillProfileButtonPressed), for: .touchUpInside)
        view.addSubview(enterProfileButton)
        
        enterProfileButton.translatesAutoresizingMaskIntoConstraints = false
        enterProfileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: 10).isActive = true
        enterProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        enterProfileButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        enterProfileButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupNewUserLabel() {
        newUserLabel.font = UIFont.boldSystemFontOfSize(size: 14)
        newUserLabel.textColor = .white
        newUserLabel.text = "Новые пользователи"
        newUserLabel.textAlignment = .center
        view.addSubview(newUserLabel)
        
        newUserLabel.translatesAutoresizingMaskIntoConstraints = false
        newUserLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 3).isActive = true
        newUserLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newUserLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true
        newUserLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    private func setupTopLine() {
        topLine.backgroundColor = .hdLinkColor
        view.addSubview(topLine)
        
        topLine.translatesAutoresizingMaskIntoConstraints = false
        topLine.topAnchor.constraint(equalTo: newUserLabel.bottomAnchor, constant: 3).isActive = true
        topLine.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLine.widthAnchor.constraint(equalToConstant: 140).isActive = true
        topLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    private func setupUserView() {
        userView.backgroundColor = .white
        view.addSubview(userView)
        
        userView.translatesAutoresizingMaskIntoConstraints = false
        userView.topAnchor.constraint(equalTo: topLine.bottomAnchor, constant: 10).isActive = true
        userView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userView.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        userView.heightAnchor.constraint(equalToConstant: 170).isActive = true
    }
    
    private func setupNewEventLabel() {
        newEventLabel.font = UIFont.boldSystemFontOfSize(size: 14)
        newEventLabel.textColor = .white
        newEventLabel.text = "Новые события"
        newEventLabel.textAlignment = .center
        view.addSubview(newEventLabel)
        
        newEventLabel.translatesAutoresizingMaskIntoConstraints = false
        newEventLabel.topAnchor.constraint(equalTo: userView.bottomAnchor, constant: 11).isActive = true
        newEventLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newEventLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true
        newEventLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    private func setupBottomLine() {
        bottomLine.backgroundColor = .hdLinkColor
        view.addSubview(bottomLine)
        
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.topAnchor.constraint(equalTo: newEventLabel.bottomAnchor, constant: 3).isActive = true
        bottomLine.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomLine.widthAnchor.constraint(equalToConstant: 140).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    private func setupEventView() {
        eventView.backgroundColor = .white
        view.addSubview(eventView)
        
        eventView.translatesAutoresizingMaskIntoConstraints = false
        eventView.topAnchor.constraint(equalTo: bottomLine.bottomAnchor, constant: 10).isActive = true
        eventView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        eventView.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        eventView.heightAnchor.constraint(equalToConstant: 68).isActive = true
    }
    
    private func setupBottomLabel() {
        bottomLabel.font = UIFont.systemFontOfSize(size: 12)
        bottomLabel.textColor = .white
        //swiftlint:disable line_length
        bottomLabel.text = "Для того чтобы стать частью медицинского сообщества HelpDoctor нужно указать информацию о себе, заполнив профиль"
        //swiftlint:enable line_length
        bottomLabel.textAlignment = .left
        bottomLabel.numberOfLines = 0
        view.addSubview(bottomLabel)
        
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.topAnchor.constraint(equalTo: eventView.bottomAnchor, constant: 9).isActive = true
        bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomLabel.widthAnchor.constraint(equalToConstant: width - 42).isActive = true
        bottomLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    private func setupFillProfileButton() {
        fillProfileButton = HDButton(title: "Заполнить профиль", fontSize: 14)
        fillProfileButton.addTarget(self, action: #selector(fillProfileButtonPressed), for: .touchUpInside)
        fillProfileButton.isEnabled = true
        view.addSubview(fillProfileButton)

        fillProfileButton.translatesAutoresizingMaskIntoConstraints = false
        fillProfileButton.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 10).isActive = true
        fillProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fillProfileButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        fillProfileButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    @objc private func fillProfileButtonPressed() {
        coordinator?.fillProfile()
    }

}
