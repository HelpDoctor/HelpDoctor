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
    private let heightArt = 180.f
    private let heightLabel = 116.f
    private let heightTextField = 30.f
    private let heightSendButton = 35.f
    private let scrollView = UIScrollView()
    private let topStackView = UIView()
    private let headerIcon = UIImageView()
    private let headerLabel = UILabel()
    private let art = UIImageView()
    private let textLabel = UILabel()
    private let emailTextField = UITextField()
    private let sendButton = HDButton(title: "Отправить")
    private var keyboardHeight: CGFloat = 0
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        verticalInset = calculateInset()
        view.backgroundColor = .backgroundColor
        setupHeaderView(color: .tabBarColor, height: headerHeight, presenter: presenter, title: "Настройки")
        setupScrollView()
        setupTopStackView()
        setupHeaderIcon()
        setupHeaderLabel()
        setupTextLabel()
        setupEmailTextField()
        setupSendButton()
        setupArt()
        addTapGestureToHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
    }
    
    private func calculateInset() -> CGFloat {
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        let contentHeight = statusBarHeight + tabBarHeight + headerHeight + heightTopStackView
            + heightArt + heightLabel + heightTextField + heightSendButton
        return (Session.height - contentHeight) / 5
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
        headerLabel.text = "Настройки безопасности"
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
        let width = Session.width - (leading * 2)
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .left
        textLabel.font = .systemFontOfSize(size: 16)
        textLabel.textColor = .white
        textLabel.text =
        """
        Чтобы изменить пароль введите, пожалуйста, E-mail, который Вы указывали при регистрации.\n
        Именно на него будет выслан новый пароль для входа в HelpDoctor
        """
        scrollView.addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                           constant: leading).isActive = true
        textLabel.topAnchor.constraint(equalTo: topStackView.bottomAnchor,
                                       constant: verticalInset).isActive = true
        textLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
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
        emailTextField.topAnchor.constraint(equalTo: textLabel.bottomAnchor,
                                            constant: verticalInset).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: Session.width - 114).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    private func setupSendButton() {
        let width = 150.f
        sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
        sendButton.update(isEnabled: true)
        scrollView.addSubview(sendButton)
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor,
                                        constant: verticalInset).isActive = true
        sendButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: heightSendButton).isActive = true
    }
    
    private func setupArt() {
        let width = 190.f
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
