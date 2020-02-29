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
    var presenter: LoginPresenterProtocol?
    
    // MARK: - Constants and variables
    private let scrollView = UIScrollView()
    private let titleLabel = UILabel()
    private let label = UILabel()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let forgotButton = UIButton()
    private let loginButton = HDButton(title: "Войти")
    private let backButton = UIButton()
    private var keyboardHeight = 0.f
    private var isKeyboardShown = false
    private let widthTextField = Session.width - 114.f
    private let heightTextField = 30.f
    
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
        addTapGestureToHideKeyboard()
        addSwipeGestureToBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Public methods
    /// Устанавливает значение в поле ввода электронной почты
    /// - Parameter email: адрес электронной почты
    func setEmail(email: String) {
        emailTextField.text = email
    }
    
    /// Передает значение поля ввода электронной почты
    func getEmailText() -> String {
        return emailTextField.text ?? ""
    }
    
    // MARK: - Setup views
    /// Установка ScrollView
    private func setupScrollView() {
        let top = 60.f
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: Session.width, height: Session.height)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: top).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: Session.height).isActive = true
    }
    
    /// Установка заголовка
    private func setupTitleLabel() {
        let top = 54.f
        let height = 22.f
        titleLabel.font = .boldSystemFontOfSize(size: 18)
        titleLabel.textColor = .white
        titleLabel.text = "Авторизация"
        titleLabel.textAlignment = .center
        scrollView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor,
                                        constant: top).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка описания
    private func setupLabel() {
        let top = 45.f
        let width = Session.width - 60.f
        let height = 51.f
        label.font = .systemFontOfSize(size: 14)
        label.textColor = .white
        label.text = "Для авторизации введите свой e-mail и ранее полученный пароль"
        label.textAlignment = .left
        label.numberOfLines = 0
        scrollView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                   constant: top).isActive = true
        label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: width).isActive = true
        label.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка поля ввода адреса электронной почты
    private func setupEmailTextField() {
        let top = 42.f
        emailTextField.font = .systemFontOfSize(size: 14)
        emailTextField.keyboardType = .emailAddress
        emailTextField.textColor = .textFieldTextColor
        emailTextField.attributedPlaceholder = redStar(text: "E-mail*")
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
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
        emailTextField.topAnchor.constraint(equalTo: label.bottomAnchor,
                                            constant: top).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: widthTextField).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    /// Установка поля ввода пароля
    private func setupPasswordTextField() {
        let top = 21.f
        passwordTextField.font = .systemFontOfSize(size: 14)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textColor = .textFieldTextColor
        passwordTextField.attributedPlaceholder = redStar(text: "Пароль*")
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
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor,
                                               constant: top).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: widthTextField).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    /// Установки кнопки восстановления пароля
    private func setupForgotButton() {
        let top = 5.f
        let leading = 64.f
        let width = 120.f
        let height = 16.f
        forgotButton.addTarget(self, action: #selector(forgotButtonPressed), for: .touchUpInside)
        forgotButton.setTitle("Забыли пароль?", for: .normal)
        forgotButton.setTitleColor(.hdLinkColor, for: .normal)
        forgotButton.titleLabel?.font = .boldSystemFontOfSize(size: 14)
        scrollView.addSubview(forgotButton)
        
        forgotButton.translatesAutoresizingMaskIntoConstraints = false
        forgotButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,
                                          constant: top).isActive = true
        forgotButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                              constant: leading).isActive = true
        forgotButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        forgotButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установки кнопки "Войти"
    private func setupLoginButton() {
        let top = 78.f
        let width = 150.f
        let height = 35.f
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        scrollView.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: forgotButton.bottomAnchor,
                                         constant: top).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установки кнопки "Назад"
    private func setupBackButton() {
        let window = UIApplication.shared.keyWindow
        let bottomPadding = window?.safeAreaInsets.bottom
        let bottom = Session.height - (bottomPadding ?? 0) - 98.f
        let leading = 36.f
        let width = 80.f
        let height = 35.f
        let titleButton = "< Назад"
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.titleLabel?.font = .boldSystemFontOfSize(size: 18)
        backButton.titleLabel?.textColor = .white
        backButton.setTitle(titleButton, for: .normal)
        scrollView.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                            constant: leading).isActive = true
        backButton.bottomAnchor.constraint(equalTo: scrollView.topAnchor,
                                           constant: bottom).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    /// Добавление распознавания касания экрана
    private func addTapGestureToHideKeyboard() {
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
    
    /// Добавляет свайп влево для перехода назад
    private func addSwipeGestureToBack() {
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.addTarget(self, action: #selector(backButtonPressed))
        swipeLeft.direction = .right
        view.addGestureRecognizer(swipeLeft)
    }
    
    // MARK: - IBActions
    /// Скрытие клавиатуры
    @objc func hideKeyboard() {
        scrollView.endEditing(true)
        view.viewWithTag(998)?.removeFromSuperview()
        view.viewWithTag(999)?.removeFromSuperview()
    }
    
    /// Изменение размера ScrollView при появлении клавиатуры
    /// - Parameter notification: событие появления клавиатуры
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
    
    /// Изменение размера ScrollView при скрытии клавиатуры
    /// - Parameter notification: событие скрытия клавиатуры
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    // MARK: - Buttons methods
    /// Обработка нажатия кнопки "Забыли пароль?"
    @objc private func forgotButtonPressed() {
        presenter?.recoveryPassword()
    }
    
    /// Обработка нажатия кнопки "Войти"
    @objc private func loginButtonPressed() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text else { return }
        hideKeyboard()
        presenter?.loginButtonPressed(email: email, password: password)
    }
    
    // MARK: - Navigation
    /// Обработка нажатия кнопки "Назад"
    @objc private func backButtonPressed() {
        presenter?.back()
    }
}
