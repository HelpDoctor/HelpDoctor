//
//  FilterSearchViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 26.11.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class FilterSearchViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: FilterSearchPresenterProtocol?
    
    // MARK: - Constants
    static let identifier = "FilterSearchViewController"
    private let headerHeight = 40.f
    private let verticalInset = 20.f
    private var keyboardHeight: CGFloat = 0
    private let scrollView = UIScrollView()
    private let topView = UIView()
    private let titleLabel = UILabel()
    private let lineView = UIView()
    private let lastNameTextField = UITextField()
    private let firstNameTextField = UITextField()
    private let middleNameTextField = UITextField()
    private let ageLabel = UILabel()
    private let minAgeTextField = UITextField()
    private let dashLabel = UILabel()
    private let maxAgeTextField = UITextField()
    private let specTextField = UITextField()
    private let cityTextField = UITextField()
    private let jobTextField = UITextField()
    private let universityTextField = UITextField()
    private let clearButton = HDButton(title: "Очистить", fontSize: 18)
    private let findButton = HDButton(title: "Найти", fontSize: 18)
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupHeaderView(color: .tabBarColor,
                        height: headerHeight,
                        presenter: presenter,
                        title: "Поиск коллег",
                        font: .boldSystemFontOfSize(size: 14))
        setupScrollView()
        setupTopView()
        setupTitleLabel()
        setupLineView()
        setupLastNameTextField()
        setupFirstNameTextField()
        setupMiddleNameTextField()
        setupAgeLabel()
        setupMinAgeTextField()
        setupDashLabel()
        setupMaxAgeTextField()
        setupSpecNameTextField()
        setupCityNameTextField()
        setupJobNameTextField()
        setupUniversityNameTextField()
        setupClearButton()
        setupFindButton()
        addTapGestureToHideKeyboard()
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Public methods
    func setCity(city: String) {
        cityTextField.text = city
    }
    
    func setSpec(spec: String) {
        specTextField.text = spec
    }
    
    func setJob(job: String) {
        jobTextField.text = job
    }
    
    func setUniversity(university: String) {
        universityTextField.text = university
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
    
    private func setupTopView() {
        topView.backgroundColor = .white
        scrollView.addSubview(topView)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        topView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        topView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupTitleLabel() {
        titleLabel.font = .mediumSystemFontOfSize(size: 12)
        titleLabel.textColor = .black
        titleLabel.text = "Для более точного поиска заполните поля"
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        topView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor,
                                                     constant: verticalInset).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: Session.width - (verticalInset * 2)).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupLineView() {
        lineView.backgroundColor = .tabBarColor
        scrollView.addSubview(lineView)
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        lineView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    private func setupLastNameTextField() {
        lastNameTextField.font = .systemFontOfSize(size: 14)
        lastNameTextField.textColor = .textFieldTextColor
        lastNameTextField.autocapitalizationType = .none
        lastNameTextField.placeholder = "Фамилия"
        lastNameTextField.textAlignment = .left
        lastNameTextField.backgroundColor = .white
        lastNameTextField.layer.cornerRadius = 5
        lastNameTextField.autocorrectionType = .no
        lastNameTextField.leftView = setupDefaultLeftView()
        lastNameTextField.leftViewMode = .always
        scrollView.addSubview(lastNameTextField)
        
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.topAnchor.constraint(equalTo: lineView.bottomAnchor,
                                               constant: verticalInset / 2).isActive = true
        lastNameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                   constant: verticalInset).isActive = true
        lastNameTextField.widthAnchor.constraint(equalToConstant: Session.width - (2 * verticalInset)).isActive = true
        lastNameTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupFirstNameTextField() {
        firstNameTextField.font = .systemFontOfSize(size: 14)
        firstNameTextField.textColor = .textFieldTextColor
        firstNameTextField.autocapitalizationType = .none
        firstNameTextField.placeholder = "Имя"
        firstNameTextField.textAlignment = .left
        firstNameTextField.backgroundColor = .white
        firstNameTextField.layer.cornerRadius = 5
        firstNameTextField.autocorrectionType = .no
        firstNameTextField.leftView = setupDefaultLeftView()
        firstNameTextField.leftViewMode = .always
        scrollView.addSubview(firstNameTextField)
        
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor,
                                                constant: verticalInset).isActive = true
        firstNameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                    constant: verticalInset).isActive = true
        firstNameTextField.widthAnchor.constraint(equalToConstant: Session.width - (2 * verticalInset)).isActive = true
        firstNameTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupMiddleNameTextField() {
        middleNameTextField.font = .systemFontOfSize(size: 14)
        middleNameTextField.textColor = .textFieldTextColor
        middleNameTextField.autocapitalizationType = .none
        middleNameTextField.placeholder = "Отчество"
        middleNameTextField.textAlignment = .left
        middleNameTextField.backgroundColor = .white
        middleNameTextField.layer.cornerRadius = 5
        middleNameTextField.autocorrectionType = .no
        middleNameTextField.leftView = setupDefaultLeftView()
        middleNameTextField.leftViewMode = .always
        scrollView.addSubview(middleNameTextField)
        
        middleNameTextField.translatesAutoresizingMaskIntoConstraints = false
        middleNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor,
                                                 constant: verticalInset).isActive = true
        middleNameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                     constant: verticalInset).isActive = true
        middleNameTextField.widthAnchor.constraint(equalToConstant: Session.width - (2 * verticalInset)).isActive = true
        middleNameTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupAgeLabel() {
        ageLabel.font = .boldSystemFontOfSize(size: 14)
        ageLabel.textColor = .white
        ageLabel.text = "Возраст"
        ageLabel.textAlignment = .left
        ageLabel.numberOfLines = 1
        scrollView.addSubview(ageLabel)
        
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.topAnchor.constraint(equalTo: middleNameTextField.bottomAnchor,
                                      constant: verticalInset).isActive = true
        ageLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                          constant: verticalInset).isActive = true
        ageLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        ageLabel.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupMinAgeTextField() {
        minAgeTextField.font = .systemFontOfSize(size: 14)
        minAgeTextField.keyboardType = .numberPad
        minAgeTextField.textColor = .textFieldTextColor
        minAgeTextField.autocapitalizationType = .none
        minAgeTextField.textAlignment = .left
        minAgeTextField.backgroundColor = .white
        minAgeTextField.layer.cornerRadius = 5
        minAgeTextField.autocorrectionType = .no
        minAgeTextField.leftView = setupDefaultLeftView()
        minAgeTextField.leftViewMode = .always
        scrollView.addSubview(minAgeTextField)
        
        minAgeTextField.translatesAutoresizingMaskIntoConstraints = false
        minAgeTextField.topAnchor.constraint(equalTo: middleNameTextField.bottomAnchor,
                                             constant: verticalInset).isActive = true
        minAgeTextField.leadingAnchor.constraint(equalTo: ageLabel.trailingAnchor,
                                                 constant: verticalInset).isActive = true
        minAgeTextField.widthAnchor.constraint(equalToConstant: 30).isActive = true
        minAgeTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupDashLabel() {
        dashLabel.font = .boldSystemFontOfSize(size: 14)
        dashLabel.textColor = .white
        dashLabel.text = "---"
        dashLabel.textAlignment = .left
        dashLabel.numberOfLines = 1
        scrollView.addSubview(dashLabel)
        
        dashLabel.translatesAutoresizingMaskIntoConstraints = false
        dashLabel.topAnchor.constraint(equalTo: middleNameTextField.bottomAnchor,
                                       constant: verticalInset).isActive = true
        dashLabel.leadingAnchor.constraint(equalTo: minAgeTextField.trailingAnchor,
                                           constant: 12).isActive = true
        dashLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        dashLabel.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupMaxAgeTextField() {
        maxAgeTextField.font = .systemFontOfSize(size: 14)
        maxAgeTextField.keyboardType = .numberPad
        maxAgeTextField.textColor = .textFieldTextColor
        maxAgeTextField.autocapitalizationType = .none
        maxAgeTextField.textAlignment = .left
        maxAgeTextField.backgroundColor = .white
        maxAgeTextField.layer.cornerRadius = 5
        maxAgeTextField.autocorrectionType = .no
        maxAgeTextField.leftView = setupDefaultLeftView()
        maxAgeTextField.leftViewMode = .always
        scrollView.addSubview(maxAgeTextField)
        
        maxAgeTextField.translatesAutoresizingMaskIntoConstraints = false
        maxAgeTextField.topAnchor.constraint(equalTo: middleNameTextField.bottomAnchor,
                                             constant: verticalInset).isActive = true
        maxAgeTextField.leadingAnchor.constraint(equalTo: dashLabel.trailingAnchor,
                                                 constant: 12).isActive = true
        maxAgeTextField.widthAnchor.constraint(equalToConstant: 30).isActive = true
        maxAgeTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupSpecNameTextField() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(specSearchButtonPressed))
        specTextField.addGestureRecognizer(tap)
        specTextField.font = .systemFontOfSize(size: 14)
        specTextField.textColor = .textFieldTextColor
        specTextField.autocapitalizationType = .none
        specTextField.placeholder = "Специализация"
        specTextField.textAlignment = .left
        specTextField.backgroundColor = .white
        specTextField.layer.cornerRadius = 5
        specTextField.autocorrectionType = .no
        specTextField.leftView = setupDefaultLeftView()
        specTextField.leftViewMode = .always
        scrollView.addSubview(specTextField)
        
        specTextField.translatesAutoresizingMaskIntoConstraints = false
        specTextField.topAnchor.constraint(equalTo: ageLabel.bottomAnchor,
                                           constant: verticalInset).isActive = true
        specTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                               constant: verticalInset).isActive = true
        specTextField.widthAnchor.constraint(equalToConstant: Session.width - (2 * verticalInset)).isActive = true
        specTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupCityNameTextField() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(citySearchButtonPressed))
        cityTextField.addGestureRecognizer(tap)
        cityTextField.font = .systemFontOfSize(size: 14)
        cityTextField.textColor = .textFieldTextColor
        cityTextField.autocapitalizationType = .none
        cityTextField.placeholder = "Город"
        cityTextField.textAlignment = .left
        cityTextField.backgroundColor = .white
        cityTextField.layer.cornerRadius = 5
        cityTextField.autocorrectionType = .no
        cityTextField.leftView = setupDefaultLeftView()
        cityTextField.leftViewMode = .always
        scrollView.addSubview(cityTextField)
        
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        cityTextField.topAnchor.constraint(equalTo: specTextField.bottomAnchor,
                                           constant: verticalInset).isActive = true
        cityTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                               constant: verticalInset).isActive = true
        cityTextField.widthAnchor.constraint(equalToConstant: Session.width - (2 * verticalInset)).isActive = true
        cityTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupJobNameTextField() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(jobSearchButtonPressed))
        jobTextField.addGestureRecognizer(tap)
        jobTextField.font = .systemFontOfSize(size: 14)
        jobTextField.textColor = .textFieldTextColor
        jobTextField.autocapitalizationType = .none
        jobTextField.placeholder = "Место работы"
        jobTextField.textAlignment = .left
        jobTextField.backgroundColor = .white
        jobTextField.layer.cornerRadius = 5
        jobTextField.autocorrectionType = .no
        jobTextField.leftView = setupDefaultLeftView()
        jobTextField.leftViewMode = .always
        scrollView.addSubview(jobTextField)
        
        jobTextField.translatesAutoresizingMaskIntoConstraints = false
        jobTextField.topAnchor.constraint(equalTo: cityTextField.bottomAnchor,
                                           constant: verticalInset).isActive = true
        jobTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                               constant: verticalInset).isActive = true
        jobTextField.widthAnchor.constraint(equalToConstant: Session.width - (2 * verticalInset)).isActive = true
        jobTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupUniversityNameTextField() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(universitySearchButtonPressed))
        universityTextField.addGestureRecognizer(tap)
        universityTextField.font = .systemFontOfSize(size: 14)
        universityTextField.textColor = .textFieldTextColor
        universityTextField.autocapitalizationType = .none
        universityTextField.placeholder = "Учебное заведение"
        universityTextField.textAlignment = .left
        universityTextField.backgroundColor = .white
        universityTextField.layer.cornerRadius = 5
        universityTextField.autocorrectionType = .no
        universityTextField.leftView = setupDefaultLeftView()
        universityTextField.leftViewMode = .always
        scrollView.addSubview(universityTextField)
        
        universityTextField.translatesAutoresizingMaskIntoConstraints = false
        universityTextField.topAnchor.constraint(equalTo: jobTextField.bottomAnchor,
                                           constant: verticalInset).isActive = true
        universityTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                               constant: verticalInset).isActive = true
        universityTextField.widthAnchor.constraint(equalToConstant: Session.width - (2 * verticalInset)).isActive = true
        universityTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupClearButton() {
        clearButton.clearBackground()
        clearButton.addTarget(self, action: #selector(clearButtonPressed), for: .touchUpInside)
        scrollView.addSubview(clearButton)
        
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.topAnchor.constraint(equalTo: universityTextField.bottomAnchor,
                                          constant: verticalInset).isActive = true
        clearButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                              constant: verticalInset).isActive = true
        clearButton.widthAnchor.constraint(equalToConstant: (Session.width - (verticalInset * 3)) / 2).isActive = true
        clearButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func setupFindButton() {
        findButton.addTarget(self, action: #selector(findButtonPressed), for: .touchUpInside)
        scrollView.addSubview(findButton)
        
        findButton.translatesAutoresizingMaskIntoConstraints = false
        findButton.topAnchor.constraint(equalTo: universityTextField.bottomAnchor,
                                        constant: verticalInset).isActive = true
        findButton.leadingAnchor.constraint(equalTo: clearButton.trailingAnchor,
                                            constant: verticalInset).isActive = true
        findButton.widthAnchor.constraint(equalToConstant: (Session.width - (verticalInset * 3)) / 2).isActive = true
        findButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    // MARK: - Action methods
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
    
    @objc func hideKeyboard() {
        scrollView.endEditing(true)
        view.viewWithTag(Session.tagSavedView)?.removeFromSuperview()
        view.viewWithTag(Session.tagAlertView)?.removeFromSuperview()
    }
    
    /// Изменение размера ScrollView при появлении клавиатуры
    /// - Parameter notification: событие появления клавиатуры
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
    
    /// Изменение размера ScrollView при скрытии клавиатуры
    /// - Parameter notification: событие скрытия клавиатуры
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    // MARK: - Buttons methods
    @objc private func clearButtonPressed() {
        lastNameTextField.text = ""
        firstNameTextField.text = ""
        middleNameTextField.text = ""
        minAgeTextField.text = ""
        maxAgeTextField.text = ""
        specTextField.text = ""
        cityTextField.text = ""
        jobTextField.text = ""
        universityTextField.text = ""
    }
    
    @objc private func findButtonPressed() {
        var queryDescription = ""
        var ageTo: Int?
        var ageFrom: Int?
        
        if firstNameTextField.text != "" {
            queryDescription += firstNameTextField.text ?? ""
        }
        
        if middleNameTextField.text != "" {
            queryDescription += " \(middleNameTextField.text ?? "")"
        }
        
        if lastNameTextField.text != "" {
            queryDescription += " \(lastNameTextField.text ?? "");"
        }
        
        if minAgeTextField.text == "" && maxAgeTextField.text != "" {
            queryDescription += " возраст до \(maxAgeTextField.text ?? "");"
        } else if minAgeTextField.text != "" && maxAgeTextField.text == "" {
            queryDescription += " возраст от \(minAgeTextField.text ?? "");"
        } else if minAgeTextField.text != "" && maxAgeTextField.text != "" {
            queryDescription += " возраст \(minAgeTextField.text ?? "") - \(maxAgeTextField.text ?? "");"
        }
        
        if specTextField.text != "" {
            queryDescription += " \(specTextField.text ?? "");"
        }
        
        if cityTextField.text != "" {
            queryDescription += " \(cityTextField.text ?? "");"
        }
        
        if jobTextField.text != "" {
            queryDescription += " \(jobTextField.text ?? "");"
        }
        
        if universityTextField.text != "" {
            queryDescription += " \(universityTextField.text ?? "");"
        }
        
        if maxAgeTextField.text != nil {
            ageTo = Int(maxAgeTextField.text ?? "99")
        }
        
        if minAgeTextField.text != nil {
            ageFrom = Int(minAgeTextField.text ?? "0")
        }
        
        queryDescription = String(queryDescription.dropLast())
        
        let query = SearchQuery(firstName: firstNameTextField.text,
                                middleName: middleNameTextField.text,
                                lastName: lastNameTextField.text,
                                ageFrom: ageFrom,
                                ageTo: ageTo,
                                cityId: presenter?.getCityId(),
                                job: presenter?.getJobId(),
                                specialization: presenter?.getSpecId(),
                                education: presenter?.getUniversityId(),
                                yearEnding: nil,
                                interest: nil)
        presenter?.searchUsers(query, queryDescription)
    }
    
    @objc private func specSearchButtonPressed() {
        presenter?.specSearch()
    }
    
    @objc private func citySearchButtonPressed() {
        presenter?.citySearch()
    }
    
    @objc private func jobSearchButtonPressed() {
        presenter?.jobSearch()
    }
    
    @objc private func universitySearchButtonPressed() {
        presenter?.universitySearch()
    }
}
