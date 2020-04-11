//
//  FeedbackViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 23.02.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: FeedbackPresenterProtocol?
    
    // MARK: - Constants and variables
    private let headerHeight = 40.f
    private let scrollView = UIScrollView()
    private let topStackView = UIView()
    private let headerIcon = UIImageView()
    private let headerLabel = UILabel()
    private let textLabel = UILabel()
    private let textView = UITextView()
    private let questionLabel = UILabel()
    private let emailButton = CheckBox(type: .square)
    private let messageButton = CheckBox(type: .square)
    private var sendButton = HDButton(title: "Отправить")
    private var keyboardHeight = 0.f
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupHeaderView(color: .tabBarColor, height: headerHeight, presenter: presenter, title: "Настройки")
        setupScrollView()
        setupTopStackView()
        setupHeaderIcon()
        setupHeaderLabel()
        setupTextLabel()
        setupTextView()
        setupQuestionLabel()
        setupEmailButton()
        setupMessageButton()
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
        let height = 40.f
        topStackView.backgroundColor = .searchBarTintColor
        scrollView.addSubview(topStackView)
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        topStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        topStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        topStackView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupHeaderIcon() {
        let width = 30.f
        let leading = 20.f
        headerIcon.image = UIImage(named: "callback")
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
        headerLabel.font = .mediumSystemFontOfSize(size: 14)
        headerLabel.textColor = .white
        headerLabel.text = "Связаться с разработчиками"
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
        let top = 10.f
        let height = 140.f
        let width = Session.width - (leading * 2)
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .left
        textLabel.font = .systemFontOfSize(size: 16)
        textLabel.textColor = .white
        textLabel.text =
        """
        Расскажите о своей проблеме, и мы приложим все усилия, чтобы решить ее оперативно.\n
        Если у Вас есть пожелания к улучшению работы приложения HelpDoctor, мы будем Вам благодарны
        """
        scrollView.addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                           constant: leading).isActive = true
        textLabel.topAnchor.constraint(equalTo: topStackView.bottomAnchor,
                                       constant: top).isActive = true
        textLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupTextView() {
        let leading = 20.f
        let top = 10.f
        let height = 100.f
        let width = Session.width - (leading * 2)
        textView.textAlignment = .left
        textView.font = .systemFontOfSize(size: 14)
        textView.textColor = .black
        textView.layer.cornerRadius = 5
        textView.delegate = self
        textView.text = "Введите, пожалуйста, своё сообщение (максимально 300 символов)"
        textView.textColor = .lightGray
        scrollView.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                          constant: leading).isActive = true
        textView.topAnchor.constraint(equalTo: textLabel.bottomAnchor,
                                      constant: top).isActive = true
        textView.widthAnchor.constraint(equalToConstant: width).isActive = true
        textView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupQuestionLabel() {
        let leading = 20.f
        let top = 20.f
        let height = 15.f
        let width = Session.width - (leading * 2)
        questionLabel.numberOfLines = 1
        questionLabel.textAlignment = .left
        questionLabel.font = .mediumSystemFontOfSize(size: 14)
        questionLabel.textColor = .white
        questionLabel.text = "Как Вам направить ответ?"
        scrollView.addSubview(questionLabel)
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                               constant: leading).isActive = true
        questionLabel.topAnchor.constraint(equalTo: textView.bottomAnchor,
                                           constant: top).isActive = true
        questionLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupEmailButton() {
        let top = 10.f
        let leading = 20.f
        let height = 20.f
        emailButton.setTitle("   По e-mail", for: .normal)
        emailButton.titleLabel?.font = .systemFontOfSize(size: 14)
        emailButton.setTitleColor(.white, for: .normal)
        emailButton.addTarget(self, action: #selector(emailCheckBoxPressed), for: .touchUpInside)
        scrollView.addSubview(emailButton)
        
        emailButton.translatesAutoresizingMaskIntoConstraints = false
        emailButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor,
                                         constant: top).isActive = true
        emailButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: leading).isActive = true
        emailButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupMessageButton() {
        let top = 10.f
        let leading = 20.f
        let height = 20.f
        messageButton.setTitle("   Через сообщения HelpDoctor", for: .normal)
        messageButton.titleLabel?.font = .systemFontOfSize(size: 14)
        messageButton.setTitleColor(.white, for: .normal)
        messageButton.addTarget(self, action: #selector(messageCheckBoxPressed), for: .touchUpInside)
        scrollView.addSubview(messageButton)
        
        messageButton.translatesAutoresizingMaskIntoConstraints = false
        messageButton.topAnchor.constraint(equalTo: emailButton.bottomAnchor,
                                           constant: top).isActive = true
        messageButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                               constant: leading).isActive = true
        messageButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupSendButton() {
        let top = 15.f
        let width = 150.f
        let height = 35.f
        sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
        scrollView.addSubview(sendButton)
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.topAnchor.constraint(equalTo: messageButton.bottomAnchor,
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
    @objc private func emailCheckBoxPressed() {
        emailButton.isSelected = !emailButton.isSelected
    }
    
    @objc private func messageCheckBoxPressed() {
        messageButton.isSelected = !messageButton.isSelected
    }
    
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

// MARK: - UITextViewDelegate
extension FeedbackViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Введите, пожалуйста, своё сообщение (максимально 300 символов)"
            && textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Введите, пожалуйста, своё сообщение (максимально 300 символов)"
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
    
}
