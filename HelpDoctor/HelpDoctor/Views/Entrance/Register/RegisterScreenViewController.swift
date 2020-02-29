//
//  RegisterViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class RegisterScreenViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: RegisterScreenPresenter?
    
    // MARK: - Constants and variables
    private let scrollView = UIScrollView()
    private let titleLabel = UILabel()
    private let topLabel = UILabel()
    private let bottomLabel = UILabel()
    private let topEmailTextField = UITextField()
    private let textFieldLabel = UILabel()
    private let bottomEmailTextField = UITextField()
    private var registerButton = HDButton()
    private let backButton = UIButton()
    private var keyboardHeight: CGFloat = 0
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupScrollView()
        setupHeaderView()
        setupTitleLabel()
        setupTopLabel()
        setupBottomLabel()
        setupTopEmailTextField()
        setupTextFieldLabel()
        setupBottomEmailTextField()
        setupRegisterButton()
        setupBackButton()
        addTapGestureToHideKeyboard()
        addSwipeGestureToBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Public methods
    /// Обновление состояния кнопки "Отправить"
    /// - Parameter isEnabled: состояние
    func updateButtonRegister(isEnabled: Bool) {
        self.registerButton.update(isEnabled: isEnabled)
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
        titleLabel.text = "Регистрация"
        titleLabel.textAlignment = .center
        scrollView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor,
                                        constant: top).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка верхней надписи
    private func setupTopLabel() {
        let top = 45.f
        let width = Session.width - 60.f
        let height = 51.f
        topLabel.font = .systemFontOfSize(size: 14)
        topLabel.textColor = .white
        topLabel.text = "Чтобы воспользоваться функциями нашей программы, пожалуйста, зарегистрируйтесь."
        topLabel.textAlignment = .left
        topLabel.numberOfLines = 0
        scrollView.addSubview(topLabel)
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                      constant: top).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        topLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка нижней надписи
    private func setupBottomLabel() {
        let top = 17.f
        let width = Session.width - 60.f
        let height = 36.f
        bottomLabel.font = .systemFontOfSize(size: 14)
        bottomLabel.textColor = .white
        bottomLabel.text = "Укажите свой e-mail в поле ниже. На него будет выслан пароль для входа."
        bottomLabel.textAlignment = .left
        bottomLabel.numberOfLines = 0
        scrollView.addSubview(bottomLabel)
        
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                         constant: top).isActive = true
        bottomLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        bottomLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        bottomLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка поля ввода адреса электронной почты
    private func setupTopEmailTextField() {
        let top = 12.f
        let width = Session.width - 114.f
        let height = 30.f
        topEmailTextField.addTarget(self,
                                    action: #selector(self.topEmailChanged(_:)),
                                    for: UIControl.Event.editingChanged)
        topEmailTextField.font = .systemFontOfSize(size: 14)
        topEmailTextField.keyboardType = .emailAddress
        topEmailTextField.textColor = .textFieldTextColor
        topEmailTextField.autocapitalizationType = .none
        topEmailTextField.attributedPlaceholder = redStar(text: "E-mail*")
        topEmailTextField.textAlignment = .left
        topEmailTextField.backgroundColor = .white
        topEmailTextField.layer.cornerRadius = 5
        topEmailTextField.autocorrectionType = .no
        topEmailTextField.leftView = UIView(frame: CGRect(x: 0,
                                                          y: 0,
                                                          width: 8,
                                                          height: topEmailTextField.frame.height))
        topEmailTextField.leftViewMode = .always
        scrollView.addSubview(topEmailTextField)
        
        topEmailTextField.translatesAutoresizingMaskIntoConstraints = false
        topEmailTextField.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor,
                                               constant: top).isActive = true
        topEmailTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        topEmailTextField.widthAnchor.constraint(equalToConstant: width).isActive = true
        topEmailTextField.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка надписи подтверждения адреса электронной почты
    private func setupTextFieldLabel() {
        let top = 20.f
        let width = Session.width - 60.f
        let height = 16.f
        textFieldLabel.font = .systemFontOfSize(size: 14)
        textFieldLabel.textColor = .white
        textFieldLabel.text = "Подтвердите свой e-mail, пожалуйста"
        textFieldLabel.textAlignment = .left
        textFieldLabel.numberOfLines = 0
        scrollView.addSubview(textFieldLabel)
        
        textFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        textFieldLabel.topAnchor.constraint(equalTo: topEmailTextField.bottomAnchor,
                                            constant: top).isActive = true
        textFieldLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        textFieldLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        textFieldLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка поля ввода подтверждения адреса электронной почты
    private func setupBottomEmailTextField() {
        let top = 12.f
        let width = Session.width - 114.f
        let height = 30.f
        bottomEmailTextField.addTarget(self,
                                       action: #selector(self.bottomEmailChanged(_:)),
                                       for: UIControl.Event.editingChanged)
        bottomEmailTextField.font = .systemFontOfSize(size: 14)
        bottomEmailTextField.keyboardType = .emailAddress
        bottomEmailTextField.textColor = .textFieldTextColor
        bottomEmailTextField.autocapitalizationType = .none
        bottomEmailTextField.attributedPlaceholder = redStar(text: "E-mail*")
        bottomEmailTextField.textAlignment = .left
        bottomEmailTextField.backgroundColor = .white
        bottomEmailTextField.layer.cornerRadius = 5
        bottomEmailTextField.autocorrectionType = .no
        bottomEmailTextField.leftView = UIView(frame: CGRect(x: 0,
                                                             y: 0,
                                                             width: 8,
                                                             height: bottomEmailTextField.frame.height))
        bottomEmailTextField.leftViewMode = .always
        scrollView.addSubview(bottomEmailTextField)
        
        bottomEmailTextField.translatesAutoresizingMaskIntoConstraints = false
        bottomEmailTextField.topAnchor.constraint(equalTo: textFieldLabel.bottomAnchor,
                                                  constant: top).isActive = true
        bottomEmailTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        bottomEmailTextField.widthAnchor.constraint(equalToConstant: width).isActive = true
        bottomEmailTextField.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка кнопки "Отправить"
    private func setupRegisterButton() {
        let top = 34.f
        let width = 150.f
        let height = 35.f
        registerButton = HDButton(title: "Отправить")
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        registerButton.update(isEnabled: false)
        scrollView.addSubview(registerButton)
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.topAnchor.constraint(equalTo: bottomEmailTextField.bottomAnchor,
                                            constant: top).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка кнопки "Назад"
    private func setupBackButton() {
        let window = UIApplication.shared.keyWindow
        let bottomPadding = window?.safeAreaInsets.bottom
        let bottom = Session.height - (bottomPadding ?? 0) - 98.f
        let leading = 36.f
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
    /// Проверка заполнения поля ввода адреса электронной почты
    /// - Parameter textField: поле ввода адреса электронной почты
    @objc func topEmailChanged(_ textField: UITextField) {
        presenter?.topEmailChanged(topEmail: textField.text)
    }
    
    /// Проверка заполнения поля ввода подтверждения адреса электронной почты
    /// - Parameter textField: поле ввода подтверждения адреса электронной почты
    @objc func bottomEmailChanged(_ textField: UITextField) {
        presenter?.bottomEmailChanged(bottomEmail: textField.text)
    }
    
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
        guard let email = bottomEmailTextField.text else { return }
        presenter?.registerButtonPressed(email: email)
    }
    
    // MARK: - Navigation
    /// Обработка нажатия кнопки "Назад"
    @objc private func backButtonPressed() {
        presenter?.back()
    }
}
