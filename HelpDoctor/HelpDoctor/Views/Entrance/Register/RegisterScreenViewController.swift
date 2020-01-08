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
    
    // MARK: - Constants
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    private let scrollView = UIScrollView()
    private let titleLabel = UILabel()
    private let topLabel = UILabel()
    private let bottomLabel = UILabel()
    private let topEmailTextField = UITextField()
    private let textFieldLabel = UILabel()
    private let bottomEmailTextField = UITextField()
    private var registerButton = HDButton()
    private let backButton = UIButton()
    private var imageViewTopEmailSuccess = UIImageView()
    private var imageViewBottomEmailSuccess = UIImageView()
    private var keyboardHeight: CGFloat = 0
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupActivityIndicator()
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Public methods
    func updateTopEmailSuccess(image: UIImage?) {
        imageViewTopEmailSuccess.image = image
    }
    
    func updateBottomEmailSuccess(image: UIImage?) {
        imageViewBottomEmailSuccess.image = image
    }
    
    func updateButtonRegister(isEnabled: Bool) {
        self.registerButton.update(isEnabled: isEnabled)
    }
    
    // MARK: - Setup views
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.layer.zPosition = 1
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
    }
    
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: width, height: height)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: view.frame.size.height).isActive = true
    }
    
    private func setupTitleLabel() {
        titleLabel.font = UIFont.boldSystemFontOfSize(size: 18)
        titleLabel.textColor = .white
        titleLabel.text = "Регистрация"
        titleLabel.textAlignment = .center
        scrollView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 54).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    private func setupTopLabel() {
        topLabel.font = UIFont.systemFontOfSize(size: 14)
        topLabel.textColor = .white
        topLabel.text = "Чтобы воспользоваться функциями нашей программы, пожалуйста, зарегистрируйтесь."
        topLabel.textAlignment = .left
        topLabel.numberOfLines = 0
        scrollView.addSubview(topLabel)
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                      constant: 45).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        topLabel.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 51).isActive = true
    }
    
    private func setupBottomLabel() {
        bottomLabel.font = UIFont.systemFontOfSize(size: 14)
        bottomLabel.textColor = .white
        bottomLabel.text = "Укажите свой e-mail в поле ниже. На него будет выслан пароль для входа."
        bottomLabel.textAlignment = .left
        bottomLabel.numberOfLines = 0
        scrollView.addSubview(bottomLabel)
        
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                         constant: 17).isActive = true
        bottomLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        bottomLabel.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        bottomLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    private func setupTopEmailTextField() {
        topEmailTextField.addTarget(self,
                                    action: #selector(self.topEmailChanged(_:)),
                                    for: UIControl.Event.editingChanged)
        topEmailTextField.rightView = imageViewTopEmailSuccess
        topEmailTextField.rightViewMode = .always
        imageViewTopEmailSuccess.contentMode = .scaleAspectFit
        topEmailTextField.font = UIFont.systemFontOfSize(size: 14)
        topEmailTextField.keyboardType = .emailAddress
        topEmailTextField.textColor = .textFieldTextColor
        topEmailTextField.placeholder = "E-mail*"
        topEmailTextField.textAlignment = .left
        topEmailTextField.backgroundColor = .white
        topEmailTextField.layer.cornerRadius = 5
        topEmailTextField.leftView = UIView(frame: CGRect(x: 0,
                                                          y: 0,
                                                          width: 8,
                                                          height: topEmailTextField.frame.height))
        topEmailTextField.leftViewMode = .always
        scrollView.addSubview(topEmailTextField)
        
        topEmailTextField.translatesAutoresizingMaskIntoConstraints = false
        topEmailTextField.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 12).isActive = true
        topEmailTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        topEmailTextField.widthAnchor.constraint(equalToConstant: width - 114).isActive = true
        topEmailTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupTextFieldLabel() {
        textFieldLabel.font = UIFont.systemFontOfSize(size: 14)
        textFieldLabel.textColor = .white
        textFieldLabel.text = "Подтвердите свой e-mail, пожалуйста"
        textFieldLabel.textAlignment = .left
        textFieldLabel.numberOfLines = 0
        scrollView.addSubview(textFieldLabel)
        
        textFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        textFieldLabel.topAnchor.constraint(equalTo: topEmailTextField.bottomAnchor,
                                         constant: 20).isActive = true
        textFieldLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        textFieldLabel.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        textFieldLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    private func setupBottomEmailTextField() {
        bottomEmailTextField.addTarget(self,
                                       action: #selector(self.bottomEmailChanged(_:)),
                                       for: UIControl.Event.editingChanged)
        bottomEmailTextField.rightView = imageViewBottomEmailSuccess
        bottomEmailTextField.rightViewMode = .always
        imageViewBottomEmailSuccess.contentMode = .scaleAspectFit
        bottomEmailTextField.font = UIFont.systemFontOfSize(size: 14)
        bottomEmailTextField.keyboardType = .emailAddress
        bottomEmailTextField.textColor = .textFieldTextColor
        bottomEmailTextField.placeholder = "E-mail*"
        bottomEmailTextField.textAlignment = .left
        bottomEmailTextField.backgroundColor = .white
        bottomEmailTextField.layer.cornerRadius = 5
        bottomEmailTextField.leftView = UIView(frame: CGRect(x: 0,
                                                             y: 0,
                                                             width: 8,
                                                             height: bottomEmailTextField.frame.height))
        bottomEmailTextField.leftViewMode = .always
        scrollView.addSubview(bottomEmailTextField)
        
        bottomEmailTextField.translatesAutoresizingMaskIntoConstraints = false
        bottomEmailTextField.topAnchor.constraint(equalTo: textFieldLabel.bottomAnchor, constant: 12).isActive = true
        bottomEmailTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        bottomEmailTextField.widthAnchor.constraint(equalToConstant: width - 114).isActive = true
        bottomEmailTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupRegisterButton() {
        registerButton = HDButton(title: "Отправить")
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        registerButton.update(isEnabled: false)
        scrollView.addSubview(registerButton)
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.topAnchor.constraint(equalTo: bottomEmailTextField.bottomAnchor,
                                            constant: 34).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
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
    @objc func topEmailChanged(_ textField: UITextField) {
        presenter?.topEmailChanged(topEmail: textField.text)
    }
    
    @objc func bottomEmailChanged(_ textField: UITextField) {
        presenter?.bottomEmailChanged(bottomEmail: textField.text)
    }
    
    @objc func hideKeyboard() {
        scrollView.endEditing(true)
        view.viewWithTag(998)?.removeFromSuperview()
        view.viewWithTag(999)?.removeFromSuperview()
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
    @objc private func registerButtonPressed() {
        guard let email = bottomEmailTextField.text else { return }
        presenter?.registerButtonPressed(email: email)
    }
    
    // MARK: - Navigation
    @objc private func backButtonPressed() {
        presenter?.back()
    }
}
