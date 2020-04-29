//
//  RegisterEndViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class RegisterEndViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: RegisterEndPresenterProtocol?
    
    // MARK: - Constants
    private let scrollView = UIScrollView()
    private let logoImage = UIImageView()
    private let doctorsImage = UIImageView()
    private let titleLabel = UILabel()
    private let textLabel = UILabel()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = HDButton(title: "Войти", fontSize: 18)
    private let widthTextField = Session.width - 114.f
    private let heightTextField = 30.f
    private var keyboardHeight = 0.f
    private var isKeyboardShown = false
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupScrollView()
        setupLogoImage()
        setupDoctorsImage()
        setupTitleLabel()
        setupTopLabel()
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
        addTapGestureToHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Setup views
    /// Установка ScrollView
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: Session.width, height: Session.height)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: Session.height).isActive = true
    }
    
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
        scrollView.addSubview(logoImage)
        
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
        let width = 0.5 * Session.width
        let imageName = "RegImage.pdf"
        guard let image = UIImage(named: imageName) else {
            assertionFailure("Missing ​​\(imageName) asset")
            return
        }
        let resizedImage = image.resizeImage(width, opaque: false)
        doctorsImage.image = resizedImage
        scrollView.addSubview(doctorsImage)
        
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
        titleLabel.text = "Регистрация"
        titleLabel.textAlignment = .center
        scrollView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: doctorsImage.bottomAnchor,
                                        constant: top).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка верхней надписи
    private func setupTopLabel() {
        let top = 17.f
        let width = Session.width - 22.f
        let height = 118.f
        textLabel.font = .systemFontOfSize(size: 14)
        textLabel.textColor = .white
        textLabel.text =
        """
        Регистрация пройдена! \n
        Пароль для входа в приложение был выслан на указанный Вами E-mail \n
        Теперь Вы можете войти, используя адрес почтового ящика и пароль
        """
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        scrollView.addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                      constant: top).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка поля ввода адреса электронной почты
    private func setupEmailTextField() {
        let top = 16.f
        emailTextField.font = .systemFontOfSize(size: 14)
        emailTextField.keyboardType = .emailAddress
        emailTextField.textColor = .textFieldTextColor
        emailTextField.placeholder = "E-mail*"
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
        emailTextField.topAnchor.constraint(equalTo: textLabel.bottomAnchor,
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
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor,
                                               constant: top).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: widthTextField).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    /// Установка кнопки "Войти"
    private func setupLoginButton() {
        let top = 26.f
        let width = 148.f
        let height = 44.f
        loginButton.layer.cornerRadius = height / 2
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        scrollView.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,
                                         constant: top).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: height).isActive = true
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
    
    // MARK: - Navigation
    /// Обработка нажатия кнопки "Войти"
    @objc private func loginButtonPressed() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text else { return }
        hideKeyboard()
        presenter?.loginButtonPressed(email: email, password: password)
    }

}
