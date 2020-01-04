//
//  CreateProfileNameViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 31.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class CreateProfileNameViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: CreateProfileNamePresenterProtocol?
    
    // MARK: - Constants
    private let scrollView = UIScrollView()
    private var headerView = HeaderView()
    private let titleLabel = UILabel()
    private let topLabel = UILabel()
    private let step1TitleLabel = UILabel()
    private let step1Label = UILabel()
    private let surnameTextField = UITextField()
    private let nameTextField = UITextField()
    private let patronymicTextField = UITextField()
    private let step2TitleLabel = UILabel()
    private let step2Label = UILabel()
    private let birthDateTextField = UITextField()
    private let step3TitleLabel = UILabel()
    private let step3Label = UILabel()
    private let phoneTextField = UITextField()
    private let nextButton = UIButton()
    private var keyboardHeight: CGFloat = 0
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupScrollView()
        setupHeaderView()
        setupTitleLabel()
        setupTopLabel()
        setupStep1TitleLabel()
        setupStep1Label()
        setupSurnameTextField()
        setupNameTextField()
        setupPatronymicTextField()
        setupStep2TitleLabel()
        setupStep2Label()
        setupBirthDateTextField()
        setupStep3TitleLabel()
        setupStep3Label()
        setupPhoneTextField()
        setupNextButton()
        addTapGestureToHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.statusBarBackgroundColor = .clear
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Setup views
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
        titleLabel.text = "Профиль"
        titleLabel.textAlignment = .center
        scrollView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupTopLabel() {
        topLabel.font = UIFont.systemFontOfSize(size: 14)
        topLabel.textColor = .white
        //swiftlint:disable line_length
        topLabel.text = "Для создания профиля нужно внести данные о себе. Поля, отмеченные *, обязательны для заполнения"
        //swiftlint:enable line_length
        topLabel.textAlignment = .left
        topLabel.numberOfLines = 0
        scrollView.addSubview(topLabel)
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                      constant: 6).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        topLabel.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 51).isActive = true
    }
    
    private func setupStep1TitleLabel() {
        step1TitleLabel.font = UIFont.boldSystemFontOfSize(size: 14)
        step1TitleLabel.textColor = .white
        step1TitleLabel.text = "Шаг 1"
        step1TitleLabel.textAlignment = .center
        scrollView.addSubview(step1TitleLabel)
        
        step1TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step1TitleLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 25).isActive = true
        step1TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step1TitleLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        step1TitleLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    private func setupStep1Label() {
        step1Label.font = UIFont.systemFontOfSize(size: 14)
        step1Label.textColor = .white
        step1Label.text = "Представьтесь, пожалуйста"
        step1Label.textAlignment = .left
        scrollView.addSubview(step1Label)
        
        step1Label.translatesAutoresizingMaskIntoConstraints = false
        step1Label.topAnchor.constraint(equalTo: step1TitleLabel.bottomAnchor, constant: 5).isActive = true
        step1Label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step1Label.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        step1Label.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    private func setupSurnameTextField() {
        surnameTextField.font = UIFont.systemFontOfSize(size: 14)
        surnameTextField.textColor = .textFieldTextColor
        surnameTextField.placeholder = "Фамилия*"
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
        surnameTextField.topAnchor.constraint(equalTo: step1Label.bottomAnchor, constant: 5).isActive = true
        surnameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        surnameTextField.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        surnameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupNameTextField() {
        nameTextField.font = UIFont.systemFontOfSize(size: 14)
        nameTextField.textColor = .textFieldTextColor
        nameTextField.placeholder = "Имя*"
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
        nameTextField.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 10).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupPatronymicTextField() {
        patronymicTextField.font = UIFont.systemFontOfSize(size: 14)
        patronymicTextField.textColor = .textFieldTextColor
        patronymicTextField.placeholder = "Отчество"
        patronymicTextField.textAlignment = .left
        patronymicTextField.backgroundColor = .white
        patronymicTextField.layer.cornerRadius = 5
        patronymicTextField.leftView = UIView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: 8,
                                                            height: patronymicTextField.frame.height))
        patronymicTextField.leftViewMode = .always
        scrollView.addSubview(patronymicTextField)
        
        patronymicTextField.translatesAutoresizingMaskIntoConstraints = false
        patronymicTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
        patronymicTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        patronymicTextField.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        patronymicTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupStep2TitleLabel() {
        step2TitleLabel.font = UIFont.boldSystemFontOfSize(size: 14)
        step2TitleLabel.textColor = .white
        step2TitleLabel.text = "Шаг 2"
        step2TitleLabel.textAlignment = .center
        scrollView.addSubview(step2TitleLabel)
        
        step2TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step2TitleLabel.topAnchor.constraint(equalTo: patronymicTextField.bottomAnchor, constant: 12).isActive = true
        step2TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step2TitleLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        step2TitleLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    private func setupStep2Label() {
        step2Label.font = UIFont.systemFontOfSize(size: 14)
        step2Label.textColor = .white
        step2Label.text = "Укажите дату рождения"
        step2Label.textAlignment = .left
        scrollView.addSubview(step2Label)
        
        step2Label.translatesAutoresizingMaskIntoConstraints = false
        step2Label.topAnchor.constraint(equalTo: step2TitleLabel.bottomAnchor, constant: 5).isActive = true
        step2Label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step2Label.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        step2Label.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    private func setupBirthDateTextField() {
        birthDateTextField.delegate = self
        birthDateTextField.font = UIFont.systemFontOfSize(size: 14)
        birthDateTextField.textColor = .textFieldTextColor
        birthDateTextField.keyboardType = .numberPad
        birthDateTextField.placeholder = "__.__.____*"
        birthDateTextField.textAlignment = .left
        birthDateTextField.backgroundColor = .white
        birthDateTextField.layer.cornerRadius = 5
        birthDateTextField.leftView = UIView(frame: CGRect(x: 0,
                                                           y: 0,
                                                           width: 8,
                                                           height: birthDateTextField.frame.height))
        birthDateTextField.leftViewMode = .always
        scrollView.addSubview(birthDateTextField)

        birthDateTextField.translatesAutoresizingMaskIntoConstraints = false
        birthDateTextField.topAnchor.constraint(equalTo: step2Label.bottomAnchor, constant: 5).isActive = true
        birthDateTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        birthDateTextField.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        birthDateTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupStep3TitleLabel() {
        step3TitleLabel.font = UIFont.boldSystemFontOfSize(size: 14)
        step3TitleLabel.textColor = .white
        step3TitleLabel.text = "Шаг 3"
        step3TitleLabel.textAlignment = .center
        scrollView.addSubview(step3TitleLabel)
        
        step3TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step3TitleLabel.topAnchor.constraint(equalTo: birthDateTextField.bottomAnchor, constant: 12).isActive = true
        step3TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step3TitleLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        step3TitleLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    private func setupStep3Label() {
        step3Label.font = UIFont.systemFontOfSize(size: 14)
        step3Label.textColor = .white
        step3Label.text = "Укажите, пожалуйста, номер телефона"
        step3Label.textAlignment = .left
        scrollView.addSubview(step3Label)
        
        step3Label.translatesAutoresizingMaskIntoConstraints = false
        step3Label.topAnchor.constraint(equalTo: step3TitleLabel.bottomAnchor, constant: 5).isActive = true
        step3Label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step3Label.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        step3Label.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    private func setupPhoneTextField() {
        phoneTextField.font = UIFont.systemFontOfSize(size: 14)
        phoneTextField.textColor = .textFieldTextColor
        phoneTextField.keyboardType = .phonePad
        phoneTextField.placeholder = "+7 (xxx) xxx-xx-xx*"
        phoneTextField.textAlignment = .left
        phoneTextField.backgroundColor = .white
        phoneTextField.layer.cornerRadius = 5
        phoneTextField.leftView = UIView(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: 8,
                                                       height: phoneTextField.frame.height))
        phoneTextField.leftViewMode = .always
        scrollView.addSubview(phoneTextField)
        
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.topAnchor.constraint(equalTo: step3Label.bottomAnchor, constant: 5).isActive = true
        phoneTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        phoneTextField.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        phoneTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupNextButton() {
        let titleButton = "Далее >"
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        nextButton.titleLabel?.font = UIFont.boldSystemFontOfSize(size: 18)
        nextButton.titleLabel?.textColor = .white
        nextButton.setTitle(titleButton, for: .normal)
        scrollView.addSubview(nextButton)
        
        let window = UIApplication.shared.keyWindow
        let bottomPadding = window?.safeAreaInsets.bottom
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: width - 36).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: scrollView.topAnchor,
                                           constant: height - (bottomPadding ?? 0) - 38).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
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
    
    // MARK: - Navigation
    @objc private func nextButtonPressed() {
        guard let name = nameTextField.text,
            let lastname = surnameTextField.text,
            let middleName = patronymicTextField.text,
            let birthDate = birthDateTextField.text,
            let phone = phoneTextField.text else { return }
        presenter?.next(name: name, lastname: lastname, middleName: middleName, birthDate: birthDate, phone: phone)
    }
}

extension CreateProfileNameViewController: UITextFieldDelegate {
    // MARK: - text field masking
    internal func textField(_ textField: UITextField,
                            shouldChangeCharactersIn range: NSRange,
                            replacementString string: String) -> Bool {
        
        // MARK: - If Delete button click
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if isBackSpace == -92 {
            textField.text!.removeLast()
            return false
        }
        
        if textField == birthDateTextField {
            if (textField.text?.count)! == 2 {
                textField.text = "\(textField.text!)."
            } else if (textField.text?.count)! == 5 {
                textField.text = "\(textField.text!)."
            } else if (textField.text?.count)! > 9 {
                return false
            }
        }
        return true
    }
}
