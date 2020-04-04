//
//  CreateProfileScreen2ViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 19.03.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class CreateProfileScreen2ViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: CreateProfileScreen2PresenterProtocol?
    
    // MARK: - Constants and variables
    private let backgroundColor = UIColor.backgroundColor
    private let headerHeight = 60.f
    private let textFieldWidth = Session.width - 40
    private let textFieldHeight = 30.f
    private let scrollView = UIScrollView()
    private let step4TitleLabel = UILabel()
    private let step4Label = UILabel()
    private let phoneTextField = UITextField()
    private let step5TitleLabel = UILabel()
    private let step5Label = UILabel()
    private let regionTextField = UITextField()
    private let cityTextField = UITextField()
    private let step6TitleLabel = UILabel()
    private let step6Label = UILabel()
    private let universityTextField = UITextField()
    private let dateOfGraduateTextField = PickerField()
    private let graduateLabel = UILabel()
    private let academicButton = RadioButton()
    private let doctorButton = RadioButton()
    private let candidateButton = RadioButton()
    private let professorButton = RadioButton()
    private let docentButton = RadioButton()
    private let nodegreeButton = RadioButton()
    private let nextButton = HDButton(title: "Далее")
    private var keyboardHeight = 0.f
    private var heightScroll = Session.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        setupScrollView()
        setupHeaderView(color: backgroundColor, height: headerHeight, presenter: presenter)
        setupStep4TitleLabel()
        setupStep4Label()
        setupPhoneTextField()
        setupStep5TitleLabel()
        setupStep5Label()
        setupRegionTextField()
        setupCityTextField()
        setupStep6TitleLabel()
        setupStep6Label()
        setupUniversityTextFiled()
        setupDateOfGraduateTextField()
        setupGraduateLabel()
        setupAcademicButton()
        setupDoctorButton()
        setupCandidateButton()
        setupProfessorButton()
        setupDocentButton()
        setupNodegreeButton()
        setupNextButton()
        addTapGestureToHideKeyboard()
        configureRadioButtons()
        setUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .clear)
        tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Public methods
    /// Заполнение региона в поле ввода
    /// - Parameter region: регион
    func setRegion(region: String) {
        regionTextField.text = region
    }
    
    /// Заполнение города в поле воода
    /// - Parameter city: город
    func setCity(city: String) {
        cityTextField.text = city
    }
    
    // MARK: - Private methods
    private func setUser() {
        phoneTextField.text = Session.instance.user?.phone_number
        regionTextField.text = Session.instance.user?.regionName
        cityTextField.text = Session.instance.user?.cityName
        guard let regionId = Session.instance.user?.regionId else { return }
        presenter?.setRegionFromDevice(regionId)
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
    
    /// Установка заголовка Шаг 4
    private func setupStep4TitleLabel() {
        let height = 20.f
        step4TitleLabel.backgroundColor = .searchBarTintColor
        step4TitleLabel.font = UIFont.boldSystemFontOfSize(size: 14)
        step4TitleLabel.textColor = .white
        step4TitleLabel.text = "Шаг 4"
        step4TitleLabel.textAlignment = .center
        scrollView.addSubview(step4TitleLabel)
        
        step4TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step4TitleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        step4TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step4TitleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        step4TitleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка поясняющей надписи перед заполнением данных шага 1
    private func setupStep4Label() {
        let top = 5.f
        let height = 15.f
        step4Label.font = UIFont.systemFontOfSize(size: 14)
        step4Label.textColor = .white
        step4Label.text = "Укажите, пожалуйста, номер телефона"
        step4Label.textAlignment = .left
        scrollView.addSubview(step4Label)
        
        step4Label.translatesAutoresizingMaskIntoConstraints = false
        step4Label.topAnchor.constraint(equalTo: step4TitleLabel.bottomAnchor,
                                        constant: top).isActive = true
        step4Label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step4Label.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        step4Label.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка поля ввода телефона
    private func setupPhoneTextField() {
        let top = 5.f
        phoneTextField.delegate = self
        phoneTextField.font = UIFont.systemFontOfSize(size: 14)
        phoneTextField.textColor = .textFieldTextColor
        phoneTextField.keyboardType = .numberPad
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
        phoneTextField.topAnchor.constraint(equalTo: step4Label.bottomAnchor,
                                            constant: top).isActive = true
        phoneTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        phoneTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        phoneTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
    }
    
    /// Установка заголовка Шаг 5
    private func setupStep5TitleLabel() {
        let top = 20.f
        let height = 20.f
        step5TitleLabel.backgroundColor = .searchBarTintColor
        step5TitleLabel.font = UIFont.boldSystemFontOfSize(size: 14)
        step5TitleLabel.textColor = .white
        step5TitleLabel.text = "Шаг 5"
        step5TitleLabel.textAlignment = .center
        scrollView.addSubview(step5TitleLabel)
        
        step5TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step5TitleLabel.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor,
                                             constant: top).isActive = true
        step5TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step5TitleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        step5TitleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка поясняющей надписи перед вводом даты рождения
    private func setupStep5Label() {
        let top = 5.f
        let height = 15.f
        step5Label.font = UIFont.systemFontOfSize(size: 14)
        step5Label.textColor = .white
        step5Label.text = "Укажите свое место жительства"
        step5Label.textAlignment = .left
        scrollView.addSubview(step5Label)
        
        step5Label.translatesAutoresizingMaskIntoConstraints = false
        step5Label.topAnchor.constraint(equalTo: step5TitleLabel.bottomAnchor,
                                        constant: top).isActive = true
        step5Label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step5Label.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        step5Label.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка поля ввода региона места жительства
    private func setupRegionTextField() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(regionSearchButtonPressed))
        let top = 10.f
        heightScroll += top + textFieldHeight
        
        regionTextField.font = UIFont.systemFontOfSize(size: 14)
        regionTextField.textColor = .textFieldTextColor
        regionTextField.textAlignment = .left
        regionTextField.backgroundColor = .white
        regionTextField.layer.cornerRadius = 5
        regionTextField.leftView = UIView(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: 8,
                                                        height: regionTextField.frame.height))
        regionTextField.leftViewMode = .always
        regionTextField.placeholder = "Субъект*"
        regionTextField.addGestureRecognizer(tap)
        scrollView.addSubview(regionTextField)
        
        regionTextField.translatesAutoresizingMaskIntoConstraints = false
        regionTextField.topAnchor.constraint(equalTo: step5Label.bottomAnchor,
                                             constant: top).isActive = true
        regionTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        regionTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        regionTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
    }
    
    /// Установка поля ввода города места жительства
    private func setupCityTextField() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(citySearchButtonPressed))
        let top = 10.f
        heightScroll += top + textFieldHeight
        cityTextField.font = UIFont.systemFontOfSize(size: 14)
        cityTextField.textColor = .textFieldTextColor
        cityTextField.textAlignment = .left
        cityTextField.backgroundColor = .white
        cityTextField.layer.cornerRadius = 5
        cityTextField.leftView = UIView(frame: CGRect(x: 0,
                                                      y: 0,
                                                      width: 8,
                                                      height: cityTextField.frame.height))
        cityTextField.leftViewMode = .always
        cityTextField.placeholder = "Город / район*"
        cityTextField.addGestureRecognizer(tap)
        scrollView.addSubview(cityTextField)
        
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        cityTextField.topAnchor.constraint(equalTo: regionTextField.bottomAnchor,
                                           constant: top).isActive = true
        cityTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        cityTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        cityTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
    }
    
    /// Установка заголовка Шаг 6
    private func setupStep6TitleLabel() {
        let top = 20.f
        let height = 20.f
        step6TitleLabel.backgroundColor = .searchBarTintColor
        step6TitleLabel.font = UIFont.boldSystemFontOfSize(size: 14)
        step6TitleLabel.textColor = .white
        step6TitleLabel.text = "Шаг 6"
        step6TitleLabel.textAlignment = .center
        scrollView.addSubview(step6TitleLabel)
        
        step6TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step6TitleLabel.topAnchor.constraint(equalTo: cityTextField.bottomAnchor,
                                             constant: top).isActive = true
        step6TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step6TitleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        step6TitleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка поясняющей надписи перед вводом телефона
    private func setupStep6Label() {
        let top = 5.f
        let height = 15.f
        step6Label.font = UIFont.systemFontOfSize(size: 14)
        step6Label.textColor = .white
        step6Label.text = "Укажите информацию об образовании"
        step6Label.textAlignment = .left
        scrollView.addSubview(step6Label)
        
        step6Label.translatesAutoresizingMaskIntoConstraints = false
        step6Label.topAnchor.constraint(equalTo: step6TitleLabel.bottomAnchor,
                                        constant: top).isActive = true
        step6Label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step6Label.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        step6Label.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка поля ввода университета
    private func setupUniversityTextFiled() {
        let top = 10.f
        heightScroll += top + textFieldHeight
        universityTextField.autocorrectionType = .no
        universityTextField.font = UIFont.systemFontOfSize(size: 14)
        universityTextField.textColor = .textFieldTextColor
        universityTextField.textAlignment = .left
        universityTextField.backgroundColor = .white
        universityTextField.layer.cornerRadius = 5
        universityTextField.leftView = UIView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: 8,
                                                            height: universityTextField.frame.height))
        universityTextField.leftViewMode = .always
        universityTextField.placeholder = "Учебное заведение*"
        scrollView.addSubview(universityTextField)
        
        universityTextField.translatesAutoresizingMaskIntoConstraints = false
        universityTextField.topAnchor.constraint(equalTo: step6Label.bottomAnchor,
                                                 constant: top).isActive = true
        universityTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        universityTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        universityTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
    }
    
    /// Установка поля ввода даты окончания учебы
    private func setupDateOfGraduateTextField() {
        let top = 10.f
        heightScroll += top + textFieldHeight
        dateOfGraduateTextField.titleLabel?.text = "Укажиет дату выпуска"
        dateOfGraduateTextField.font = UIFont.systemFontOfSize(size: 14)
        dateOfGraduateTextField.textColor = .textFieldTextColor
        dateOfGraduateTextField.textAlignment = .left
        dateOfGraduateTextField.backgroundColor = .white
        dateOfGraduateTextField.layer.cornerRadius = 5
        dateOfGraduateTextField.leftView = UIView(frame: CGRect(x: 0,
                                                                y: 0,
                                                                width: 8,
                                                                height: dateOfGraduateTextField.frame.height))
        dateOfGraduateTextField.leftViewMode = .always
        dateOfGraduateTextField.placeholder = "__.__.____* (Дата выпуска)"
        dateOfGraduateTextField.type = .datePicker
        dateOfGraduateTextField.pickerFieldDelegate = presenter
        dateOfGraduateTextField.datePicker?.datePickerMode = .date
        dateOfGraduateTextField.datePicker?.maximumDate = Date()
        dateOfGraduateTextField.rightImageView.image = UIImage(named: "calendar")
        scrollView.addSubview(dateOfGraduateTextField)
        
        dateOfGraduateTextField.translatesAutoresizingMaskIntoConstraints = false
        dateOfGraduateTextField.topAnchor.constraint(equalTo: universityTextField.bottomAnchor,
                                                     constant: top).isActive = true
        dateOfGraduateTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        dateOfGraduateTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        dateOfGraduateTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
    }
    
    /// Установка поясняющей надписи перед вводом даты окончания учебы
    private func setupGraduateLabel() {
        let top = 5.f
        let height = 15.f
        graduateLabel.font = UIFont.systemFontOfSize(size: 14)
        graduateLabel.textColor = .white
        graduateLabel.text = "Ученая степень"
        graduateLabel.textAlignment = .left
        scrollView.addSubview(graduateLabel)
        
        graduateLabel.translatesAutoresizingMaskIntoConstraints = false
        graduateLabel.topAnchor.constraint(equalTo: dateOfGraduateTextField.bottomAnchor,
                                           constant: top).isActive = true
        graduateLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        graduateLabel.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        graduateLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка радиокнопки выбора академика наук
    private func setupAcademicButton() {
        let top = 9.f
        let leading = 20.f
        let height = 15.f
        let width = (Session.width / 2) - (leading * 2)
        academicButton.contentHorizontalAlignment = .left
        academicButton.setTitle(" Академик наук", for: .normal)
        academicButton.titleLabel?.font = .systemFontOfSize(size: 12)
        academicButton.setTitleColor(.white, for: .normal)
        academicButton.isSelected = false
        scrollView.addSubview(academicButton)
        
        academicButton.translatesAutoresizingMaskIntoConstraints = false
        academicButton.topAnchor.constraint(equalTo: graduateLabel.bottomAnchor,
                                            constant: top).isActive = true
        academicButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                constant: leading).isActive = true
        academicButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        academicButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка радиокнопки выбора доктора наук
    private func setupDoctorButton() {
        let top = 9.f
        let leading = 20.f
        let height = 15.f
        doctorButton.contentHorizontalAlignment = .left
        doctorButton.setTitle(" Доктор наук", for: .normal)
        doctorButton.titleLabel?.font = .systemFontOfSize(size: 12)
        doctorButton.setTitleColor(.white, for: .normal)
        doctorButton.isSelected = false
        scrollView.addSubview(doctorButton)
        
        doctorButton.translatesAutoresizingMaskIntoConstraints = false
        doctorButton.topAnchor.constraint(equalTo: academicButton.bottomAnchor,
                                          constant: top).isActive = true
        doctorButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                              constant: leading).isActive = true
        doctorButton.widthAnchor.constraint(equalTo: academicButton.widthAnchor,
                                            multiplier: 1).isActive = true
        doctorButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка радиокнопки выбора кандидата наук
    private func setupCandidateButton() {
        let top = 9.f
        let leading = 20.f
        let height = 15.f
        candidateButton.contentHorizontalAlignment = .left
        candidateButton.setTitle(" Кандидат наук", for: .normal)
        candidateButton.titleLabel?.font = .systemFontOfSize(size: 12)
        candidateButton.setTitleColor(.white, for: .normal)
        candidateButton.isSelected = false
        scrollView.addSubview(candidateButton)
        
        candidateButton.translatesAutoresizingMaskIntoConstraints = false
        candidateButton.topAnchor.constraint(equalTo: doctorButton.bottomAnchor,
                                             constant: top).isActive = true
        candidateButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                 constant: leading).isActive = true
        candidateButton.widthAnchor.constraint(equalTo: academicButton.widthAnchor,
                                               multiplier: 1).isActive = true
        candidateButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка радиокнопки выбора профессора
    private func setupProfessorButton() {
        let top = 9.f
        let leading = Session.width / 2 + 20
        let height = 15.f
        professorButton.contentHorizontalAlignment = .left
        professorButton.setTitle(" Профессор", for: .normal)
        professorButton.titleLabel?.font = .systemFontOfSize(size: 12)
        professorButton.setTitleColor(.white, for: .normal)
        professorButton.isSelected = false
        scrollView.addSubview(professorButton)
        
        professorButton.translatesAutoresizingMaskIntoConstraints = false
        professorButton.topAnchor.constraint(equalTo: graduateLabel.bottomAnchor,
                                             constant: top).isActive = true
        professorButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                 constant: leading).isActive = true
        professorButton.widthAnchor.constraint(equalTo: academicButton.widthAnchor,
                                               multiplier: 1).isActive = true
        professorButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка радиокнопки выбора доцента
    private func setupDocentButton() {
        let top = 9.f
        let leading = Session.width / 2 + 20
        let height = 15.f
        docentButton.contentHorizontalAlignment = .left
        docentButton.setTitle(" Доцент", for: .normal)
        docentButton.titleLabel?.font = .systemFontOfSize(size: 12)
        docentButton.setTitleColor(.white, for: .normal)
        docentButton.isSelected = false
        scrollView.addSubview(docentButton)
        
        docentButton.translatesAutoresizingMaskIntoConstraints = false
        docentButton.topAnchor.constraint(equalTo: professorButton.bottomAnchor,
                                          constant: top).isActive = true
        docentButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                              constant: leading).isActive = true
        docentButton.widthAnchor.constraint(equalTo: academicButton.widthAnchor,
                                            multiplier: 1).isActive = true
        docentButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка радиокнопки выбора значения без степени
    private func setupNodegreeButton() {
        let top = 9.f
        let leading = 0.f
        let height = 15.f
        nodegreeButton.contentHorizontalAlignment = .left
        nodegreeButton.setTitle(" Нет степени", for: .normal)
        nodegreeButton.titleLabel?.font = .systemFontOfSize(size: 12)
        nodegreeButton.setTitleColor(.white, for: .normal)
        nodegreeButton.isSelected = false
        scrollView.addSubview(nodegreeButton)
        
        nodegreeButton.translatesAutoresizingMaskIntoConstraints = false
        nodegreeButton.topAnchor.constraint(equalTo: docentButton.bottomAnchor,
                                            constant: top).isActive = true
        nodegreeButton.leadingAnchor.constraint(equalTo: docentButton.leadingAnchor,
                                                constant: leading).isActive = true
        nodegreeButton.widthAnchor.constraint(equalTo: academicButton.widthAnchor,
                                              multiplier: 1).isActive = true
        nodegreeButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка кнопки перехода к следующему экрану
    private func setupNextButton() {
        let width = 90.f
        let height = 30.f
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        nextButton.update(isEnabled: true)
        scrollView.addSubview(nextButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: Session.width - 10).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: scrollView.topAnchor,
                                           constant: Session.height - Session.bottomPadding - 98).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: width).isActive = true
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
    
    /// Настройка выбора радиокнопки
    private func configureRadioButtons() {
        academicButton.alternateButton = [doctorButton, candidateButton, professorButton, docentButton, nodegreeButton]
        doctorButton.alternateButton = [academicButton, candidateButton, professorButton, docentButton, nodegreeButton]
        candidateButton.alternateButton = [academicButton, doctorButton, professorButton, docentButton, nodegreeButton]
        professorButton.alternateButton = [academicButton, doctorButton, candidateButton, docentButton, nodegreeButton]
        docentButton.alternateButton = [academicButton, doctorButton, candidateButton, professorButton, nodegreeButton]
        nodegreeButton.alternateButton = [academicButton, doctorButton, candidateButton, professorButton, docentButton]
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
    @objc private func regionSearchButtonPressed() {
        presenter?.regionSearch()
    }
    
    @objc private func citySearchButtonPressed() {
        presenter?.citySearch()
    }
    
    // MARK: - Navigation
    @objc private func nextButtonPressed() {
        guard let phone = phoneTextField.text else { return }
        presenter?.next(phone: phone)
    }
}
//swiftlint:disable force_unwrapping
extension CreateProfileScreen2ViewController: UITextFieldDelegate {
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
        
        if textField == phoneTextField {
            if (textField.text?.count)! == 1 {
                textField.text = "+\(textField.text!) ("
            } else if (textField.text?.count)! == 7 {
                textField.text = "\(textField.text!)) "
            } else if (textField.text?.count)! == 12 {
                textField.text = "\(textField.text!)-"
            } else if (textField.text?.count)! == 15 {
                textField.text = "\(textField.text!)-"
            } else if (textField.text?.count)! > 17 {
                return false
            }
        }
        
        return true
    }
}
