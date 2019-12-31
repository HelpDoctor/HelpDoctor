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
    
    // MARK: - Constants
    private let backgroundImage = UIImageView()
    private var headerView = HeaderView()
    private let titleLabel = UILabel()
    private let topLabel = UILabel()
    private let bottomLabel = UILabel()
    private var loginButton = HDButton()
    private var registerButton = HDButton()
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
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
    
    // MARK: - Puplic methods
    // MARK: - Private methods
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
    
    private func setupTitleLabel() {
        titleLabel.font = UIFont.boldSystemFontOfSize(size: 18)
        titleLabel.textColor = .white
        titleLabel.text = "Добро пожаловать!"
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 54).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    private func setupTopLabel() {
        topLabel.font = UIFont.systemFontOfSize(size: 14)
        topLabel.textColor = .white
        topLabel.text = "HelpDoctor - это приложение, специально разработанное для врачей и медицинских сотрудников."
        topLabel.textAlignment = .left
        topLabel.numberOfLines = 0
        view.addSubview(topLabel)
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                      constant: 57).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLabel.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 51).isActive = true
    }
    
    private func setupBottomLabel() {
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
                                         constant: 17).isActive = true
        bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomLabel.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        bottomLabel.heightAnchor.constraint(equalToConstant: 51).isActive = true
    }
    
    private func setupLoginButton() {
        loginButton = HDButton(title: "Войти")
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor,
                                         constant: 71).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func setupRegisterButton() {
        registerButton = HDButton(title: "Регистрация")
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        view.addSubview(registerButton)
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor,
                                            constant: 35).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    // MARK: - IBActions
    // MARK: - Buttons methods
    @objc private func registerButtonPressed() {
        presenter?.register()
    }
    
    @objc private func loginButtonPressed() {
        presenter?.login()
    }
    
    // MARK: - Navigation
}
