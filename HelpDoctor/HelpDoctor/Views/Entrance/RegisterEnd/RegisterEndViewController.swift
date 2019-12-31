//
//  RegisterEndViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class RegisterEndViewController: UIViewController {
    
    // MARK: - Dependency
//    var coordinator: RegisterEndCoordinatorProtocol?
    var presenter: RegisterEndPresenterProtocol?
    
    // MARK: - Constants
    private let backgroundImage = UIImageView()
    private var headerView = HeaderView()
    private let titleLabel = UILabel()
    private let topLabel = UILabel()
    private let bottomLabel = UILabel()
    private let topEmailTextField = UITextField()
    private let textFieldLabel = UILabel()
    private let bottomEmailTextField = UITextField()
    private var loginButton = HDButton()
    private let backButton = UIButton()
    
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
        setupBackButton()
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
        titleLabel.text = "Регистрация"
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
        topLabel.text = "Регистрация пройдена! \nПароль для входа в приложение был выслан на указанный Вами E-mail"
        topLabel.textAlignment = .left
        topLabel.numberOfLines = 0
        view.addSubview(topLabel)
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                      constant: 45).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLabel.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 51).isActive = true
    }
    
    private func setupBottomLabel() {
        bottomLabel.font = UIFont.systemFontOfSize(size: 14)
        bottomLabel.textColor = .white
        bottomLabel.text = "Теперь Вы можете войти, используя вашу почту и пароль"
        bottomLabel.textAlignment = .left
        bottomLabel.numberOfLines = 0
        view.addSubview(bottomLabel)
        
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                         constant: 17).isActive = true
        bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomLabel.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        bottomLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    private func setupLoginButton() {
        loginButton = HDButton(title: "Войти")
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor,
                                            constant: 39).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func setupBackButton() {
        let titleButton = "< Назад"
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.titleLabel?.font = UIFont.boldSystemFontOfSize(size: 18)
        backButton.titleLabel?.textColor = .white
        backButton.setTitle(titleButton, for: .normal)
        view.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36).isActive = true
        backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -38).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    // MARK: - IBActions
    // MARK: - Buttons methods
    @objc private func loginButtonPressed() {
        print("pressed")
        presenter?.login()
    }
    
    @objc private func backButtonPressed() {
        presenter?.back()
    }
    
    // MARK: - Navigation
}
