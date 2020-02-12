//
//  CreateProfileWorkViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 01.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class CreateProfileWorkViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: CreateProfileWorkPresenterProtocol?
    
    // MARK: - Constants
    private let scrollView = UIScrollView()
    private let step4TitleLabel = UILabel()
    private let step4Label = UILabel()
    private let regionTextField = RegionsSearchTextField()
    private let regionSearchButton = SearchButton()
    private let cityTextField = CitiesSearchTextField()
    private let citySearchButton = SearchButton()
    private let step5TitleLabel = UILabel()
    private let step5TopLabel = UILabel()
    private let workTextField = MedicalOrganizationSearchTextField()
    private let workSearchButton = SearchButton()
    private let addWorkTextField = MedicalOrganizationSearchTextField()
    private let addWorkSearchButton = SearchButton()
    private let workPlusButton = PlusButton()
    private let thirdWorkTextField = MedicalOrganizationSearchTextField()
    private let thirdWorkSearchButton = SearchButton()
    private let step5BottomLabel = UILabel()
    private let specTextField = MedicalSpecializationSearchTextField()
    private let specSearchButton = SearchButton()
    private let addSpecTextField = MedicalSpecializationSearchTextField()
    private let addSpecSearchButton = SearchButton()
    private let thirdSpecTextField = MedicalSpecializationSearchTextField()
    private let thirdSpecSearchButton = SearchButton()
    private let specPlusButton = PlusButton()
    private let backButton = UIButton()
    private let nextButton = UIButton()
    private var keyboardHeight: CGFloat = 0
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setupBackground()
        setupScrollView()
        setupHeaderView()
        setupStep4TitleLabel()
        setupStep4Label()
        setupRegionTextField()
        setupRegionSearchButton()
        setupCityTextField()
        setupCitySearchButton()
        setupStep5TitleLabel()
        setupStep5TopLabel()
        setupWorkTextField()
        setupWorkSearchButton()
        setupAddWorkTextField()
        setupAddWorkSearchButton()
        setupWorkPlusButton()
        setupStep5BottomLabel()
        setupSpecTextField()
        setupSpecSearchButton()
        setupAddSpecTextField()
        setupAddSpecSearchButton()
        setupSpecPlusButton()
        setupBackButton()
        setupNextButton()
        addTapGestureToHideKeyboard()
        addSwipeGestureToBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.statusBarBackgroundColor = .clear
        view.viewWithTag(998)?.removeFromSuperview()
        view.viewWithTag(999)?.removeFromSuperview()
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
    
    /// Заполнение основного места работы
    /// - Parameter job: место работы
    func setMainJob(job: String) {
        workTextField.text = job
    }
    
    /// Заполнение дополнительного места работы
    /// - Parameter job: место работы
    func setAddJob(job: String) {
        addWorkTextField.text = job
    }
    
    /// Заполнение третьего места работы
    /// - Parameter job: место работы
    func setThirdJob(job: String) {
        thirdWorkTextField.text = job
    }
    
    /// Заполнение основной специализации
    /// - Parameter spec: специализация
    func setMainSpec(spec: String) {
        specTextField.text = spec
    }
    
    /// Заполнение дополнительной специализации
    /// - Parameter spec: специализация
    func setAddSpec(spec: String) {
        addSpecTextField.text = spec
    }
    
    /// Заполнение третьей специализации
    /// - Parameter spec: специализация
    func setThirdSpec(spec: String) {
        thirdSpecTextField.text = spec
    }
    
    // MARK: - Setup views
    /// Установка UIScrollView для сдвига экрана при появлении клавиатуры
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
    
    /// Установка надписи
    private func setupStep4TitleLabel() {
        step4TitleLabel.font = UIFont.boldSystemFontOfSize(size: 18)
        step4TitleLabel.textColor = .white
        step4TitleLabel.text = "Шаг 4"
        step4TitleLabel.textAlignment = .center
        scrollView.addSubview(step4TitleLabel)
        
        step4TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step4TitleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
        step4TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step4TitleLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        step4TitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    /// Установка надписи указания места жительства
    private func setupStep4Label() {
        step4Label.font = UIFont.systemFontOfSize(size: 14)
        step4Label.textColor = .white
        step4Label.text = "Укажите свое место жительства"
        step4Label.textAlignment = .left
        step4Label.numberOfLines = 0
        scrollView.addSubview(step4Label)
        
        step4Label.translatesAutoresizingMaskIntoConstraints = false
        step4Label.topAnchor.constraint(equalTo: step4TitleLabel.bottomAnchor,
                                        constant: 3).isActive = true
        step4Label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step4Label.heightAnchor.constraint(equalToConstant: 51).isActive = true
    }
    
    /// Установка поля ввода региона места жительства
    private func setupRegionTextField() {
        regionTextField.presenter = presenter
        regionTextField.attributedPlaceholder = redStar(text: "Субъект*")
        scrollView.addSubview(regionTextField)
        
        regionTextField.translatesAutoresizingMaskIntoConstraints = false
        regionTextField.topAnchor.constraint(equalTo: step4Label.bottomAnchor, constant: 5).isActive = true
        regionTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        regionTextField.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        regionTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    /// Установка кнопки выбора из списка региона места жительства
    private func setupRegionSearchButton() {
        regionSearchButton.addTarget(self, action: #selector(regionSearchButtonPressed), for: .touchUpInside)
        view.addSubview(regionSearchButton)
        
        regionSearchButton.translatesAutoresizingMaskIntoConstraints = false
        regionSearchButton.topAnchor.constraint(equalTo: regionTextField.topAnchor,
                                                constant: 5).isActive = true
        regionSearchButton.trailingAnchor.constraint(equalTo: regionTextField.trailingAnchor,
                                                     constant: -5).isActive = true
        regionSearchButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        regionSearchButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    /// Установка поля ввода города места жительства
    private func setupCityTextField() {
        cityTextField.presenter = presenter
        cityTextField.font = UIFont.systemFontOfSize(size: 14)
        cityTextField.textColor = .textFieldTextColor
        cityTextField.layer.cornerRadius = 5
        cityTextField.attributedPlaceholder = redStar(text: "Город / район*")
        scrollView.addSubview(cityTextField)
        
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        cityTextField.topAnchor.constraint(equalTo: regionTextField.bottomAnchor, constant: 5).isActive = true
        cityTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        cityTextField.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        cityTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    /// Установка кнопки выбора из списка города места жительства
    private func setupCitySearchButton() {
        citySearchButton.addTarget(self, action: #selector(citySearchButtonPressed), for: .touchUpInside)
        view.addSubview(citySearchButton)
        
        citySearchButton.translatesAutoresizingMaskIntoConstraints = false
        citySearchButton.topAnchor.constraint(equalTo: cityTextField.topAnchor,
                                              constant: 5).isActive = true
        citySearchButton.trailingAnchor.constraint(equalTo: cityTextField.trailingAnchor,
                                                   constant: -5).isActive = true
        citySearchButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        citySearchButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    /// Установка надписи
    private func setupStep5TitleLabel() {
        step5TitleLabel.font = UIFont.boldSystemFontOfSize(size: 18)
        step5TitleLabel.textColor = .white
        step5TitleLabel.text = "Шаг 5"
        step5TitleLabel.textAlignment = .center
        scrollView.addSubview(step5TitleLabel)
        
        step5TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step5TitleLabel.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 12).isActive = true
        step5TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step5TitleLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        step5TitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    /// Установка надписи указания места работы
    private func setupStep5TopLabel() {
        step5TopLabel.font = UIFont.systemFontOfSize(size: 14)
        step5TopLabel.textColor = .white
        step5TopLabel.text = "Заполните данные о своей профессиональной деятельности"
        step5TopLabel.textAlignment = .left
        scrollView.addSubview(step5TopLabel)
        
        step5TopLabel.translatesAutoresizingMaskIntoConstraints = false
        step5TopLabel.topAnchor.constraint(equalTo: step5TitleLabel.bottomAnchor, constant: 1).isActive = true
        step5TopLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step5TopLabel.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        step5TopLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    /// Установка поля ввода основного места работы
    private func setupWorkTextField() {
        workTextField.presenter = presenter
        workTextField.mainWork = "main"
        workTextField.attributedPlaceholder = redStar(text: "Основное место работы*")
        workTextField.textColor = .textFieldTextColor
        workTextField.layer.cornerRadius = 5
        workTextField.font = UIFont.systemFontOfSize(size: 14)
        scrollView.addSubview(workTextField)
        
        workTextField.translatesAutoresizingMaskIntoConstraints = false
        workTextField.topAnchor.constraint(equalTo: step5TopLabel.bottomAnchor, constant: 5).isActive = true
        workTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        workTextField.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        workTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    /// Установка кнопки выбора из списка основного места работы
    private func setupWorkSearchButton() {
        workSearchButton.addTarget(self, action: #selector(workSearchButtonPressed), for: .touchUpInside)
        view.addSubview(workSearchButton)
        
        workSearchButton.translatesAutoresizingMaskIntoConstraints = false
        workSearchButton.topAnchor.constraint(equalTo: workTextField.topAnchor,
                                              constant: 5).isActive = true
        workSearchButton.trailingAnchor.constraint(equalTo: workTextField.trailingAnchor,
                                                   constant: -5).isActive = true
        workSearchButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        workSearchButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    /// Установка поля ввода дополнительного места работы
    private func setupAddWorkTextField() {
        addWorkTextField.presenter = presenter
        addWorkTextField.mainWork = "add"
        addWorkTextField.textColor = .textFieldTextColor
        addWorkTextField.layer.cornerRadius = 5
        addWorkTextField.font = UIFont.systemFontOfSize(size: 14)
        scrollView.addSubview(addWorkTextField)
        
        addWorkTextField.translatesAutoresizingMaskIntoConstraints = false
        addWorkTextField.topAnchor.constraint(equalTo: workTextField.bottomAnchor, constant: 5).isActive = true
        addWorkTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        addWorkTextField.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        addWorkTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    /// Установка кнопки выбора из списка дополнительного места работы
    private func setupAddWorkSearchButton() {
        addWorkSearchButton.addTarget(self, action: #selector(addWorkSearchButtonPressed), for: .touchUpInside)
        view.addSubview(addWorkSearchButton)
        
        addWorkSearchButton.translatesAutoresizingMaskIntoConstraints = false
        addWorkSearchButton.topAnchor.constraint(equalTo: addWorkTextField.topAnchor,
                                                 constant: 5).isActive = true
        addWorkSearchButton.trailingAnchor.constraint(equalTo: addWorkTextField.trailingAnchor,
                                                      constant: -5).isActive = true
        addWorkSearchButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        addWorkSearchButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    /// Установка поля ввода третьего места работы
    private func setupThirdWorkTextField() {
        thirdWorkTextField.presenter = presenter
        thirdWorkTextField.mainWork = "third"
        thirdWorkTextField.textColor = .textFieldTextColor
        thirdWorkTextField.layer.cornerRadius = 5
        thirdWorkTextField.font = UIFont.systemFontOfSize(size: 14)
        scrollView.addSubview(thirdWorkTextField)
        
        thirdWorkTextField.translatesAutoresizingMaskIntoConstraints = false
        thirdWorkTextField.topAnchor.constraint(equalTo: addWorkTextField.bottomAnchor, constant: 5).isActive = true
        thirdWorkTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        thirdWorkTextField.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        thirdWorkTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    /// Установка кнопки выбора из списка третьего места работы
    private func setupThirdWorkSearchButton() {
        thirdWorkSearchButton.addTarget(self, action: #selector(thirdWorkSearchButtonPressed), for: .touchUpInside)
        view.addSubview(thirdWorkSearchButton)
        
        thirdWorkSearchButton.translatesAutoresizingMaskIntoConstraints = false
        thirdWorkSearchButton.topAnchor.constraint(equalTo: thirdWorkTextField.topAnchor,
                                                   constant: 5).isActive = true
        thirdWorkSearchButton.trailingAnchor.constraint(equalTo: thirdWorkTextField.trailingAnchor,
                                                        constant: -5).isActive = true
        thirdWorkSearchButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        thirdWorkSearchButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    /// Установка кнопки добавления места работы
    private func setupWorkPlusButton() {
        workPlusButton.addTarget(self, action: #selector(workPlusButtonPressed), for: .touchUpInside)
        view.addSubview(workPlusButton)
        
        workPlusButton.translatesAutoresizingMaskIntoConstraints = false
        workPlusButton.topAnchor.constraint(equalTo: addWorkTextField.bottomAnchor,
                                            constant: 5).isActive = true
        workPlusButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                constant: 30).isActive = true
        workPlusButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        workPlusButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    /// Установка надписи указания медицинской специализации
    private func setupStep5BottomLabel() {
        step5BottomLabel.font = UIFont.systemFontOfSize(size: 14)
        step5BottomLabel.textColor = .white
        step5BottomLabel.text = "Укажите медицинскую специализацию"
        step5BottomLabel.textAlignment = .left
        scrollView.addSubview(step5BottomLabel)
        
        step5BottomLabel.translatesAutoresizingMaskIntoConstraints = false
        step5BottomLabel.topAnchor.constraint(equalTo: addWorkTextField.bottomAnchor, constant: 40).isActive = true
        step5BottomLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step5BottomLabel.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        step5BottomLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    /// Установка поля ввода основной медицинской специализации
    private func setupSpecTextField() {
        specTextField.presenter = presenter
        specTextField.mainSpec = true
        specTextField.font = UIFont.systemFontOfSize(size: 14)
        specTextField.textColor = .textFieldTextColor
        specTextField.layer.cornerRadius = 5
        specTextField.attributedPlaceholder = redStar(text: "Осн. специализация*")
        scrollView.addSubview(specTextField)
        
        specTextField.translatesAutoresizingMaskIntoConstraints = false
        specTextField.topAnchor.constraint(equalTo: step5BottomLabel.bottomAnchor, constant: 5).isActive = true
        specTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        specTextField.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        specTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    /// Установка кнопки выбора из списка основной медицинской специализации
    private func setupSpecSearchButton() {
        specSearchButton.addTarget(self, action: #selector(specSearchButtonPressed), for: .touchUpInside)
        view.addSubview(specSearchButton)
        
        specSearchButton.translatesAutoresizingMaskIntoConstraints = false
        specSearchButton.topAnchor.constraint(equalTo: specTextField.topAnchor,
                                              constant: 5).isActive = true
        specSearchButton.trailingAnchor.constraint(equalTo: specTextField.trailingAnchor,
                                                   constant: -5).isActive = true
        specSearchButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        specSearchButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    /// Установка поля ввода дополнительной медицинской специализации
    private func setupAddSpecTextField() {
        addSpecTextField.presenter = presenter
        addSpecTextField.mainSpec = false
        addSpecTextField.font = UIFont.systemFontOfSize(size: 14)
        addSpecTextField.textColor = .textFieldTextColor
        addSpecTextField.layer.cornerRadius = 5
        scrollView.addSubview(addSpecTextField)
        
        addSpecTextField.translatesAutoresizingMaskIntoConstraints = false
        addSpecTextField.topAnchor.constraint(equalTo: specTextField.bottomAnchor, constant: 5).isActive = true
        addSpecTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        addSpecTextField.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        addSpecTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    /// Установка кнопки выбора из списка дополнительной медицинской специализации
    private func setupAddSpecSearchButton() {
        addSpecSearchButton.addTarget(self, action: #selector(addSpecSearchButtonPressed), for: .touchUpInside)
        view.addSubview(addSpecSearchButton)
        
        addSpecSearchButton.translatesAutoresizingMaskIntoConstraints = false
        addSpecSearchButton.topAnchor.constraint(equalTo: addSpecTextField.topAnchor,
                                                 constant: 5).isActive = true
        addSpecSearchButton.trailingAnchor.constraint(equalTo: addSpecTextField.trailingAnchor,
                                                      constant: -5).isActive = true
        addSpecSearchButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        addSpecSearchButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    /// Установка поля ввода третьей медицинской специализации
    private func setupThirdSpecTextField() {
        thirdSpecTextField.presenter = presenter
        thirdSpecTextField.mainSpec = false
        thirdSpecTextField.font = UIFont.systemFontOfSize(size: 14)
        thirdSpecTextField.textColor = .textFieldTextColor
        thirdSpecTextField.layer.cornerRadius = 5
        scrollView.addSubview(thirdSpecTextField)
        
        thirdSpecTextField.translatesAutoresizingMaskIntoConstraints = false
        thirdSpecTextField.topAnchor.constraint(equalTo: addSpecTextField.bottomAnchor,
                                                constant: 5).isActive = true
        thirdSpecTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        thirdSpecTextField.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        thirdSpecTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    /// Установка кнопки выбора из списка третьей медицинской специализации
    private func setupThirdSpecSearchButton() {
        thirdSpecSearchButton.addTarget(self, action: #selector(thirdSpecSearchButtonPressed), for: .touchUpInside)
        view.addSubview(thirdSpecSearchButton)
        
        thirdSpecSearchButton.translatesAutoresizingMaskIntoConstraints = false
        thirdSpecSearchButton.topAnchor.constraint(equalTo: thirdSpecTextField.topAnchor,
                                                   constant: 5).isActive = true
        thirdSpecSearchButton.trailingAnchor.constraint(equalTo: thirdSpecTextField.trailingAnchor,
                                                        constant: -5).isActive = true
        thirdSpecSearchButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        thirdSpecSearchButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    /// Установка кнопки добавления медицинской специализации
    private func setupSpecPlusButton() {
        specPlusButton.addTarget(self, action: #selector(specPlusButtonPressed), for: .touchUpInside)
        view.addSubview(specPlusButton)
        
        specPlusButton.translatesAutoresizingMaskIntoConstraints = false
        specPlusButton.topAnchor.constraint(equalTo: addSpecTextField.bottomAnchor,
                                            constant: 5).isActive = true
        specPlusButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                constant: 30).isActive = true
        specPlusButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        specPlusButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    /// Установки кнопки перехода к предыдущему экрану
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
                                           constant: height - (bottomPadding ?? 0) - 98).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    /// Установка кнопки перехода к следующему экрану
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
                                           constant: height - (bottomPadding ?? 0) - 98).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
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
    
    /// Добавляет свайп влево для перехода назад
    private func addSwipeGestureToBack() {
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.addTarget(self, action: #selector(backButtonPressed))
        swipeLeft.direction = .right
        view.addGestureRecognizer(swipeLeft)
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
    
    @objc private func workSearchButtonPressed() {
        presenter?.medicalOrganizationSearch(mainWork: true, tag: "main")
    }
    
    @objc private func addWorkSearchButtonPressed() {
        presenter?.medicalOrganizationSearch(mainWork: false, tag: "add")
    }
    
    @objc private func thirdWorkSearchButtonPressed() {
        presenter?.medicalOrganizationSearch(mainWork: false, tag: "third")
    }
    
    @objc private func specSearchButtonPressed() {
        presenter?.medicalSpecializationSearch(mainSpec: true, tag: "main")
    }
    
    @objc private func addSpecSearchButtonPressed() {
        presenter?.medicalSpecializationSearch(mainSpec: false, tag: "add")
    }
    
    @objc private func thirdSpecSearchButtonPressed() {
        presenter?.medicalSpecializationSearch(mainSpec: false, tag: "third")
    }
    
    @objc private func workPlusButtonPressed() {
        workPlusButton.isHidden = true
        setupThirdWorkTextField()
        setupThirdWorkSearchButton()
    }
    
    @objc private func specPlusButtonPressed() {
        specPlusButton.isHidden = true
        setupThirdSpecTextField()
        setupThirdSpecSearchButton()
    }
    // MARK: - Navigation
    @objc private func nextButtonPressed() {
        presenter?.next()
    }
    
    @objc private func backButtonPressed() {
        presenter?.back()
    }
}
