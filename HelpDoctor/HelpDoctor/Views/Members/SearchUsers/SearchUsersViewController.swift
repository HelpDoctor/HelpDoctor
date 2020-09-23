//
//  SearchUsersViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 23.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class SearchUsersViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: SearchUsersPresenterProtocol?
    
    // MARK: - Constants
    private let headerHeight = 40.f
    private var verticalInset = 0.f
    private let heightTopView = 30.f
    private let heightSeparatorView = 10.f
    private let heightButton = 44.f
    private var tabBarHeight = 0.f
    private var keyboardHeight = 0.f
    private let widthButton = 130.f
    private let leading = 20.f
    private let scrollView = UIScrollView()
    private let topView = UIView()
    private let separatorView = UIView()
    private let label = UILabel()
    private let lastnameTextField = UITextField()
    private let nameTextField = UITextField()
    private let middlenameTextField = UITextField()
    private let specTextField = UITextField()
    private let locationTextField = UITextField()
    private let jobTextField = UITextField()
    private let educationTextField = UITextField()
    private let clearButton = HDButton(title: "Очистить", fontSize: 18)
    private let searchButton = HDButton(title: "Найти", fontSize: 18)
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        verticalInset = (Session.height - headerHeight - Session.statusBarHeight
                            - heightTopView - heightSeparatorView - tabBarHeight
                            - (7 * Session.heightTextField) - heightButton) / 9
        setupHeaderView(color: .tabBarColor,
                        height: headerHeight,
                        presenter: presenter,
                        title: "Поиск коллег",
                        font: .boldSystemFontOfSize(size: 14))
        setupScrollView()
        setupTopView()
        setupLabel()
        setupSeparatorView()
        setupLastnameTextField()
        setupNameTextField()
        setupMiddlenameTextField()
        setupSpecTextField()
        setupLocationTextField()
        setupJobTextField()
        setupEducationTextField()
        setupClearButton()
        setupSearchButton()
        addTapGestureToHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Public methods
    
    
    // MARK: - Setup views
    private func setupScrollView() {
        let height = Session.height - headerHeight - tabBarHeight
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: Session.width, height: height)
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
        topView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        topView.heightAnchor.constraint(equalToConstant: heightTopView).isActive = true
    }
    
    private func setupLabel() {
        label.font = .boldSystemFontOfSize(size: 12)
        label.textColor = .black
        label.text = "Для более точного поиска заполните поля"
        label.textAlignment = .center
        label.numberOfLines = 1
        topView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: topView.widthAnchor).isActive = true
        label.heightAnchor.constraint(equalTo: topView.heightAnchor).isActive = true
    }
    
    private func setupSeparatorView() {
        separatorView.backgroundColor = .searchBarTintColor
        scrollView.addSubview(separatorView)
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: heightSeparatorView).isActive = true
    }
    
    private func setupLastnameTextField() {
        lastnameTextField.font = .systemFontOfSize(size: 14)
        lastnameTextField.textColor = .textFieldTextColor
        lastnameTextField.placeholder = "Фамилия"
        lastnameTextField.textAlignment = .left
        lastnameTextField.autocorrectionType = .no
        lastnameTextField.backgroundColor = .white
        lastnameTextField.layer.cornerRadius = 5
        lastnameTextField.leftView = setupDefaultLeftView()
        lastnameTextField.leftViewMode = .always
        scrollView.addSubview(lastnameTextField)
        
        lastnameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastnameTextField.topAnchor.constraint(equalTo: separatorView.bottomAnchor,
                                               constant: verticalInset).isActive = true
        lastnameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                   constant: leading).isActive = true
        lastnameTextField.widthAnchor.constraint(equalToConstant: Session.width - (2 * leading)).isActive = true
        lastnameTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupNameTextField() {
        nameTextField.font = .systemFontOfSize(size: 14)
        nameTextField.textColor = .textFieldTextColor
        nameTextField.placeholder = "Имя"
        nameTextField.textAlignment = .left
        nameTextField.autocorrectionType = .no
        nameTextField.backgroundColor = .white
        nameTextField.layer.cornerRadius = 5
        nameTextField.leftView = setupDefaultLeftView()
        nameTextField.leftViewMode = .always
        scrollView.addSubview(nameTextField)
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: lastnameTextField.bottomAnchor,
                                           constant: verticalInset).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                               constant: leading).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: Session.width - (2 * leading)).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupMiddlenameTextField() {
        middlenameTextField.font = .systemFontOfSize(size: 14)
        middlenameTextField.textColor = .textFieldTextColor
        middlenameTextField.placeholder = "Отчество"
        middlenameTextField.textAlignment = .left
        middlenameTextField.autocorrectionType = .no
        middlenameTextField.backgroundColor = .white
        middlenameTextField.layer.cornerRadius = 5
        middlenameTextField.leftView = setupDefaultLeftView()
        middlenameTextField.leftViewMode = .always
        scrollView.addSubview(middlenameTextField)
        
        middlenameTextField.translatesAutoresizingMaskIntoConstraints = false
        middlenameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor,
                                                 constant: verticalInset).isActive = true
        middlenameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                     constant: leading).isActive = true
        middlenameTextField.widthAnchor.constraint(equalToConstant: Session.width - (2 * leading)).isActive = true
        middlenameTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupSpecTextField() {
        specTextField.font = .systemFontOfSize(size: 14)
        specTextField.textColor = .textFieldTextColor
        specTextField.placeholder = "Специализация"
        specTextField.textAlignment = .left
        specTextField.autocorrectionType = .no
        specTextField.backgroundColor = .white
        specTextField.layer.cornerRadius = 5
        specTextField.leftView = setupDefaultLeftView()
        specTextField.leftViewMode = .always
        scrollView.addSubview(specTextField)
        
        specTextField.translatesAutoresizingMaskIntoConstraints = false
        specTextField.topAnchor.constraint(equalTo: middlenameTextField.bottomAnchor,
                                           constant: verticalInset).isActive = true
        specTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                               constant: leading).isActive = true
        specTextField.widthAnchor.constraint(equalToConstant: Session.width - (2 * leading)).isActive = true
        specTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupLocationTextField() {
        locationTextField.font = .systemFontOfSize(size: 14)
        locationTextField.textColor = .textFieldTextColor
        locationTextField.placeholder = "Место жительства"
        locationTextField.textAlignment = .left
        locationTextField.autocorrectionType = .no
        locationTextField.backgroundColor = .white
        locationTextField.layer.cornerRadius = 5
        locationTextField.leftView = setupDefaultLeftView()
        locationTextField.leftViewMode = .always
        scrollView.addSubview(locationTextField)
        
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        locationTextField.topAnchor.constraint(equalTo: specTextField.bottomAnchor,
                                               constant: verticalInset).isActive = true
        locationTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                   constant: leading).isActive = true
        locationTextField.widthAnchor.constraint(equalToConstant: Session.width - (2 * leading)).isActive = true
        locationTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupJobTextField() {
        jobTextField.font = .systemFontOfSize(size: 14)
        jobTextField.textColor = .textFieldTextColor
        jobTextField.placeholder = "Место работы"
        jobTextField.textAlignment = .left
        jobTextField.autocorrectionType = .no
        jobTextField.backgroundColor = .white
        jobTextField.layer.cornerRadius = 5
        jobTextField.leftView = setupDefaultLeftView()
        jobTextField.leftViewMode = .always
        scrollView.addSubview(jobTextField)
        
        jobTextField.translatesAutoresizingMaskIntoConstraints = false
        jobTextField.topAnchor.constraint(equalTo: locationTextField.bottomAnchor,
                                          constant: verticalInset).isActive = true
        jobTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                              constant: leading).isActive = true
        jobTextField.widthAnchor.constraint(equalToConstant: Session.width - (2 * leading)).isActive = true
        jobTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupEducationTextField() {
        educationTextField.font = .systemFontOfSize(size: 14)
        educationTextField.textColor = .textFieldTextColor
        educationTextField.placeholder = "Учебное заведение"
        educationTextField.textAlignment = .left
        educationTextField.autocorrectionType = .no
        educationTextField.backgroundColor = .white
        educationTextField.layer.cornerRadius = 5
        educationTextField.leftView = setupDefaultLeftView()
        educationTextField.leftViewMode = .always
        scrollView.addSubview(educationTextField)
        
        educationTextField.translatesAutoresizingMaskIntoConstraints = false
        educationTextField.topAnchor.constraint(equalTo: jobTextField.bottomAnchor,
                                                constant: verticalInset).isActive = true
        educationTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                    constant: leading).isActive = true
        educationTextField.widthAnchor.constraint(equalToConstant: Session.width - (2 * leading)).isActive = true
        educationTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupClearButton() {
        clearButton.clearBackground()
        clearButton.addTarget(self, action: #selector(clearButtonPressed), for: .touchUpInside)
        scrollView.addSubview(clearButton)
        
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.topAnchor.constraint(equalTo: educationTextField.bottomAnchor,
                                         constant: verticalInset).isActive = true
        clearButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: leading).isActive = true
        clearButton.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        clearButton.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    private func setupSearchButton() {
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        scrollView.addSubview(searchButton)
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.topAnchor.constraint(equalTo: educationTextField.bottomAnchor,
                                          constant: verticalInset).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                               constant: Session.width - leading).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    // MARK: - Buttons methods
    @objc private func clearButtonPressed() {
        
    }
    
    @objc private func searchButtonPressed() {
        presenter?.findUsers()
    }
    
    // MARK: - IBActions
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
    
    /// Скрытие клавиатуры
    @objc func hideKeyboard() {
        scrollView.endEditing(true)
        view.viewWithTag(Session.tagSavedView)?.removeFromSuperview()
        view.viewWithTag(Session.tagAlertView)?.removeFromSuperview()
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
    
}
