//
//  VerificationOkViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 11.04.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class VerificationOkViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: VerificationOkPresenterProtocol?
    
    // MARK: - Constants and variables
    private let logoImage = UIImageView()
    private let doctorsImage = UIImageView()
    private let cloudImage = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let topLabel = UILabel()
    private let label = UILabel()
    private let sendButton = HDButton(title: "Ок")
    private let backButton = BackButton()
    private var heightCloudImage = 0.f
    
    private var topConstraintImage: NSLayoutConstraint?
    private var widthConstraintImage: NSLayoutConstraint?
    private var heightConstraintImage: NSLayoutConstraint?
    private var heightConstraintLabel: NSLayoutConstraint?
    private var topConstraintSendButton: NSLayoutConstraint?
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupLogoImage()
        setupDoctorsImage()
        setupCloudImage()
        setupTitleLabel()
        setupSubtitleLabel()
        setupTopLabel()
        setupLabel()
        setupSendButton()
        if #available(iOS 13.0, *) {} else {
            setupBackButton()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Setup views
    /// Установка логотипа приложения
    private func setupLogoImage() {
        let top = 10.f
        let leading = Session.width - top
        let width = 50.f
        let imageName = "Logo.pdf"
        guard let image = UIImage(named: imageName) else {
            assertionFailure("Missing ​​\(imageName) asset")
            return
        }
        logoImage.image = image
        view.addSubview(logoImage)
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                       constant: top).isActive = true
        logoImage.trailingAnchor.constraint(equalTo: view.leadingAnchor,
                                            constant: leading).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: width).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    /// Установка картинки
    private func setupDoctorsImage() {
        let top = 25.f
        let width = Session.width - 140
        let imageName = "VerificationOk"
        guard let image = UIImage(named: imageName) else {
            assertionFailure("Missing ​​\(imageName) asset")
            return
        }
        let resizedImage = image.resizeImage(width, opaque: false)
        doctorsImage.image = resizedImage
        view.addSubview(doctorsImage)
        
        doctorsImage.translatesAutoresizingMaskIntoConstraints = false
        doctorsImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                          constant: top).isActive = true
        doctorsImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doctorsImage.widthAnchor.constraint(equalToConstant: resizedImage.size.width).isActive = true
        doctorsImage.heightAnchor.constraint(equalToConstant: resizedImage.size.height).isActive = true
    }
    
    private func setupCloudImage() {
        let top = 10.f
        let width = Session.width - 70
        let imageName = "Cloud"
        guard let image = UIImage(named: imageName) else {
            assertionFailure("Missing ​​\(imageName) asset")
            return
        }
        let resizedImage = image.resizeImage(width, opaque: false)
        cloudImage.image = resizedImage
        heightCloudImage = resizedImage.size.height
        view.addSubview(cloudImage)
        
        cloudImage.translatesAutoresizingMaskIntoConstraints = false
        cloudImage.topAnchor.constraint(equalTo: doctorsImage.bottomAnchor,
                                        constant: -top).isActive = true
        cloudImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cloudImage.widthAnchor.constraint(equalToConstant: resizedImage.size.width).isActive = true
        cloudImage.heightAnchor.constraint(equalToConstant: resizedImage.size.height).isActive = true
    }
    
    /// Установка заголовка
    private func setupTitleLabel() {
        let top = heightCloudImage * (26 / 70)
        let height = 22.f
        titleLabel.font = .boldSystemFontOfSize(size: 18)
        titleLabel.textColor = .hdGreenColor
        titleLabel.text = "Верификация"
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: cloudImage.topAnchor,
                                        constant: top).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка подзаголовка
    private func setupSubtitleLabel() {
        let bottom = heightCloudImage * (6 / 70)
        let height = 17.f
        subtitleLabel.font = .mediumSystemFontOfSize(size: 14)
        subtitleLabel.textColor = .hdGreenColor
        subtitleLabel.text = "пройдена"
        subtitleLabel.textAlignment = .center
        view.addSubview(subtitleLabel)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.bottomAnchor.constraint(equalTo: cloudImage.bottomAnchor,
                                              constant: -bottom).isActive = true
        subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subtitleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        subtitleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupTopLabel() {
        let top = 5.f
        let height = 17.f
        topLabel.font = .mediumSystemFontOfSize(size: 14)
        topLabel.textColor = .white
        topLabel.text = "Вы уже верифицированы"
        topLabel.textAlignment = .center
        view.addSubview(topLabel)
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: cloudImage.bottomAnchor,
                                      constant: top).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка описания
    private func setupLabel() {
        let top = 4.f
        let width = Session.width - 22.f
        let height = 85.f
        label.font = .systemFontOfSize(size: 14)
        label.textColor = .white
        label.text =
        """
        Поздравляем! Теперь Вы можете воспользоваться расширенными функциями сервиса HelpDoctor, \
        например, найти своих давних коллег и возобновить общение. А также многое другое!
        """
        label.textAlignment = .left
        label.numberOfLines = 0
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                   constant: top).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: width).isActive = true
        label.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка кнопки "Ок"
    private func setupSendButton() {
        let top = 20.f
        let width = 150.f
        let height = 35.f
        sendButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        sendButton.update(isEnabled: true)
        view.addSubview(sendButton)
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        sendButton.topAnchor.constraint(equalTo: label.bottomAnchor,
                                        constant: top).isActive = true
    }
    
    /// Установка кнопки назад
    private func setupBackButton() {
        let leading = 8.f
        let top = 10.f
        let width = 57.f
        let height = 21.f
        let tap = UITapGestureRecognizer(target: self, action: #selector(backButtonPressed))
        backButton.addGestureRecognizer(tap)
        view.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                            constant: leading).isActive = true
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: top).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    // MARK: - Buttons methods
    /// Обработка нажатия кнопки "Отправить"
    @objc private func registerButtonPressed() {
        presenter?.back()
    }
    
    /// Обработка нажатия кнопки "Назад"
    @objc private func backButtonPressed() {
        presenter?.back()
    }
    
}
