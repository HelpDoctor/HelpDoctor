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
    
    // MARK: - Constants and variables
    private let backgroundColor = UIColor.backgroundColor
    private let headerHeight = 60.f
    private let textFieldWidth = Session.width - 40
    private let textFieldHeight = 30.f
    private let scrollView = UIScrollView()
    private let titleLabel = UILabel()
    private let topLabel = UILabel()
    private let step1TitleLabel = UILabel()
    private let step1Label = UILabel()
    private let surnameTextField = UITextField()
    private let nameTextField = UITextField()
    private let patronymicTextField = UITextField()
    private let step2TitleLabel = UILabel()
    private let step2Label = UILabel()
    private let maleButton = RadioButton()
    private let femaleButton = RadioButton()
    private let nosexButton = RadioButton()
    private let birthDateTextField = UITextField()
    private let step3TitleLabel = UILabel()
    private let step3Label = UILabel()
    private let nextButton = HDButton(title: "Далее")
    private var keyboardHeight = 0.f
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        setupScrollView()
        setupHeaderView(color: backgroundColor, height: headerHeight, presenter: presenter)
        setupTitleLabel()
        setupTopLabel()
        setupStep1TitleLabel()
        setupStep1Label()
        setupSurnameTextField()
        setupNameTextField()
        setupPatronymicTextField()
        setupStep2TitleLabel()
        setupStep2Label()
        setupMaleButton()
        setupFemaleButton()
        setupNosexButton()
        setupStep3TitleLabel()
        setupStep3Label()
        setupBirthDateTextField()
        setupNextButton()
        addTapGestureToHideKeyboard()
        configureRadioButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.statusBarBackgroundColor = .clear
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Setup views
    /// Установка UIScrollView для сдвига экрана при появлении клавиатуры
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: Session.width, height: Session.height)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: headerHeight).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: Session.height).isActive = true
    }
    
    /// Установка заголовка
    private func setupTitleLabel() {
        let height = 20.f
        titleLabel.font = UIFont.boldSystemFontOfSize(size: 18)
        titleLabel.textColor = .white
        titleLabel.text = "Заполнение профиля"
        titleLabel.textAlignment = .center
        scrollView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка поясняющей надписи под заголовком
    private func setupTopLabel() {
        let top = 2.f
        let width = Session.width - 21
        let height = 51.f
        topLabel.font = UIFont.systemFontOfSize(size: 14)
        topLabel.textColor = .white
        topLabel.text =
        """
        Для создания профиля нужно внести данные о себе. Поля, отмеченные звездочкой (*), обязательны для заполнения
        """
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
    
    /// Установка заголовка Шаг 1
    private func setupStep1TitleLabel() {
        let height = 20.f
        step1TitleLabel.backgroundColor = .searchBarTintColor
        step1TitleLabel.font = UIFont.boldSystemFontOfSize(size: 14)
        step1TitleLabel.textColor = .white
        step1TitleLabel.text = "Шаг 1"
        step1TitleLabel.textAlignment = .center
        scrollView.addSubview(step1TitleLabel)
        
        step1TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step1TitleLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor).isActive = true
        step1TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step1TitleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        step1TitleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка поясняющей надписи перед заполнением данных шага 1
    private func setupStep1Label() {
        let top = 5.f
        let height = 15.f
        step1Label.font = UIFont.systemFontOfSize(size: 14)
        step1Label.textColor = .white
        step1Label.text = "Представьтесь, пожалуйста"
        step1Label.textAlignment = .left
        scrollView.addSubview(step1Label)
        
        step1Label.translatesAutoresizingMaskIntoConstraints = false
        step1Label.topAnchor.constraint(equalTo: step1TitleLabel.bottomAnchor,
                                        constant: top).isActive = true
        step1Label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step1Label.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        step1Label.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка поля ввода фамилии
    private func setupSurnameTextField() {
        let top = 10.f
        surnameTextField.font = UIFont.systemFontOfSize(size: 14)
        surnameTextField.textColor = .textFieldTextColor
        surnameTextField.placeholder = "Фамилия*"
        surnameTextField.textAlignment = .left
        surnameTextField.autocorrectionType = .no
        surnameTextField.backgroundColor = .white
        surnameTextField.layer.cornerRadius = 5
        surnameTextField.leftView = UIView(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: 8,
                                                         height: surnameTextField.frame.height))
        surnameTextField.leftViewMode = .always
        scrollView.addSubview(surnameTextField)
        
        surnameTextField.translatesAutoresizingMaskIntoConstraints = false
        surnameTextField.topAnchor.constraint(equalTo: step1Label.bottomAnchor,
                                              constant: top).isActive = true
        surnameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        surnameTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        surnameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
    }
    
    /// Установка поля ввода имени
    private func setupNameTextField() {
        let top = 10.f
        nameTextField.font = UIFont.systemFontOfSize(size: 14)
        nameTextField.textColor = .textFieldTextColor
        nameTextField.placeholder = "Имя*"
        nameTextField.textAlignment = .left
        nameTextField.autocorrectionType = .no
        nameTextField.backgroundColor = .white
        nameTextField.layer.cornerRadius = 5
        nameTextField.leftView = UIView(frame: CGRect(x: 0,
                                                      y: 0,
                                                      width: 8,
                                                      height: nameTextField.frame.height))
        nameTextField.leftViewMode = .always
        scrollView.addSubview(nameTextField)
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor,
                                           constant: top).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
    }
    
    /// Установка поля ввода отчества
    private func setupPatronymicTextField() {
        let top = 10.f
        patronymicTextField.font = UIFont.systemFontOfSize(size: 14)
        patronymicTextField.textColor = .textFieldTextColor
        patronymicTextField.placeholder = "Отчество"
        patronymicTextField.textAlignment = .left
        patronymicTextField.autocorrectionType = .no
        patronymicTextField.backgroundColor = .white
        patronymicTextField.layer.cornerRadius = 5
        patronymicTextField.leftView = UIView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: 8,
                                                            height: patronymicTextField.frame.height))
        patronymicTextField.leftViewMode = .always
        scrollView.addSubview(patronymicTextField)
        
        patronymicTextField.translatesAutoresizingMaskIntoConstraints = false
        patronymicTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor,
                                                 constant: top).isActive = true
        patronymicTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        patronymicTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        patronymicTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
    }
    
    /// Установка заголовка Шаг 2
    private func setupStep2TitleLabel() {
        let top = 20.f
        let height = 20.f
        step2TitleLabel.backgroundColor = .searchBarTintColor
        step2TitleLabel.font = UIFont.boldSystemFontOfSize(size: 14)
        step2TitleLabel.textColor = .white
        step2TitleLabel.text = "Шаг 2"
        step2TitleLabel.textAlignment = .center
        scrollView.addSubview(step2TitleLabel)
        
        step2TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step2TitleLabel.topAnchor.constraint(equalTo: patronymicTextField.bottomAnchor,
                                             constant: top).isActive = true
        step2TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step2TitleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        step2TitleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка поясняющей надписи перед вводом даты рождения
    private func setupStep2Label() {
        let top = 5.f
        let height = 15.f
        step2Label.font = UIFont.systemFontOfSize(size: 14)
        step2Label.textColor = .white
        step2Label.text = "Укажите, свой пол, пожалуйста"
        step2Label.textAlignment = .left
        scrollView.addSubview(step2Label)
        
        step2Label.translatesAutoresizingMaskIntoConstraints = false
        step2Label.topAnchor.constraint(equalTo: step2TitleLabel.bottomAnchor,
                                        constant: top).isActive = true
        step2Label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step2Label.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        step2Label.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка радиокнопки выбора мужского пола
    private func setupMaleButton() {
        let top = 9.f
        let leading = 20.f
        let height = 15.f
        let width = (Session.width / 2) - (leading * 2)
        maleButton.contentHorizontalAlignment = .left
        maleButton.setTitle(" Мужской", for: .normal)
        maleButton.titleLabel?.font = UIFont.boldSystemFontOfSize(size: 12)
        maleButton.setTitleColor(.white, for: .normal)
        maleButton.isSelected = false
        maleButton.addTarget(self, action: #selector(genderButtonPressed), for: .touchUpInside)
        scrollView.addSubview(maleButton)
        
        maleButton.translatesAutoresizingMaskIntoConstraints = false
        maleButton.topAnchor.constraint(equalTo: step2Label.bottomAnchor,
                                        constant: top).isActive = true
        maleButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                            constant: leading).isActive = true
        maleButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        maleButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка радиокнопки выбора женского пола
    private func setupFemaleButton() {
        let top = 11.f
        let leading = 20.f
        let height = 15.f
        femaleButton.contentHorizontalAlignment = .left
        femaleButton.setTitle(" Женский", for: .normal)
        femaleButton.titleLabel?.font = UIFont.boldSystemFontOfSize(size: 12)
        femaleButton.setTitleColor(.white, for: .normal)
        femaleButton.isSelected = false
        femaleButton.addTarget(self, action: #selector(genderButtonPressed), for: .touchUpInside)
        scrollView.addSubview(femaleButton)
        
        femaleButton.translatesAutoresizingMaskIntoConstraints = false
        femaleButton.topAnchor.constraint(equalTo: maleButton.bottomAnchor,
                                          constant: top).isActive = true
        femaleButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                              constant: leading).isActive = true
        femaleButton.widthAnchor.constraint(equalTo: maleButton.widthAnchor,
                                            multiplier: 1).isActive = true
        femaleButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка радиокнопки
    private func setupNosexButton() {
        let top = 9.f
        let leading = Session.width / 2 + 20.f
        let height = 15.f
        nosexButton.contentHorizontalAlignment = .left
        nosexButton.setTitle(" Не указывать", for: .normal)
        nosexButton.titleLabel?.font = UIFont.boldSystemFontOfSize(size: 12)
        nosexButton.setTitleColor(.white, for: .normal)
        nosexButton.isSelected = false
        nosexButton.addTarget(self, action: #selector(genderButtonPressed), for: .touchUpInside)
        scrollView.addSubview(nosexButton)
        
        nosexButton.translatesAutoresizingMaskIntoConstraints = false
        nosexButton.topAnchor.constraint(equalTo: step2Label.bottomAnchor,
                                         constant: top).isActive = true
        nosexButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: leading).isActive = true
        nosexButton.widthAnchor.constraint(equalTo: maleButton.widthAnchor,
                                           multiplier: 1).isActive = true
        nosexButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка заголовка Шаг 3
    private func setupStep3TitleLabel() {
        let top = 80.f
        let height = 20.f
        step3TitleLabel.backgroundColor = .searchBarTintColor
        step3TitleLabel.font = UIFont.boldSystemFontOfSize(size: 14)
        step3TitleLabel.textColor = .white
        step3TitleLabel.text = "Шаг 3"
        step3TitleLabel.textAlignment = .center
        scrollView.addSubview(step3TitleLabel)
        
        step3TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step3TitleLabel.topAnchor.constraint(equalTo: step2TitleLabel.bottomAnchor,
                                             constant: top).isActive = true
        step3TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step3TitleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        step3TitleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка поясняющей надписи перед вводом телефона
    private func setupStep3Label() {
        let top = 5.f
        let height = 15.f
        step3Label.font = UIFont.systemFontOfSize(size: 14)
        step3Label.textColor = .white
        step3Label.text = "Укажите дату рождения"
        step3Label.textAlignment = .left
        scrollView.addSubview(step3Label)
        
        step3Label.translatesAutoresizingMaskIntoConstraints = false
        step3Label.topAnchor.constraint(equalTo: step3TitleLabel.bottomAnchor,
                                        constant: top).isActive = true
        step3Label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step3Label.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        step3Label.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка поля ввода даты рождения
    private func setupBirthDateTextField() {
        let top = 10.f
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
        birthDateTextField.topAnchor.constraint(equalTo: step3Label.bottomAnchor,
                                                constant: top).isActive = true
        birthDateTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        birthDateTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        birthDateTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
    }
    
    /// Установка кнопки перехода к следующему экрану
    private func setupNextButton() {
        let width = 90.f
        let height = 30.f
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        nextButton.update(isEnabled: true)
        scrollView.addSubview(nextButton)
        
        let window = UIApplication.shared.keyWindow
        let bottomPadding = window?.safeAreaInsets.bottom
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: Session.width - 10).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: scrollView.topAnchor,
                                           constant: Session.height - (bottomPadding ?? 0) - 98).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    /// Настройка выбора радиокнопки
    private func configureRadioButtons() {
        maleButton.alternateButton = [femaleButton, nosexButton]
        femaleButton.alternateButton = [maleButton, nosexButton]
        nosexButton.alternateButton = [maleButton, femaleButton]
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
    
    // MARK: - IBActions
    /// Скрытие клавиатуры
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
    @objc private func genderButtonPressed() {
        if maleButton.isSelected {
            presenter?.setGender("male")
        } else if femaleButton.isSelected {
            presenter?.setGender("female")
        } else {
            presenter?.setGender("null")
        }
    }
    
    // MARK: - Navigation
    @objc private func nextButtonPressed() {
        guard let name = nameTextField.text,
            let lastname = surnameTextField.text,
            let middleName = patronymicTextField.text,
            let birthDate = birthDateTextField.text else { return }
        presenter?.next(name: name, lastname: lastname, middleName: middleName, birthDate: birthDate)
    }
}
//swiftlint:disable force_unwrapping
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
