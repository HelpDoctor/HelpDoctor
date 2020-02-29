//
//  ForgotPasswordViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class RecoveryPasswordViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: RecoveryPasswordPresenterProtocol?
    
    // MARK: - Constants and variables
    private let scrollView = UIScrollView()
    private let titleLabel = UILabel()
    private let label = UILabel()
    private let emailTextField = UITextField()
    private let sendButton = HDButton(title: "Отправить")
    private let backButton = UIButton()
    private var imageViewEmailSuccess = UIImageView()
    private var keyboardHeight: CGFloat = 0
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupScrollView()
        setupHeaderView()
        setupTitleLabel()
        setupLabel()
        setupEmailTextField()
        setupSendButton()
        setupBackButton()
        addTapGestureToHideKeyboard()
        addSwipeGestureToBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Public methods
    /// Передает значение поля ввода электронной почты
    func getEmailText() -> String {
        return emailTextField.text ?? ""
    }
    
    /// Устанавливает значение в поле ввода электронной почты
    /// - Parameter email: адрес электронной почты
    func setEmail(email: String) {
        emailTextField.text = email
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
        titleLabel.text = "Восстановление пароля"
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
        let height = 22.f
        label.font = .systemFontOfSize(size: 14)
        label.textColor = .white
        label.text =
        "Чтобы восстановить пароль введите, пожалуйста, свой E-mail. На него будет выслан новый пароль для входа"
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
    
    /// Установка поля ввода электронной почты
    private func setupEmailTextField() {
        let top = 70.f
        let width = Session.width - 114.f
        let height = 30.f
        emailTextField.font = .systemFontOfSize(size: 14)
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.textColor = .textFieldTextColor
        emailTextField.attributedPlaceholder = redStar(text: "E-mail*")
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
        emailTextField.widthAnchor.constraint(equalToConstant: width).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка кнопки "Отправить"
    private func setupSendButton() {
        let top = 40.f
        let width = 150.f
        let height = 35.f
        sendButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        sendButton.update(isEnabled: true)
        scrollView.addSubview(sendButton)
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor,
                                        constant: top).isActive = true
        sendButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка кнопки назад
    private func setupBackButton() {
        let window = UIApplication.shared.keyWindow
        let bottomPadding = window?.safeAreaInsets.bottom
        let leading = 36.f
        let bottom = Session.height - (bottomPadding ?? 0.f) - 98.f
        let width = 80.f
        let height = 25.f
        let titleButton = "< Назад"
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.titleLabel?.font = UIFont.boldSystemFontOfSize(size: 18)
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
    /// Обработка нажатия кнопки "Отправить"
    @objc private func registerButtonPressed() {
        guard let email = emailTextField.text, let presenter = presenter else { return }
        presenter.sendButtonTapped(email: email)
    }
    
    // MARK: - Navigation
    /// Обработка нажатия кнопки "Назад"
    @objc private func backButtonPressed() {
        presenter?.back()
    }
    
}
