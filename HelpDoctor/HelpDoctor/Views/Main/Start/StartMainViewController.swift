//
//  StartMainViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 30.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class StartMainViewController: UIViewController {

    // MARK: - Dependency
    var presenter: StartMainPresenterProtocol?
    
    // MARK: - Constants
    private let enterProfileButton = EnterProfileButton(icon: UIImage(named: "Enter_Profile_Button.pdf"))
    private let newUserLabel = UILabel()
    private let topLine = UIView()
    private let userView = UIView() //Temporary
    private let newEventLabel = UILabel()
    private let bottomLine = UIView()
    private let eventView = UIView() //Temporary
    private let bottomLabel = UILabel()
    private let fillProfileButton = HDButton(title: "Заполнить профиль", fontSize: 14)
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    // MARK: - Lifecycle ViewController
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
        presenter?.profileCheck()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.statusBarBackgroundColor = .clear
        setImage(image: Session.instance.user?.foto?.toImage())
    }
    
    // MARK: - Public methods
    func hideFillProfileButton() {
        bottomLabel.isHidden = true
        fillProfileButton.isHidden = true
        enterProfileButton.isEnabled = true
    }
    
    func showFillProfileButton() {
        bottomLabel.isHidden = false
        fillProfileButton.isHidden = false
        enterProfileButton.isEnabled = false
    }
    
    func setImage(image: UIImage?) {
        let defaultImageName = "Enter_Profile_Button.pdf"
        guard let defaultImage = UIImage(named: defaultImageName) else {
            assertionFailure("Missing ​​\(defaultImageName) asset")
            return
        }
        enterProfileButton.setImage(image ?? defaultImage, for: .normal)
    }
    
    // MARK: - Setup views
    /// Установка кнопки заполнить профиль в заголовке формы
    private func setupEnterProfileButton() {
        enterProfileButton.addTarget(self, action: #selector(profileButtonPressed), for: .touchUpInside)
        view.addSubview(enterProfileButton)
        
        enterProfileButton.translatesAutoresizingMaskIntoConstraints = false
        enterProfileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: 10).isActive = true
        enterProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        enterProfileButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        enterProfileButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    /// Установка заголовка "Новые пользователи"
    private func setupNewUserLabel() {
        newUserLabel.font = UIFont.boldSystemFontOfSize(size: 14)
        newUserLabel.textColor = .white
        newUserLabel.text = "Новые пользователи"
        newUserLabel.textAlignment = .center
        view.addSubview(newUserLabel)
        
        newUserLabel.translatesAutoresizingMaskIntoConstraints = false
        newUserLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 63).isActive = true
        newUserLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newUserLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true
        newUserLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    /// Установка линии под заголовком
    private func setupTopLine() {
        topLine.backgroundColor = .hdLinkColor
        view.addSubview(topLine)
        
        topLine.translatesAutoresizingMaskIntoConstraints = false
        topLine.topAnchor.constraint(equalTo: newUserLabel.bottomAnchor, constant: 3).isActive = true
        topLine.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLine.widthAnchor.constraint(equalToConstant: 140).isActive = true
        topLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    /// Временная View
    private func setupUserView() {
        userView.backgroundColor = .white
        view.addSubview(userView)
        
        userView.translatesAutoresizingMaskIntoConstraints = false
        userView.topAnchor.constraint(equalTo: topLine.bottomAnchor, constant: 10).isActive = true
        userView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userView.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        userView.heightAnchor.constraint(equalToConstant: 170).isActive = true
    }
    
    /// Установка заголовка новые события
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
    
    /// Установка линии под заголовком
    private func setupBottomLine() {
        bottomLine.backgroundColor = .hdLinkColor
        view.addSubview(bottomLine)
        
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.topAnchor.constraint(equalTo: newEventLabel.bottomAnchor, constant: 3).isActive = true
        bottomLine.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomLine.widthAnchor.constraint(equalToConstant: 140).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    /// Временная View
    private func setupEventView() {
        eventView.backgroundColor = .white
        view.addSubview(eventView)
        
        eventView.translatesAutoresizingMaskIntoConstraints = false
        eventView.topAnchor.constraint(equalTo: bottomLine.bottomAnchor, constant: 10).isActive = true
        eventView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        eventView.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        eventView.heightAnchor.constraint(equalToConstant: 68).isActive = true
    }
    
    /// Установка подписи под формой с новыми событиями
    private func setupBottomLabel() {
        bottomLabel.font = UIFont.systemFontOfSize(size: 12)
        bottomLabel.textColor = .white
        //swiftlint:disable line_length
        bottomLabel.text = "Для того чтобы стать частью медицинского сообщества HelpDoctor нужно указать информацию о себе, заполнив профиль"
        //swiftlint:enable line_length
        bottomLabel.textAlignment = .left
        bottomLabel.numberOfLines = 0
        bottomLabel.isHidden = true
        view.addSubview(bottomLabel)
        
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.topAnchor.constraint(equalTo: eventView.bottomAnchor, constant: 9).isActive = true
        bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomLabel.widthAnchor.constraint(equalToConstant: width - 42).isActive = true
        bottomLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    /// Установка кнопки Заполнить профиль
    private func setupFillProfileButton() {
        fillProfileButton.addTarget(self, action: #selector(fillProfileButtonPressed), for: .touchUpInside)
        fillProfileButton.isEnabled = true
        fillProfileButton.isHidden = true
        view.addSubview(fillProfileButton)

        fillProfileButton.translatesAutoresizingMaskIntoConstraints = false
        fillProfileButton.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 10).isActive = true
        fillProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fillProfileButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        fillProfileButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    // MARK: - Buttons methods
    /// Отработка нажатия кнопки Заполнить профиль
    @objc private func fillProfileButtonPressed() {
        presenter?.fillProfile()
    }
    
    /// Отработка нажатия кнопки Профиль
    @objc private func profileButtonPressed() {
        presenter?.toProfile()
    }

}
