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
//    var coordinator: RecoveryPasswordCoordinatorProtocol?
    var presenter: RecoveryPasswordPresenterProtocol?
    
    // MARK: - Constants
    private let backgroundImage = UIImageView()
    private let scrollView = UIScrollView()
    private var headerView = HeaderView()
    private let titleLabel = UILabel()
    private let label = UILabel()
    private let emailTextField = UITextField()
    private var sendButton = HDButton()
    private let backButton = UIButton()
    private var imageViewEmailSuccess = UIImageView()
    private var keyboardHeight: CGFloat = 0
    private var isShowAlert = false
    private var alertViewTag = 999
    
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
        setupSendButton()
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
    func showAlert(message: String?) {
        if isShowAlert {
            self.view.viewWithTag(alertViewTag)?.removeFromSuperview()
            isShowAlert = false
        }
        let alert = AlertView(message: message ?? "Ошибка")
        alert.tag = alertViewTag
        view.addSubview(alert)
        alert.translatesAutoresizingMaskIntoConstraints = false
        alert.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        alert.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        alert.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        alert.heightAnchor.constraint(equalToConstant: 57).isActive = true
        isShowAlert = true
    }
    
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
        titleLabel.text = "Восстановление пароля"
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
        label.text =
        "Чтобы восстановить пароль введите, пожалуйста, свой E-mail. На него будет выслан новый пароль для входа"
        label.textAlignment = .left
        label.numberOfLines = 0
        scrollView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                   constant: 45).isActive = true
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
        emailTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 70).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: width - 114).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupSendButton() {
        sendButton = HDButton(title: "Отправить")
        sendButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        sendButton.update(isEnabled: true)
        scrollView.addSubview(sendButton)
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor,
                                            constant: 40).isActive = true
        sendButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
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
    @objc private func registerButtonPressed() {
        guard let email = emailTextField.text, let presenter = presenter else { return }
        presenter.sendButtonTapped(email: email)
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
    func toRecoveryPasswordEnd() {
        presenter?.send()
    }

}
