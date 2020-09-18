//
//  CreateProfileStep6ViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.04.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class CreateProfileStep6ViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: CreateProfileStep6PresenterProtocol?
    
    // MARK: - Constants and variables
    private let backgroundColor = UIColor.backgroundColor
    private var verticalInset = 0.f
    private let headerHeight = 60.f
    private let textFieldWidth = Session.width - 40
    private let heightTitleLabel = 20.f
    private let heightLabel = 15.f
    private let heightRadioButton = 20.f
    private let heightNextButton = 40.f
    private let scrollView = UIScrollView()
    private let step6TitleLabel = UILabel()
    private let step6Label = UILabel()
    private let universityLabel = UILabel()
    private let universityTextField = UITextField()
    private let graduateDateLabel = UILabel()
    private let graduateDateTextField = PickerField()
    private let graduateTitleLabel = UILabel()
    private let graduateLabel = UILabel()
    private let academicButton = RadioButton()
    private let doctorButton = RadioButton()
    private let candidateButton = RadioButton()
    private let professorButton = RadioButton()
    private let docentButton = RadioButton()
    private let nodegreeButton = RadioButton()
    private let nextButton = HDButton(title: "Далее")
    private var keyboardHeight = 0.f
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        let contentHeight = headerHeight + heightTitleLabel + (heightLabel * 5)
            + (Session.heightTextField * 2) + (heightRadioButton * 3) + heightNextButton
        verticalInset = (Session.height - Session.statusBarHeight - contentHeight) / 12
        setupScrollView()
        setupStep6TitleLabel()
        setupStep6Label()
        setupUniversityLabel()
        setupUniversityTextField()
        setupGraduateDateLabel()
        setupGraduateDateTextField()
        setupGraduateTitleLabel()
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
        guard let isEdit = presenter?.isEdit else { return }
        if isEdit {
            setupHeaderView(height: headerHeight, presenter: presenter)
            nextButton.setTitle("Готово", for: .normal)
        } else {
            setupHeaderView(color: backgroundColor, height: headerHeight, presenter: presenter)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .clear)
        tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Public methods
    func setUniversity(university: String) {
        universityTextField.text = university
    }
    
    // MARK: - Private methods
    private func setUser() {
        guard let education = Session.instance.education,
              !education.isEmpty else { return }
        universityTextField.text = education[0].education?.educationName
        graduateDateTextField.text = "\(education[0].yearEnding ?? 0)"
        
        switch education[0].academicDegree {
        case .academic:
            academicButton.isSelected = true
        case .candidate:
            candidateButton.isSelected = true
        case .docent:
            docentButton.isSelected = true
        case .doctor:
            doctorButton.isSelected = true
        case .null:
            nodegreeButton.isSelected = true
        case .professor:
            professorButton.isSelected = true
        case .none:
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
    
    private func setupStep6TitleLabel() {
        step6TitleLabel.backgroundColor = .searchBarTintColor
        step6TitleLabel.font = .boldSystemFontOfSize(size: 14)
        step6TitleLabel.textColor = .white
        step6TitleLabel.text = "Шаг 6"
        step6TitleLabel.textAlignment = .center
        scrollView.addSubview(step6TitleLabel)
        
        step6TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step6TitleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        step6TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step6TitleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        step6TitleLabel.heightAnchor.constraint(equalToConstant: heightTitleLabel).isActive = true
    }
    
    /// Установка поясняющей надписи перед вводом телефона
    private func setupStep6Label() {
        step6Label.font = .boldSystemFontOfSize(size: 14)
        step6Label.textColor = .white
        step6Label.text = "Укажите информацию об образовании"
        step6Label.textAlignment = .left
        scrollView.addSubview(step6Label)
        
        step6Label.translatesAutoresizingMaskIntoConstraints = false
        step6Label.topAnchor.constraint(equalTo: step6TitleLabel.bottomAnchor,
                                        constant: verticalInset).isActive = true
        step6Label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step6Label.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        step6Label.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupUniversityLabel() {
        universityLabel.font = .systemFontOfSize(size: 14)
        universityLabel.textColor = .white
        universityLabel.text = "Учебное заведение, которое Вы окончили"
        universityLabel.textAlignment = .left
        scrollView.addSubview(universityLabel)
        
        universityLabel.translatesAutoresizingMaskIntoConstraints = false
        universityLabel.topAnchor.constraint(equalTo: step6Label.bottomAnchor,
                                             constant: verticalInset).isActive = true
        universityLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        universityLabel.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        universityLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupUniversityTextField() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(universitySearchButtonPressed))
        universityTextField.font = .systemFontOfSize(size: 14)
        universityTextField.textColor = .textFieldTextColor
        universityTextField.placeholder = "Учебное заведение*"
        universityTextField.textAlignment = .left
        universityTextField.backgroundColor = .white
        universityTextField.layer.cornerRadius = 5
        universityTextField.leftView = setupDefaultLeftView()
        universityTextField.leftViewMode = .always
        universityTextField.addGestureRecognizer(tap)
        scrollView.addSubview(universityTextField)
        
        universityTextField.translatesAutoresizingMaskIntoConstraints = false
        universityTextField.topAnchor.constraint(equalTo: universityLabel.bottomAnchor,
                                                 constant: verticalInset).isActive = true
        universityTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        universityTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        universityTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupGraduateDateLabel() {
        graduateDateLabel.font = .systemFontOfSize(size: 14)
        graduateDateLabel.textColor = .white
        graduateDateLabel.text = "Год выпуска"
        graduateDateLabel.textAlignment = .left
        scrollView.addSubview(graduateDateLabel)
        
        graduateDateLabel.translatesAutoresizingMaskIntoConstraints = false
        graduateDateLabel.topAnchor.constraint(equalTo: universityTextField.bottomAnchor,
                                               constant: verticalInset).isActive = true
        graduateDateLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        graduateDateLabel.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        graduateDateLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupGraduateDateTextField() {
        graduateDateTextField.titleLabel?.text = "Укажите год выпуска"
        graduateDateTextField.backgroundColor = .white
        graduateDateTextField.layer.cornerRadius = 5
        graduateDateTextField.font = .systemFontOfSize(size: 14)
        graduateDateTextField.textColor = .textFieldTextColor
        graduateDateTextField.type = .datePicker
        graduateDateTextField.placeholder = "____*"
        graduateDateTextField.pickerFieldDelegate = presenter
        graduateDateTextField.datePicker?.datePickerMode = .date
        graduateDateTextField.datePicker?.maximumDate = Date()
        graduateDateTextField.leftView = setupDefaultLeftView()
        graduateDateTextField.leftViewMode = .always
        scrollView.addSubview(graduateDateTextField)
        
        graduateDateTextField.translatesAutoresizingMaskIntoConstraints = false
        graduateDateTextField.topAnchor.constraint(equalTo: graduateDateLabel.bottomAnchor,
                                                   constant: verticalInset).isActive = true
        graduateDateTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        graduateDateTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        graduateDateTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupGraduateTitleLabel() {
        graduateTitleLabel.font = .boldSystemFontOfSize(size: 14)
        graduateTitleLabel.textColor = .white
        graduateTitleLabel.text = "Укажите, есть ли у вас ученая степень"
        graduateTitleLabel.textAlignment = .left
        scrollView.addSubview(graduateTitleLabel)
        
        graduateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        graduateTitleLabel.topAnchor.constraint(equalTo: graduateDateTextField.bottomAnchor,
                                                constant: verticalInset).isActive = true
        graduateTitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        graduateTitleLabel.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        graduateTitleLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupGraduateLabel() {
        graduateLabel.font = .systemFontOfSize(size: 14)
        graduateLabel.textColor = .white
        graduateLabel.text = "Ученая степень или звание"
        graduateLabel.textAlignment = .left
        scrollView.addSubview(graduateLabel)
        
        graduateLabel.translatesAutoresizingMaskIntoConstraints = false
        graduateLabel.topAnchor.constraint(equalTo: graduateTitleLabel.bottomAnchor,
                                           constant: verticalInset).isActive = true
        graduateLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        graduateLabel.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        graduateLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    /// Установка радиокнопки выбора академика наук
    private func setupAcademicButton() {
        let leading = 20.f
        let width = (Session.width / 2) - (leading * 2)
        academicButton.contentHorizontalAlignment = .left
        academicButton.setTitle(" Академик наук", for: .normal)
        academicButton.titleLabel?.font = .systemFontOfSize(size: 12)
        academicButton.setTitleColor(.white, for: .normal)
        academicButton.isSelected = false
        scrollView.addSubview(academicButton)
        
        academicButton.translatesAutoresizingMaskIntoConstraints = false
        academicButton.topAnchor.constraint(equalTo: graduateLabel.bottomAnchor,
                                            constant: verticalInset).isActive = true
        academicButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                constant: leading).isActive = true
        academicButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        academicButton.heightAnchor.constraint(equalToConstant: heightRadioButton).isActive = true
    }
    
    /// Установка радиокнопки выбора доктора наук
    private func setupDoctorButton() {
        let leading = 20.f
        doctorButton.contentHorizontalAlignment = .left
        doctorButton.setTitle(" Доктор наук", for: .normal)
        doctorButton.titleLabel?.font = .systemFontOfSize(size: 12)
        doctorButton.setTitleColor(.white, for: .normal)
        doctorButton.isSelected = false
        scrollView.addSubview(doctorButton)
        
        doctorButton.translatesAutoresizingMaskIntoConstraints = false
        doctorButton.topAnchor.constraint(equalTo: academicButton.bottomAnchor,
                                          constant: verticalInset).isActive = true
        doctorButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                              constant: leading).isActive = true
        doctorButton.widthAnchor.constraint(equalTo: academicButton.widthAnchor,
                                            multiplier: 1).isActive = true
        doctorButton.heightAnchor.constraint(equalToConstant: heightRadioButton).isActive = true
    }
    
    /// Установка радиокнопки выбора кандидата наук
    private func setupCandidateButton() {
        let leading = 20.f
        candidateButton.contentHorizontalAlignment = .left
        candidateButton.setTitle(" Кандидат наук", for: .normal)
        candidateButton.titleLabel?.font = .systemFontOfSize(size: 12)
        candidateButton.setTitleColor(.white, for: .normal)
        candidateButton.isSelected = false
        scrollView.addSubview(candidateButton)
        
        candidateButton.translatesAutoresizingMaskIntoConstraints = false
        candidateButton.topAnchor.constraint(equalTo: doctorButton.bottomAnchor,
                                             constant: verticalInset).isActive = true
        candidateButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                 constant: leading).isActive = true
        candidateButton.widthAnchor.constraint(equalTo: academicButton.widthAnchor,
                                               multiplier: 1).isActive = true
        candidateButton.heightAnchor.constraint(equalToConstant: heightRadioButton).isActive = true
    }
    
    /// Установка радиокнопки выбора профессора
    private func setupProfessorButton() {
        let leading = Session.width / 2 + 20
        professorButton.contentHorizontalAlignment = .left
        professorButton.setTitle(" Профессор", for: .normal)
        professorButton.titleLabel?.font = .systemFontOfSize(size: 12)
        professorButton.setTitleColor(.white, for: .normal)
        professorButton.isSelected = false
        scrollView.addSubview(professorButton)
        
        professorButton.translatesAutoresizingMaskIntoConstraints = false
        professorButton.topAnchor.constraint(equalTo: graduateLabel.bottomAnchor,
                                             constant: verticalInset).isActive = true
        professorButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                 constant: leading).isActive = true
        professorButton.widthAnchor.constraint(equalTo: academicButton.widthAnchor,
                                               multiplier: 1).isActive = true
        professorButton.heightAnchor.constraint(equalToConstant: heightRadioButton).isActive = true
    }
    
    /// Установка радиокнопки выбора доцента
    private func setupDocentButton() {
        let leading = Session.width / 2 + 20
        docentButton.contentHorizontalAlignment = .left
        docentButton.setTitle(" Доцент", for: .normal)
        docentButton.titleLabel?.font = .systemFontOfSize(size: 12)
        docentButton.setTitleColor(.white, for: .normal)
        docentButton.isSelected = false
        scrollView.addSubview(docentButton)
        
        docentButton.translatesAutoresizingMaskIntoConstraints = false
        docentButton.topAnchor.constraint(equalTo: professorButton.bottomAnchor,
                                          constant: verticalInset).isActive = true
        docentButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                              constant: leading).isActive = true
        docentButton.widthAnchor.constraint(equalTo: academicButton.widthAnchor,
                                            multiplier: 1).isActive = true
        docentButton.heightAnchor.constraint(equalToConstant: heightRadioButton).isActive = true
    }
    
    /// Установка радиокнопки выбора значения без степени
    private func setupNodegreeButton() {
        let leading = 0.f
        nodegreeButton.contentHorizontalAlignment = .left
        nodegreeButton.setTitle(" Нет степени", for: .normal)
        nodegreeButton.titleLabel?.font = .systemFontOfSize(size: 12)
        nodegreeButton.setTitleColor(.white, for: .normal)
        nodegreeButton.isSelected = false
        scrollView.addSubview(nodegreeButton)
        
        nodegreeButton.translatesAutoresizingMaskIntoConstraints = false
        nodegreeButton.topAnchor.constraint(equalTo: docentButton.bottomAnchor,
                                            constant: verticalInset).isActive = true
        nodegreeButton.leadingAnchor.constraint(equalTo: docentButton.leadingAnchor,
                                                constant: leading).isActive = true
        nodegreeButton.widthAnchor.constraint(equalTo: academicButton.widthAnchor,
                                              multiplier: 1).isActive = true
        nodegreeButton.heightAnchor.constraint(equalToConstant: heightRadioButton).isActive = true
    }
    
    /// Установка кнопки перехода к следующему экрану
    private func setupNextButton() {
        let width = 110.f
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        nextButton.update(isEnabled: true)
        scrollView.addSubview(nextButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: Session.width - 20).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: scrollView.topAnchor,
                                           constant: Session.height - Session.bottomPadding - 98).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: heightNextButton).isActive = true
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
        guard let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let kbSize = keyboardFrame.cgRectValue.size
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
    @objc private func universitySearchButtonPressed() {
        presenter?.universitySearch()
    }
    
    // MARK: - Navigation
    @objc private func nextButtonPressed() {
        presenter?.next()
    }
    
}
