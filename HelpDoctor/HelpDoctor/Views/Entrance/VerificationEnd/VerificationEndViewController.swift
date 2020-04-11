//
//  VerificationEndViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 09.03.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class VerificationEndViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: VerificationEndPresenterProtocol?
    
    // MARK: - Constants and variables
    private let logoImage = UIImageView()
    private let doctorsImage = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let textLabel = UILabel()
    private let okButton = HDButton(title: "Ок")
    private let backButton = BackButton()
    private let widthLabel = Session.width - 22.f
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupLogoImage()
        setupDoctorsImage()
        setupTitleLabel()
        setupSubtitleLabel()
        setupTopLabel()
        setupOkButton()
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
        let width = Session.width - 30
        let imageName = "VerificationImage.pdf"
        guard let image = UIImage(named: imageName) else {
            assertionFailure("Missing ​​\(imageName) asset")
            return
        }
        let resizedImage = image.resizeImage(width, opaque: false)
        doctorsImage.image = resizedImage
        view.addSubview(doctorsImage)
        
        doctorsImage.translatesAutoresizingMaskIntoConstraints = false
        doctorsImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        doctorsImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doctorsImage.widthAnchor.constraint(equalToConstant: resizedImage.size.width).isActive = true
        doctorsImage.heightAnchor.constraint(equalToConstant: resizedImage.size.height).isActive = true
    }
    
    /// Установка заголовка
    private func setupTitleLabel() {
        let top = 5.f
        let height = 22.f
        titleLabel.font = .boldSystemFontOfSize(size: 18)
        titleLabel.textColor = .white
        titleLabel.text =
        """
        Верификация
        """
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: doctorsImage.bottomAnchor,
                                        constant: top).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка заголовка
    private func setupSubtitleLabel() {
        let top = 5.f
        let height = 17.f
        subtitleLabel.font = .mediumSystemFontOfSize(size: 14)
        subtitleLabel.textColor = .hdButtonColor
        subtitleLabel.text =
        """
        На рассмотрении
        """
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        view.addSubview(subtitleLabel)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                        constant: top).isActive = true
        subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subtitleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        subtitleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка надписи
    private func setupTopLabel() {
        let top = 16.f
        let height = 120.f
        textLabel.font = .systemFontOfSize(size: 14)
        textLabel.textColor = .white
        textLabel.text =
        """
        Спасибо за предоставленную информацию!\n
        Пожалуйста, дождитесь результатов верификации. \
        Мы уведомим Вас о завершении процедуры проверки по указанному Вами адресу электронной почты
        """
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 0
        view.addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor,
                                       constant: top).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textLabel.widthAnchor.constraint(equalToConstant: widthLabel).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка кнопки Ок
    private func setupOkButton() {
        let top = 20.f
        let width = 150.f
        let height = 35.f
        okButton.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
        okButton.update(isEnabled: true)
        view.addSubview(okButton)
        
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor,
                                      constant: top).isActive = true
        okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        okButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: height).isActive = true
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
    /// Обработка нажатия кнопки "Ок"
    @objc private func okButtonPressed() {
        presenter?.back()
    }
    
    /// Обработка нажатия кнопки "Назад"
    @objc private func backButtonPressed() {
        presenter?.back()
    }
    
}
