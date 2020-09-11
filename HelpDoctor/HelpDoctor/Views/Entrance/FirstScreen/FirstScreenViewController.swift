//
//  FirstScreenViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 27.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class FirstScreenViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: FirstScreenPresenterProtocol?
    
    // MARK: - Constants and variables
    private let logoImage = UIImageView()
    private let doctorsImage = UIImageView()
    private let logoLabel = UILabel()
    private let titleLabel = UILabel()
    private let topLabel = UILabel()
    private var loginButton = HDButton(title: "Войти", fontSize: 16)
    private var registerButton = HDButton(title: "Новый пользователь", fontSize: 16)
    
    private let widthLabel = Session.width - 40.f
    private let widthButton = 148.f
    private let heightButton = 44.f
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupLogoImage()
        setupDoctorsImage()
        setupLogoLabel()
        setupTitleLabel()
        setupTopLabel()
        setupRegisterButton()
        setupLoginButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .clear)
    }
    
    // MARK: - Setup views
    /// Установка логотипа приложения
    private func setupLogoImage() {
        let top = 10.f
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
        logoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                            constant: -top).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: width).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    /// Установка картинки
    private func setupDoctorsImage() {
        let width = 0.9 * Session.width
        let imageName = "Doctors.pdf"
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
    
    /// Установка названия приложения
    private func setupLogoLabel() {
        let top = 10.f
        let height = 30.f
        logoLabel.font = .boldSystemFontOfSize(size: 24)
        logoLabel.textColor = .white
        logoLabel.text = "HelpDoctor"
        logoLabel.textAlignment = .center
        view.addSubview(logoLabel)
        
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.topAnchor.constraint(equalTo: doctorsImage.bottomAnchor,
                                       constant: top).isActive = true
        logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoLabel.widthAnchor.constraint(equalToConstant: widthLabel).isActive = true
        logoLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка заголовка
    private func setupTitleLabel() {
        let top = 2.f
        let height = 22.f
        titleLabel.font = .boldSystemFontOfSize(size: 18)
        titleLabel.textColor = .white
        titleLabel.text = "Добро пожаловать!"
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor,
                                        constant: top).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: widthLabel).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка верхней надписи
    private func setupTopLabel() {
        let top = 18.f
        let height = 51.f
        topLabel.font = .systemFontOfSize(size: 14)
        topLabel.textColor = .white
        topLabel.text = "HelpDoctor - это приложение, специально разработанное для врачей и медицинских сотрудников."
        topLabel.textAlignment = .left
        topLabel.numberOfLines = 0
        view.addSubview(topLabel)
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                      constant: top).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLabel.widthAnchor.constraint(equalToConstant: widthLabel).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка кнопки "Регистрация"
    private func setupRegisterButton() {
        let bottom = 97.f
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        registerButton.titleLabel?.numberOfLines = 2
        registerButton.titleLabel?.textAlignment = .center
        view.addSubview(registerButton)
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                               constant: -bottom).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    /// Установка кнопки "Войти"
    private func setupLoginButton() {
        let top = 20.f
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor,
                                         constant: top).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    // MARK: - Buttons methods
    /// Обработка нажатия кнопки "Регистрация"
    @objc private func registerButtonPressed() {
        presenter?.register()
    }
    
    /// Обработка нажатия кнопки "Войти"
    @objc private func loginButtonPressed() {
        presenter?.login()
    }
    
}
