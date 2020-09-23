//
//  StartSearchUserViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 23.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class StartSearchUserViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: StartSearchUserPresenterProtocol?
    
    // MARK: - Constants
    private let headerHeight = 40.f
    private var keyboardHeight = 0.f
    private var tabBarHeight = 0.f
    private let scrollView = UIScrollView()
    private let backgroundImage = UIImageView()
    private let backImage = UIImageView()
    private let label = UILabel()
    private let filterButton = UIButton()
    private let findTextField = UITextField()
    private let searchButton = HDButton(title: "Найти", fontSize: 18)
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        setupScrollView()
        setupFullBackground()
        setupHeaderView(color: .tabBarColor,
                        height: headerHeight,
                        presenter: presenter,
                        title: "Поиск коллег",
                        font: .boldSystemFontOfSize(size: 14))
        setupImage()
        setupLabel()
        setupFilterButton()
        setupFindTextField()
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
    
    private func setupImage() {
        let top = 27.f
        let width = Session.width - 70
        let imageName = "SearchUserArt"
        guard let image = UIImage(named: imageName) else {
            assertionFailure("Missing ​​\(imageName) asset")
            return
        }
        let resizedImage = image.resizeImage(width, opaque: false)
        backImage.image = resizedImage
        scrollView.addSubview(backImage)
        
        backImage.translatesAutoresizingMaskIntoConstraints = false
        backImage.topAnchor.constraint(equalTo: scrollView.topAnchor,
                                       constant: top).isActive = true
        backImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backImage.widthAnchor.constraint(equalToConstant: resizedImage.size.width).isActive = true
        backImage.heightAnchor.constraint(equalToConstant: resizedImage.size.height).isActive = true
    }
    
    private func setupLabel() {
        let top = 27.f
        label.font = .mediumSystemFontOfSize(size: 14)
        label.textColor = .white
        label.text = """
            Чтобы найти человека, заполните одно из полей и нажмите “Найти”
            """
        label.textAlignment = .left
        label.numberOfLines = 0
        scrollView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: backImage.bottomAnchor,
                                   constant: top).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                       constant: 20).isActive = true
        label.widthAnchor.constraint(equalToConstant: Session.width - 40).isActive = true
        label.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func setupFilterButton() {
        filterButton.backgroundColor = .hdButtonColor
        filterButton.layer.cornerRadius = 5
        filterButton.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
        filterButton.setImage(UIImage(named: "FilterIcon"), for: .normal)
        scrollView.addSubview(filterButton)
        
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        filterButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                               constant: -20).isActive = true
        filterButton.widthAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
        filterButton.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupFindTextField() {
        findTextField.font = .systemFontOfSize(size: 14)
        findTextField.textColor = .textFieldTextColor
        findTextField.placeholder = "Поиск"
        findTextField.textAlignment = .left
        findTextField.autocorrectionType = .no
        findTextField.backgroundColor = .white
        findTextField.layer.cornerRadius = 5
        findTextField.leftView = setupDefaultLeftView()
        findTextField.leftViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: 0,
                                                  y: 9,
                                                  width: 12,
                                                  height: 12))
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Search")?.withTintColor(.textFieldTextColor)
        let rightView = UIView(frame: CGRect(x: 0,
                                             y: 0,
                                             width: 21,
                                             height: Session.heightTextField))
        rightView.addSubview(imageView)
        findTextField.rightView = rightView
        findTextField.rightViewMode = .always
        scrollView.addSubview(findTextField)
        
        findTextField.translatesAutoresizingMaskIntoConstraints = false
        findTextField.topAnchor.constraint(equalTo: filterButton.topAnchor).isActive = true
        findTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        findTextField.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -10).isActive = true
        findTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupSearchButton() {
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        scrollView.addSubview(searchButton)
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.topAnchor.constraint(equalTo: findTextField.bottomAnchor, constant: 30).isActive = true
        searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 148).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    // MARK: - Buttons methods
    @objc private func filterButtonPressed() {
        presenter?.toFilter()
    }
    
    @objc private func searchButtonPressed() {
        presenter?.toResult()
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
