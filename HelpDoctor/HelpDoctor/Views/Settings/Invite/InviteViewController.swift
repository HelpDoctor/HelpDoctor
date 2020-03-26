//
//  InviteViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 23.02.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class InviteViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: InvitePresenterProtocol?
    
    // MARK: - Constants and variables
    private let scrollView = UIScrollView()
    private let topStackView = UIView()
    private let headerIcon = UIImageView()
    private let headerLabel = UILabel()
    private let textLabel = UILabel()
    private let nameTextField = UITextField()
    private let surnameTextField = UITextField()
    private let emailTextField = UITextField()
    private let sendButton = HDButton(title: "Отправить")
    private var heightScroll = Session.height
    private var keyboardHeight: CGFloat = 0
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.494, green: 0.737, blue: 0.902, alpha: 1)
        setupScrollView()
        setupHeaderViewWithAvatar(title: "Настройки",
                                  text: nil,
                                  userImage: nil,
                                  presenter: presenter)
        setupTopStackView()
        setupHeaderIcon()
        setupHeaderLabel()
        setupTextLabel()
        setupNameTextField()
        setupSurnameTextField()
        setupEmailTextField()
        setupSendButton()
        addTapGestureToHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
    }
    
    // MARK: - Setup views
    private func setupScrollView() {
        let top: CGFloat = 50
        scrollView.delegate = self
        heightScroll = Session.statusBarHeight + top
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: top).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: view.frame.size.height).isActive = true
    }
    
    private func setupTopStackView() {
        let height: CGFloat = 40
        heightScroll += height
        topStackView.backgroundColor = UIColor(red: 0.137, green: 0.455, blue: 0.671, alpha: 1)
        scrollView.addSubview(topStackView)
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        topStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        topStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        topStackView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupHeaderIcon() {
        let width: CGFloat = 30
        let leading: CGFloat = 20
        headerIcon.image = UIImage(named: "addFriends")
        topStackView.addSubview(headerIcon)
        
        headerIcon.translatesAutoresizingMaskIntoConstraints = false
        headerIcon.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor,
                                               constant: leading).isActive = true
        headerIcon.widthAnchor.constraint(equalToConstant: width).isActive = true
        headerIcon.centerYAnchor.constraint(equalTo: topStackView.centerYAnchor).isActive = true
        headerIcon.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupHeaderLabel() {
        let leading: CGFloat = 20
        
        headerLabel.numberOfLines = 1
        headerLabel.textAlignment = .left
        headerLabel.font = .systemFontOfSize(size: 14)
        headerLabel.textColor = .white
        headerLabel.text = "Приглашение в HelpDoctor"
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
        let leading: CGFloat = 20
        let top: CGFloat = 20
        let height: CGFloat = 80
        let width: CGFloat = Session.width - (leading * 2)
        heightScroll += height + top
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .left
        textLabel.font = .systemFontOfSize(size: 16)
        textLabel.textColor = .white
        textLabel.text = "Чтобы отправить ссылку-приглашение другу, заполните нижеследующие поля и нажмите “Отправить”"
        scrollView.addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                               constant: leading).isActive = true
        textLabel.topAnchor.constraint(equalTo: topStackView.bottomAnchor,
                                       constant: top).isActive = true
        textLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupNameTextField() {
        let top: CGFloat = 15
        let leading: CGFloat = 20
        let height: CGFloat = 30
        let width: CGFloat = Session.width - (leading * 2)
        heightScroll += height + top
        nameTextField.font = UIFont.systemFontOfSize(size: 14)
        nameTextField.textColor = .textFieldTextColor
        nameTextField.attributedPlaceholder = redStar(text: "Имя*")
        nameTextField.textAlignment = .left
        nameTextField.backgroundColor = .white
        nameTextField.layer.cornerRadius = 5
        nameTextField.leftView = UIView(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: 8,
                                                       height: nameTextField.frame.height))
        nameTextField.leftViewMode = .always
        scrollView.addSubview(nameTextField)
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: textLabel.bottomAnchor,
                                            constant: top).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: width).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupSurnameTextField() {
        let top: CGFloat = 10
        let leading: CGFloat = 20
        let height: CGFloat = 30
        let width: CGFloat = Session.width - (leading * 2)
        heightScroll += height + top
        surnameTextField.font = UIFont.systemFontOfSize(size: 14)
        surnameTextField.textColor = .textFieldTextColor
        surnameTextField.attributedPlaceholder = redStar(text: "Фамилия*")
        surnameTextField.textAlignment = .left
        surnameTextField.backgroundColor = .white
        surnameTextField.layer.cornerRadius = 5
        surnameTextField.leftView = UIView(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: 8,
                                                       height: surnameTextField.frame.height))
        surnameTextField.leftViewMode = .always
        scrollView.addSubview(surnameTextField)
        
        surnameTextField.translatesAutoresizingMaskIntoConstraints = false
        surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor,
                                            constant: top).isActive = true
        surnameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        surnameTextField.widthAnchor.constraint(equalToConstant: width).isActive = true
        surnameTextField.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupEmailTextField() {
        let top: CGFloat = 10
        let leading: CGFloat = 20
        let height: CGFloat = 30
        let width: CGFloat = Session.width - (leading * 2)
        heightScroll += height + top
        emailTextField.font = UIFont.systemFontOfSize(size: 14)
        emailTextField.keyboardType = .emailAddress
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
        emailTextField.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor,
                                            constant: top).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: width).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupSendButton() {
        let top: CGFloat = 30
        let width: CGFloat = 150
        let height: CGFloat = 35
        heightScroll += height + top
        scrollView.contentSize = CGSize(width: Session.width, height: heightScroll)
        sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
        sendButton.update(isEnabled: true)
        scrollView.addSubview(sendButton)
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor,
                                        constant: top).isActive = true
        sendButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: height).isActive = true
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
