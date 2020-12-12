//
//  StartSearchViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 25.11.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class StartSearchViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: StartSearchPresenterProtocol?
    
    // MARK: - Constants
    private let headerHeight = 40.f
    private let heightTopView = 70.f
    private let scrollView = UIScrollView()
    private let backgroundImage = UIImageView()
    private let imageView = UIImageView()
    private let label = UILabel()
    private let textField = UITextField()
    private let filterButton = UIButton()
    private var findButton = HDButton(title: "Найти", fontSize: 18)
    private var keyboardHeight: CGFloat = 0
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFullBackground()
        setupHeaderView(color: .tabBarColor,
                        height: headerHeight,
                        presenter: presenter,
                        title: "Поиск коллег",
                        font: .boldSystemFontOfSize(size: 14))
        setupScrollView()
        setupImageView()
        setupLabel()
        setupTextField()
        setupFilterButton()
        setupFindButton()
        addTapGestureToHideKeyboard()
        addSwipeGestureToBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Public methods
    
    // MARK: - Setup views
    /// Установка ScrollView
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
    
    func setupFullBackground() {
        view.backgroundColor = .white
        let backgroundImageName = "BackgroundFull"
        guard let image = UIImage(named: backgroundImageName) else {
            assertionFailure("Missing ​​\(backgroundImageName) asset")
            return
        }
        backgroundImage.image = image
        backgroundImage.frame = CGRect(x: 0,
                                       y: headerHeight + Session.statusBarHeight,
                                       width: Session.width,
                                       height: Session.height - headerHeight - Session.statusBarHeight)
        scrollView.addSubview(backgroundImage)
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        backgroundImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        backgroundImage.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        backgroundImage.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
    }
    
    /// Установка картинки
    private func setupImageView() {
        let width = Session.width - 35
        let imageName = "SearchImage.pdf"
        guard let image = UIImage(named: imageName) else {
            assertionFailure("Missing ​​\(imageName) asset")
            return
        }
        let resizedImage = image.resizeImage(width, opaque: false)
        imageView.image = resizedImage
        scrollView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 27).isActive = true
        imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: resizedImage.size.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: resizedImage.size.height).isActive = true
    }
    
    /// Установка заголовка
    private func setupLabel() {
        let top = 15.f
        let height = 40.f
        label.font = .mediumSystemFontOfSize(size: 14)
        label.numberOfLines = 0
        label.textColor = .white
        label.text = "Чтобы найти человека, укажите его Фамилию и Имя и нажмите “Найти”"
        label.textAlignment = .left
        scrollView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor,
                                        constant: top).isActive = true
        label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: Session.width - 40).isActive = true
        label.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupTextField() {
        let top = 10.f
        let width = Session.width - 80.f
        textField.font = .systemFontOfSize(size: 14)
        textField.keyboardType = .emailAddress
        textField.textColor = .textFieldTextColor
        textField.autocapitalizationType = .none
        textField.placeholder = "Поиск "
        textField.textAlignment = .left
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.autocorrectionType = .no
        textField.leftView = setupDefaultLeftView()
        textField.leftViewMode = .always
        scrollView.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: label.bottomAnchor,
                                       constant: top).isActive = true
        textField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        textField.widthAnchor.constraint(equalToConstant: width).isActive = true
        textField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupFilterButton() {
        let width = 30.f
        let height = 30.f
        filterButton.backgroundColor = .hdButtonColor
        filterButton.layer.cornerRadius = 5
        filterButton.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
        filterButton.setImage(UIImage(named: "FilterIcon"), for: .normal)
        scrollView.addSubview(filterButton)
        
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        filterButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
        filterButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 10).isActive = true
        filterButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        filterButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupFindButton() {
        let top = 30.f
        let width = 148.f
        let height = 44.f
        findButton.layer.cornerRadius = height / 2
        findButton.addTarget(self, action: #selector(findButtonPressed), for: .touchUpInside)
        findButton.update(isEnabled: true)
        scrollView.addSubview(findButton)
        
        findButton.translatesAutoresizingMaskIntoConstraints = false
        findButton.topAnchor.constraint(equalTo: textField.bottomAnchor,
                                            constant: top).isActive = true
        findButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        findButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        findButton.heightAnchor.constraint(equalToConstant: height).isActive = true
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
    
    @objc private func backButtonPressed() {
        presenter?.back()
    }
    
    // MARK: - Buttons methods
    @objc private func filterButtonPressed() {
        presenter?.toFilter()
    }
    
    @objc private func findButtonPressed() {
        presenter?.searchUsers(textField.text ?? "")
    }
}
