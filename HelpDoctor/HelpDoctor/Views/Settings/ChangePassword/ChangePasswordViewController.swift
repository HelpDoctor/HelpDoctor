//
//  ChangePasswordViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 23.02.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: ChangePasswordPresenterProtocol?
    
    // MARK: - Constants and variables
    private var verticalInset = 0.f
    private let headerHeight = 40.f
    private let heightTopStackView = 40.f
    private let heightArt = 157.f
    private let heightLabel = 51.f
    private let heightTextField = 30.f
    private let heightSendButton = 44.f
    private let widthContent = Session.width - 40
    private let scrollView = UIScrollView()
    private let topStackView = UIView()
    private let headerIcon = UIImageView()
    private let headerLabel = UILabel()
    private let art = UIImageView()
    private let textLabel = UILabel()
    private let oldPasswordTextField = UITextField()
    private let passwordTextField = UITextField()
    private let confirmPasswordTextField = UITextField()
    private let bottomLabel = UILabel()
    private let sendButton = HDButton(title: "Изменить", fontSize: 18)
    private var keyboardHeight: CGFloat = 0
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        verticalInset = calculateInset()
        view.backgroundColor = .backgroundColor
        setupHeaderView(color: .tabBarColor,
                        height: headerHeight,
                        presenter: presenter,
                        title: "Настройки",
                        font: .boldSystemFontOfSize(size: 14))
        setupScrollView()
        setupTopStackView()
        setupHeaderIcon()
        setupHeaderLabel()
        setupTextLabel()
        setupOldPasswordTextField()
        setupPasswordTextField()
        setupConfirmPasswordTextField()
        setupBottomLabel()
        setupSendButton()
        setupArt()
        addTapGestureToHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
    }
    
    // MARK: - Public methods
    /// Обновление состояния кнопки "Отправить"
    /// - Parameter isEnabled: состояние
    func updateSendButton(isEnabled: Bool) {
        self.sendButton.update(isEnabled: isEnabled)
    }
    
    // MARK: - Private methods
    private func calculateInset() -> CGFloat {
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        let contentHeight = statusBarHeight + tabBarHeight + headerHeight + heightTopStackView
            + heightArt + (heightLabel * 2) + (heightTextField * 3) + heightSendButton
        return (Session.height - contentHeight) / 8
    }
    
    // MARK: - Setup views
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: Session.width, height: Session.height - headerHeight)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: headerHeight).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: Session.height).isActive = true
    }
    
    private func setupTopStackView() {
        topStackView.backgroundColor = .searchBarTintColor
        scrollView.addSubview(topStackView)
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        topStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        topStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        topStackView.heightAnchor.constraint(equalToConstant: heightTopStackView).isActive = true
    }
    
    private func setupHeaderIcon() {
        let width = 30.f
        let leading = 20.f
        headerIcon.image = UIImage(named: "securitySettings")
        topStackView.addSubview(headerIcon)
        
        headerIcon.translatesAutoresizingMaskIntoConstraints = false
        headerIcon.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor,
                                               constant: leading).isActive = true
        headerIcon.widthAnchor.constraint(equalToConstant: width).isActive = true
        headerIcon.centerYAnchor.constraint(equalTo: topStackView.centerYAnchor).isActive = true
        headerIcon.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupHeaderLabel() {
        let leading = 20.f
        headerLabel.numberOfLines = 1
        headerLabel.textAlignment = .left
        headerLabel.font = .boldSystemFontOfSize(size: 14)
        headerLabel.textColor = .white
        headerLabel.text = "Изменение пароля"
        topStackView.addSubview(headerLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.leadingAnchor.constraint(equalTo: headerIcon.trailingAnchor,
                                               constant: leading).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor,
                                                constant: -leading).isActive = true
        headerLabel.centerYAnchor.constraint(equalTo: topStackView.centerYAnchor).isActive = true
        headerLabel.heightAnchor.constraint(equalTo: topStackView.heightAnchor).isActive = true
    }
    
    private func setupTextLabel() {
        let leading = 20.f
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .left
        textLabel.font = .systemFontOfSize(size: 14)
        textLabel.textColor = .white
        textLabel.text =
        """
        Чтобы сменить пароль, укажите сначала текущий, затем введите новый и нажмите кнопку “Изменить”
        """
        scrollView.addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                           constant: leading).isActive = true
        textLabel.topAnchor.constraint(equalTo: topStackView.bottomAnchor,
                                       constant: verticalInset).isActive = true
        textLabel.widthAnchor.constraint(equalToConstant: widthContent).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupOldPasswordTextField() {
        oldPasswordTextField.addTarget(self,
                                    action: #selector(self.oldPasswordChanged(_:)),
                                    for: UIControl.Event.editingChanged)
        oldPasswordTextField.font = .systemFontOfSize(size: 14)
        oldPasswordTextField.isSecureTextEntry = true
        oldPasswordTextField.textColor = .textFieldTextColor
        oldPasswordTextField.placeholder = "Старый пароль"
        oldPasswordTextField.textAlignment = .left
        oldPasswordTextField.backgroundColor = .white
        oldPasswordTextField.layer.cornerRadius = 5
        oldPasswordTextField.leftView = UIView(frame: CGRect(x: 0,
                                                             y: 0,
                                                             width: 8,
                                                             height: oldPasswordTextField.frame.height))
        oldPasswordTextField.leftViewMode = .always
        scrollView.addSubview(oldPasswordTextField)
        
        oldPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        oldPasswordTextField.topAnchor.constraint(equalTo: textLabel.bottomAnchor,
                                                  constant: verticalInset).isActive = true
        oldPasswordTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        oldPasswordTextField.widthAnchor.constraint(equalToConstant: widthContent).isActive = true
        oldPasswordTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    private func setupPasswordTextField() {
        passwordTextField.addTarget(self,
                                    action: #selector(self.passwordChanged(_:)),
                                    for: UIControl.Event.editingChanged)
        passwordTextField.font = .systemFontOfSize(size: 14)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textColor = .textFieldTextColor
        passwordTextField.placeholder = "Новый пароль"
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
        passwordTextField.topAnchor.constraint(equalTo: oldPasswordTextField.bottomAnchor,
                                               constant: verticalInset).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: widthContent).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    private func setupConfirmPasswordTextField() {
        confirmPasswordTextField.addTarget(self,
                                           action: #selector(self.confirmPasswordChanged(_:)),
                                           for: UIControl.Event.editingChanged)
        confirmPasswordTextField.font = .systemFontOfSize(size: 14)
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.textColor = .textFieldTextColor
        confirmPasswordTextField.placeholder = "Повторите новый пароль"
        confirmPasswordTextField.textAlignment = .left
        confirmPasswordTextField.backgroundColor = .white
        confirmPasswordTextField.layer.cornerRadius = 5
        confirmPasswordTextField.leftView = UIView(frame: CGRect(x: 0,
                                                                 y: 0,
                                                                 width: 8,
                                                                 height: confirmPasswordTextField.frame.height))
        confirmPasswordTextField.leftViewMode = .always
        scrollView.addSubview(confirmPasswordTextField)
        
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,
                                                      constant: verticalInset).isActive = true
        confirmPasswordTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        confirmPasswordTextField.widthAnchor.constraint(equalToConstant: widthContent).isActive = true
        confirmPasswordTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    private func setupBottomLabel() {
        let leading = 20.f
        bottomLabel.numberOfLines = 0
        bottomLabel.textAlignment = .left
        bottomLabel.font = .systemFontOfSize(size: 14)
        bottomLabel.textColor = .white
        bottomLabel.text =
        """
        Новый пароль должен состоят минимум из 8 символов, содержать цифры, строчные и заглавные буквы
        """
        scrollView.addSubview(bottomLabel)
        
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: leading).isActive = true
        bottomLabel.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor,
                                         constant: verticalInset).isActive = true
        bottomLabel.widthAnchor.constraint(equalToConstant: widthContent).isActive = true
        bottomLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupSendButton() {
        let width = 148.f
        sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
        sendButton.update(isEnabled: false)
        scrollView.addSubview(sendButton)
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor,
                                        constant: verticalInset).isActive = true
        sendButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: heightSendButton).isActive = true
    }
    
    private func setupArt() {
        let width = 165.f
        art.image = UIImage(named: "SecurityArt")
        view.addSubview(art)
        
        art.translatesAutoresizingMaskIntoConstraints = false
        art.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        art.widthAnchor.constraint(equalToConstant: width).isActive = true
        art.topAnchor.constraint(equalTo: sendButton.bottomAnchor, constant: verticalInset).isActive = true
        art.heightAnchor.constraint(equalToConstant: heightArt).isActive = true
    }
    
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
    
    // MARK: - Buttons methods
    @objc private func sendButtonPressed() {
        print("In develop")
    }
    
    // MARK: - IBActions
    @objc func oldPasswordChanged(_ textField: UITextField) {
        presenter?.oldPasswordChanged(password: oldPasswordTextField.text)
    }
    
    @objc func passwordChanged(_ textField: UITextField) {
        presenter?.passwordChanged(password: passwordTextField.text)
    }
    
    @objc func confirmPasswordChanged(_ textField: UITextField) {
        presenter?.confirmPasswordChanged(password: confirmPasswordTextField.text)
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
    
}
