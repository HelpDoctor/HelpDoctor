//
//  LoginViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
//    var coordinator: LoginCoordinatorProtocol?
    var presenter: LoginPresenterProtocol?
    
    // MARK: - Constants
    private let scrollView = UIScrollView()
    private let backgroundImage = UIImageView()
    private var headerView = HeaderView()
    private let titleLabel = UILabel()
    private let label = UILabel()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let forgotButton = UIButton()
    private var loginButton = HDButton()
    private let backButton = UIButton()
    private var keyboardHeight: CGFloat = 0
    private var isKeyboardShown = false
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupScrollView()
        setupHeaderView()
        setupTitleLabel()
        setupLabel()
        setupEmailTextField()
        setupPasswordTextField()
        setupForgotButton()
        setupLoginButton()
        setupBackButton()
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self,
                                                         action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(hideKeyboardGesture)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown​),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
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
    
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: width, height: height)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: view.frame.size.height).isActive = true
    }
    
    private func setupHeaderView() {
        headerView = HeaderView(title: "HelpDoctor")
        scrollView.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        headerView.widthAnchor.constraint(equalToConstant: width).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func setupTitleLabel() {
        titleLabel.font = UIFont.boldSystemFontOfSize(size: 18)
        titleLabel.textColor = .white
        titleLabel.text = "Авторизация"
        titleLabel.textAlignment = .center
        scrollView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 54).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    private func setupLabel() {
        label.font = UIFont.systemFontOfSize(size: 14)
        label.textColor = .white
        label.text = "Для авторизации введите свой e-mail и ранее полученный пароль"
        label.textAlignment = .left
        label.numberOfLines = 0
        scrollView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 45).isActive = true
        label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        label.heightAnchor.constraint(equalToConstant: 51).isActive = true
    }
    
    private func setupEmailTextField() {
        emailTextField.font = UIFont.systemFontOfSize(size: 14)
        emailTextField.keyboardType = .emailAddress
        emailTextField.textColor = .textFieldTextColor
        emailTextField.placeholder = "E-mail*"
        emailTextField.textAlignment = .left
        emailTextField.backgroundColor = .white
        emailTextField.layer.cornerRadius = 5
        emailTextField.leftView = UIView(frame: CGRect(x: 0,
                                                          y: 0,
                                                          width: 8,
                                                          height: emailTextField.frame.height))
        emailTextField.leftViewMode = .always
        scrollView.addSubview(emailTextField)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 42).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: width - 114).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupPasswordTextField() {
        passwordTextField.font = UIFont.systemFontOfSize(size: 14)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textColor = .textFieldTextColor
        passwordTextField.placeholder = "Пароль*"
        passwordTextField.textAlignment = .left
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.leftView = UIView(frame: CGRect(x: 0,
                                                          y: 0,
                                                          width: 8,
                                                          height: passwordTextField.frame.height))
        passwordTextField.leftViewMode = .always
        scrollView.addSubview(passwordTextField)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 21).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: width - 114).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupForgotButton() {
        forgotButton.addTarget(self, action: #selector(forgotButtonPressed), for: .touchUpInside)
        forgotButton.setTitle("Забыли пароль?", for: .normal)
        forgotButton.setTitleColor(.hdLinkColor, for: .normal)
        forgotButton.titleLabel?.font = UIFont.boldSystemFontOfSize(size: 14)
        scrollView.addSubview(forgotButton)
        
        forgotButton.translatesAutoresizingMaskIntoConstraints = false
        forgotButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 5).isActive = true
        forgotButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 64).isActive = true
        forgotButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        forgotButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    private func setupLoginButton() {
        loginButton = HDButton(title: "Войти")
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        scrollView.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: forgotButton.bottomAnchor,
                                            constant: 78).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func setupBackButton() {
        let titleButton = "< Назад"
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.titleLabel?.font = UIFont.boldSystemFontOfSize(size: 18)
        backButton.titleLabel?.textColor = .white
        backButton.setTitle(titleButton, for: .normal)
        scrollView.addSubview(backButton)
        
        let window = UIApplication.shared.keyWindow
        let bottomPadding = window?.safeAreaInsets.bottom
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 36).isActive = true
        backButton.bottomAnchor.constraint(equalTo: scrollView.topAnchor,
                                           constant: height - (bottomPadding ?? 0) - 38).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    // MARK: - IBActions
    @objc private func forgotButtonPressed() {
        presenter?.recoveryPassword()
    }
    
    @objc private func loginButtonPressed() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        let getToken = Registration.init(email: email, password: password, token: nil)
        
        getData(typeOfContent: .getToken,
                returning: (Int?, String?).self,
                requestParams: getToken.requestParams )
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            getToken.responce = result
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    print("result= \(String(describing: getToken.responce))")
                    guard let code = getToken.responce?.0 else { return }
                    if responceCode(code: code) {
                        self?.presenter?.login()
                    }
                }
            }
        }

    }
    
    @objc private func backButtonPressed() {
        presenter?.back()
    }
    
    @objc func hideKeyboard() {
        scrollView.endEditing(true)
    }
    
    @objc func keyboardWasShown​(notification: Notification) {
        guard let info = notification.userInfo else {
            assertionFailure()
            return
        }
        //swiftlint:disable force_cast
        let kbSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        keyboardHeight = kbSize.height
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    // MARK: - Buttons methods
    // MARK: - Navigation
}
