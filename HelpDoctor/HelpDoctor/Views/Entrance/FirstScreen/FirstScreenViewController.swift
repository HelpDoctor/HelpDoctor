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
    private let titleLabel = UILabel()
    private let topLabel = UILabel()
    private let bottomLabel = UILabel()
    private var loginButton = HDButton()
    private var registerButton = HDButton()
    
    private let widthLabel: CGFloat = Session.width - 60
    private let widthButton: CGFloat = 150
    private let heightButton: CGFloat = 35
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupHeaderView()
        setupTitleLabel()
        setupTopLabel()
        setupBottomLabel()
        setupLoginButton()
        setupRegisterButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Setup views
    /// Установка заголовка
    private func setupTitleLabel() {
        let top: CGFloat = 114
        let height: CGFloat = 22
        titleLabel.font = UIFont.boldSystemFontOfSize(size: 18)
        titleLabel.textColor = .white
        titleLabel.text = "Добро пожаловать!"
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: top).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: widthLabel).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка верхней надписи
    private func setupTopLabel() {
        let top: CGFloat = 57
        let height: CGFloat = 51
        topLabel.font = UIFont.systemFontOfSize(size: 14)
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
    
    /// Установка нижней надписи
    private func setupBottomLabel() {
        let top: CGFloat = 17
        let height: CGFloat = 51
        var label = String()
        label = "Чтобы воспользоваться функциями приложения, войдите в существующий аккаунт или пройдите регистрацию."
        bottomLabel.font = UIFont.systemFontOfSize(size: 14)
        bottomLabel.textColor = .white
        bottomLabel.text = label
        bottomLabel.textAlignment = .left
        bottomLabel.numberOfLines = 0
        view.addSubview(bottomLabel)
        
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                         constant: top).isActive = true
        bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomLabel.widthAnchor.constraint(equalToConstant: widthLabel).isActive = true
        bottomLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка кнопки "Войти"
    private func setupLoginButton() {
        let top: CGFloat = 71
        loginButton = HDButton(title: "Войти")
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor,
                                         constant: top).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    /// Установка кнопки "Регистрация"
    private func setupRegisterButton() {
        let top: CGFloat = 35
        registerButton = HDButton(title: "Регистрация")
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        view.addSubview(registerButton)
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor,
                                            constant: top).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
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
