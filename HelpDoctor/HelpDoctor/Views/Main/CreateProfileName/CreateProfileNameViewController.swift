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
    private var verticalInset = 0.f
    private let headerHeight = 60.f
    private let textFieldWidth = Session.width - 40
    private let heightTextField = 30.f
    private let heightTitleLabel = 20.f
    private let heightTopLabel = 68.f
    private let heightStep1Label = 15.f
    private let heightRadioButton = 20.f
    private let heightNextButton = 40.f
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
    private let maleButtonLabel = UILabel()
    private let femaleButton = RadioButton()
    private let femaleButtonLabel = UILabel()
    private let nosexButton = RadioButton()
    private let nosexButtonLabel = UILabel()
    private let nextButton = HDButton(title: "Далее")
    private var keyboardHeight = 0.f
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        let contentHeight = headerHeight + (heightTitleLabel * 3) + heightTopLabel + (heightStep1Label * 2)
            + (heightTextField * 3) + (heightRadioButton * 2) + heightNextButton
        verticalInset = (Session.height - UIApplication.shared.statusBarFrame.height - contentHeight) / 13
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
        setupMaleButtonLabel()
        setupFemaleButton()
        setupFemaleButtonLabel()
        setupNosexButton()
        setupNosexButtonLabel()
        setupNextButton()
        addTapGestureToHideKeyboard()
        configureRadioButtons()
        setUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .clear)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Private methods
    /// Установка значений из памяти устройства
    private func setUser() {
        surnameTextField.text = Session.instance.user?.last_name
        nameTextField.text = Session.instance.user?.first_name
        patronymicTextField.text = Session.instance.user?.middle_name
        switch Session.instance.user?.gender {
        case "male":
            maleButton.isSelected = true
            presenter?.setGender("male")
        case "female":
            femaleButton.isSelected = true
            presenter?.setGender("female")
        default:
            break
        }
    }
    
    // MARK: - Setup views
    /// Установка UIScrollView для сдвига экрана при появлении клавиатуры
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
    
    /// Установка заголовка
    private func setupTitleLabel() {
        titleLabel.font = .boldSystemFontOfSize(size: 18)
        titleLabel.textColor = .white
        titleLabel.text = "Заполнение профиля"
        titleLabel.textAlignment = .center
        scrollView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: heightTitleLabel).isActive = true
    }
    
    /// Установка поясняющей надписи под заголовком
    private func setupTopLabel() {
        let width = Session.width - 40
        topLabel.font = .systemFontOfSize(size: 14)
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
                                      constant: verticalInset).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        topLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: heightTopLabel).isActive = true
    }
    
    /// Установка заголовка Шаг 1
    private func setupStep1TitleLabel() {
        step1TitleLabel.backgroundColor = .searchBarTintColor
        step1TitleLabel.font = .boldSystemFontOfSize(size: 14)
        step1TitleLabel.textColor = .white
        step1TitleLabel.text = "Шаг 1"
        step1TitleLabel.textAlignment = .center
        scrollView.addSubview(step1TitleLabel)
        
        step1TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step1TitleLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                             constant: verticalInset).isActive = true
        step1TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step1TitleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        step1TitleLabel.heightAnchor.constraint(equalToConstant: heightTitleLabel).isActive = true
    }
    
    /// Установка поясняющей надписи перед заполнением данных шага 1
    private func setupStep1Label() {
        step1Label.font = .boldSystemFontOfSize(size: 14)
        step1Label.textColor = .white
        step1Label.text = "Представьтесь, пожалуйста"
        step1Label.textAlignment = .left
        scrollView.addSubview(step1Label)
        
        step1Label.translatesAutoresizingMaskIntoConstraints = false
        step1Label.topAnchor.constraint(equalTo: step1TitleLabel.bottomAnchor,
                                        constant: verticalInset).isActive = true
        step1Label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step1Label.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        step1Label.heightAnchor.constraint(equalToConstant: heightStep1Label).isActive = true
    }
    
    /// Установка поля ввода фамилии
    private func setupSurnameTextField() {
        surnameTextField.font = .systemFontOfSize(size: 14)
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
                                              constant: verticalInset).isActive = true
        surnameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        surnameTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        surnameTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    /// Установка поля ввода имени
    private func setupNameTextField() {
        nameTextField.font = .systemFontOfSize(size: 14)
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
                                           constant: verticalInset).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    /// Установка поля ввода отчества
    private func setupPatronymicTextField() {
        patronymicTextField.font = .systemFontOfSize(size: 14)
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
                                                 constant: verticalInset).isActive = true
        patronymicTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        patronymicTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        patronymicTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    /// Установка заголовка Шаг 2
    private func setupStep2TitleLabel() {
        step2TitleLabel.backgroundColor = .searchBarTintColor
        step2TitleLabel.font = .boldSystemFontOfSize(size: 14)
        step2TitleLabel.textColor = .white
        step2TitleLabel.text = "Шаг 2"
        step2TitleLabel.textAlignment = .center
        scrollView.addSubview(step2TitleLabel)
        
        step2TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step2TitleLabel.topAnchor.constraint(equalTo: patronymicTextField.bottomAnchor,
                                             constant: verticalInset).isActive = true
        step2TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step2TitleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        step2TitleLabel.heightAnchor.constraint(equalToConstant: heightTitleLabel).isActive = true
    }
    
    /// Установка поясняющей надписи перед вводом даты рождения
    private func setupStep2Label() {
        step2Label.font = .boldSystemFontOfSize(size: 14)
        step2Label.textColor = .white
        step2Label.text = "Укажите, свой пол, пожалуйста"
        step2Label.textAlignment = .left
        scrollView.addSubview(step2Label)
        
        step2Label.translatesAutoresizingMaskIntoConstraints = false
        step2Label.topAnchor.constraint(equalTo: step2TitleLabel.bottomAnchor,
                                        constant: verticalInset).isActive = true
        step2Label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step2Label.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        step2Label.heightAnchor.constraint(equalToConstant: heightStep1Label).isActive = true
    }
    
    /// Установка радиокнопки выбора мужского пола
    private func setupMaleButton() {
        let leading = 20.f
        maleButton.isSelected = false
        maleButton.addTarget(self, action: #selector(genderButtonPressed), for: .touchUpInside)
        scrollView.addSubview(maleButton)
        
        maleButton.translatesAutoresizingMaskIntoConstraints = false
        maleButton.topAnchor.constraint(equalTo: step2Label.bottomAnchor,
                                        constant: verticalInset).isActive = true
        maleButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                            constant: leading).isActive = true
        maleButton.widthAnchor.constraint(equalToConstant: heightRadioButton).isActive = true
        maleButton.heightAnchor.constraint(equalToConstant: heightRadioButton).isActive = true
    }
    
    /// Установка поясняющей надписи к радиокнопке
    private func setupMaleButtonLabel() {
        let leading = 5.f
        let width = 80.f
        maleButtonLabel.text = "Мужской"
        maleButtonLabel.font = .systemFontOfSize(size: 12)
        maleButtonLabel.textColor = .white
        scrollView.addSubview(maleButtonLabel)
        
        maleButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        maleButtonLabel.topAnchor.constraint(equalTo: maleButton.topAnchor).isActive = true
        maleButtonLabel.leadingAnchor.constraint(equalTo: maleButton.trailingAnchor, constant: leading).isActive = true
        maleButtonLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        maleButtonLabel.heightAnchor.constraint(equalTo: maleButton.heightAnchor).isActive = true
    }
    
    /// Установка радиокнопки выбора женского пола
    private func setupFemaleButton() {
        let leading = Session.width / 2 + 20.f
        femaleButton.isSelected = false
        femaleButton.addTarget(self, action: #selector(genderButtonPressed), for: .touchUpInside)
        scrollView.addSubview(femaleButton)
        
        femaleButton.translatesAutoresizingMaskIntoConstraints = false
        femaleButton.topAnchor.constraint(equalTo: maleButton.topAnchor).isActive = true
        femaleButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                              constant: leading).isActive = true
        femaleButton.widthAnchor.constraint(equalToConstant: heightRadioButton).isActive = true
        femaleButton.heightAnchor.constraint(equalToConstant: heightRadioButton).isActive = true
    }
    
    /// Установка поясняющей надписи к радиокнопке
    private func setupFemaleButtonLabel() {
        let leading = 5.f
        let width = 80.f
        femaleButtonLabel.text = "Женский"
        femaleButtonLabel.font = .systemFontOfSize(size: 12)
        femaleButtonLabel.textColor = .white
        scrollView.addSubview(femaleButtonLabel)
        
        femaleButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        femaleButtonLabel.topAnchor.constraint(equalTo: femaleButton.topAnchor).isActive = true
        femaleButtonLabel.leadingAnchor.constraint(equalTo: femaleButton.trailingAnchor,
                                                   constant: leading).isActive = true
        femaleButtonLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        femaleButtonLabel.heightAnchor.constraint(equalTo: femaleButton.heightAnchor).isActive = true
    }
    
    /// Установка радиокнопки
    private func setupNosexButton() {
        let leading = 20.f
        nosexButton.isSelected = false
        nosexButton.addTarget(self, action: #selector(genderButtonPressed), for: .touchUpInside)
        scrollView.addSubview(nosexButton)
        
        nosexButton.translatesAutoresizingMaskIntoConstraints = false
        nosexButton.topAnchor.constraint(equalTo: maleButton.bottomAnchor,
                                         constant: verticalInset).isActive = true
        nosexButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: leading).isActive = true
        nosexButton.widthAnchor.constraint(equalToConstant: heightRadioButton).isActive = true
        nosexButton.heightAnchor.constraint(equalToConstant: heightRadioButton).isActive = true
    }
    
    /// Установка поясняющей надписи к радиокнопке
    private func setupNosexButtonLabel() {
        let leading = 5.f
        let width = Session.width - 20 - 20 - leading - heightRadioButton //20 это leading и trailing у кнопок
        nosexButtonLabel.text = "Не указывать в профиле"
        nosexButtonLabel.font = .systemFontOfSize(size: 12)
        nosexButtonLabel.textColor = .white
        scrollView.addSubview(nosexButtonLabel)
        
        nosexButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        nosexButtonLabel.topAnchor.constraint(equalTo: nosexButton.topAnchor).isActive = true
        nosexButtonLabel.leadingAnchor.constraint(equalTo: nosexButton.trailingAnchor,
                                                  constant: leading).isActive = true
        nosexButtonLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        nosexButtonLabel.heightAnchor.constraint(equalTo: nosexButton.heightAnchor).isActive = true
    }
    
    /// Установка кнопки перехода к следующему экрану
    private func setupNextButton() {
        let width = 110.f
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        nextButton.update(isEnabled: true)
        scrollView.addSubview(nextButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: Session.width - 10).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: scrollView.topAnchor,
                                           constant: Session.height - Session.bottomPadding - 98).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: heightNextButton).isActive = true
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
    ///  Действие при нажатии на радиокнопку выбора пола
    @objc private func genderButtonPressed() {
        if maleButton.isSelected {
            presenter?.setGender("male")
        } else if femaleButton.isSelected {
            presenter?.setGender("female")
        } else {
            presenter?.setGender("null")
        }
    }
    
    /// Действие при нажатии кнопки далее
    @objc private func nextButtonPressed() {
        guard let name = nameTextField.text,
            let lastname = surnameTextField.text,
            let middleName = patronymicTextField.text else { return }
        presenter?.next(name: name, lastname: lastname, middleName: middleName)
    }
}
