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
    private let logoImage = UIImageView()
    private let doctorsImage = UIImageView()
    private let titleLabel = UILabel()
    private let topLabel = UILabel()
    private let bottomLabel = UILabel()
    private let topEmailTextField = UITextField()
    private var registerButton = HDButton(title: "Отправить", fontSize: 18)
    private let backButton = BackButton()
    private let checkButton = CheckBox(type: .square)
    private let policyTextView = UITextView()
    private var keyboardHeight: CGFloat = 0
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScrollView()
        setupBackgroundImage()
        setupLogoImage()
        setupDoctorsImage()
        setupTitleLabel()
        setupTopLabel()
        setupBottomLabel()
        setupTopEmailTextField()
        setupRegisterButton()
        setupBackButton()
        setupPolicyTextView()
        setupCheckButton()
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
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: Session.width, height: Session.height)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: Session.height).isActive = true
    }
    
    func setupBackgroundImage() {
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "Background.pdf")
        backgroundImage.frame = CGRect(x: 0, y: 0, width: Session.width, height: Session.height)
        scrollView.addSubview(backgroundImage)
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
        logoImage.topAnchor.constraint(equalTo: scrollView.topAnchor,
                                       constant: top).isActive = true
        logoImage.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor,
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
        doctorsImage.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        doctorsImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
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
        titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка верхней надписи
    private func setupTopLabel() {
        let top = 17.f
        let width = Session.width - 40.f
        let height = 34.f
        topLabel.font = .systemFontOfSize(size: 14)
        topLabel.textColor = .white
        topLabel.text = "Чтобы воспользоваться функциями приложения, необходимо пройти регистрацию."
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
        let top = 9.f
        let width = Session.width - 40.f
        let height = 34.f
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
        let top = 17.f
        let width = Session.width - 114.f
        topEmailTextField.addTarget(self,
                                    action: #selector(self.topEmailChanged(_:)),
                                    for: UIControl.Event.editingChanged)
        topEmailTextField.font = .systemFontOfSize(size: 14)
        topEmailTextField.keyboardType = .emailAddress
        topEmailTextField.textColor = .textFieldTextColor
        topEmailTextField.autocapitalizationType = .none
        topEmailTextField.placeholder = "E-mail*"
        topEmailTextField.textAlignment = .left
        topEmailTextField.backgroundColor = .white
        topEmailTextField.layer.cornerRadius = 5
        topEmailTextField.autocorrectionType = .no
        topEmailTextField.leftView = setupDefaultLeftView()
        topEmailTextField.leftViewMode = .always
        scrollView.addSubview(topEmailTextField)
        
        topEmailTextField.translatesAutoresizingMaskIntoConstraints = false
        topEmailTextField.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor,
                                               constant: top).isActive = true
        topEmailTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        topEmailTextField.widthAnchor.constraint(equalToConstant: width).isActive = true
        topEmailTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    /// Установка кнопки "Отправить"
    private func setupRegisterButton() {
        let top = 20.f
        let width = 148.f
        let height = 44.f
        registerButton.layer.cornerRadius = height / 2
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        registerButton.update(isEnabled: false)
        scrollView.addSubview(registerButton)
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.topAnchor.constraint(equalTo: topEmailTextField.bottomAnchor,
                                            constant: top).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка кнопки "Назад"
    private func setupBackButton() {
        let leading = 8.f
        let top = 10.f
        let width = 57.f
        let height = 21.f
        let tap = UITapGestureRecognizer(target: self, action: #selector(backButtonPressed))
        backButton.addGestureRecognizer(tap)
        scrollView.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                            constant: leading).isActive = true
        backButton.topAnchor.constraint(equalTo: scrollView.topAnchor,
                                        constant: top).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupPolicyTextView() {
        let font = UIFont.systemFontOfSize(size: 12)
        let leading = 50.f
        let top = 15.f
        let width = Session.width - 70
        
        let text = """
        Нажимая «Отправить», Вы соглашаетесь с условиями Лицензионного договора \
        и Политикой обработки персональных данных
        """
        let height = text.height(withConstrainedWidth: width, font: font)
        let range1 = (text as NSString).range(of: "Лицензионного договора")
        let range2 = (text as NSString).range(of: "Политикой обработки персональных данных")
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.link, value: "https://www.yandex.ru", range: range1)
        attributedString.addAttribute(NSAttributedString.Key.link, value: "https://www.apple.com", range: range2)
        
        policyTextView.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.hdLinkColor]
        policyTextView.isUserInteractionEnabled = true  
        policyTextView.font = font
        policyTextView.textColor = .black
        policyTextView.attributedText = attributedString
        policyTextView.textAlignment = .left
        policyTextView.delegate = self
        policyTextView.backgroundColor = .backgroundColor
        policyTextView.isScrollEnabled = false
        policyTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        policyTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        policyTextView.showsVerticalScrollIndicator = false
        policyTextView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(policyTextView)
        
        policyTextView.translatesAutoresizingMaskIntoConstraints = false
        policyTextView.topAnchor.constraint(equalTo: registerButton.bottomAnchor,
                                            constant: top).isActive = true
        policyTextView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                constant: leading).isActive = true
        policyTextView.widthAnchor.constraint(equalToConstant: width).isActive = true
        policyTextView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка чекбокса согласия с условиями использования
    private func setupCheckButton() {
        let leading = 20.f
        let width = 20.f
        checkButton.addTarget(self, action: #selector(checkButtonPressed), for: .touchUpInside)
        scrollView.addSubview(checkButton)
        
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.centerYAnchor.constraint(equalTo: policyTextView.centerYAnchor).isActive = true
        checkButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: leading).isActive = true
        checkButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: width).isActive = true
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
    
    /// Скрытие клавиатуры
    @objc func hideKeyboard() {
        scrollView.endEditing(true)
        view.viewWithTag(Session.tagSavedView)?.removeFromSuperview()
        view.viewWithTag(Session.tagAlertView)?.removeFromSuperview()
    }
    
    /// Изменение размера ScrollView при появлении клавиатуры
    /// - Parameter notification: событие появления клавиатуры
    @objc func keyboardWasShown​(notification: Notification) {
        guard let info = notification.userInfo else {
            assertionFailure()
            return
        }
        guard let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let kbSize = keyboardFrame.cgRectValue.size
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
        guard let email = topEmailTextField.text else { return }
        presenter?.registerButtonPressed(email: email)
    }
    
    /// Обработка нажатия кнопки "Назад"
    @objc private func backButtonPressed() {
        presenter?.back()
    }
    
    /// Обработка нажатия чекбокса
    @objc private func checkButtonPressed() {
        checkButton.isSelected = !checkButton.isSelected
        presenter?.checkPolicyChanged(isAgree: checkButton.isSelected)
    }
    
}

extension RegisterScreenViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView,
                  shouldInteractWith URL: URL,
                  in characterRange: NSRange,
                  interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
    
}
