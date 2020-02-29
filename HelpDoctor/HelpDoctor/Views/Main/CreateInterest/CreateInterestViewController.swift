//
//  CreateInterestViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//
/*
import UIKit

class CreateInterestViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: CreateInterestPresenterProtocol?
    
    // MARK: - Constants
    private let titleForm = UILabel()
    private let interestTextField = UITextField()
    private var okButton = HDButton()
    private var keyboardHeight: CGFloat = 0
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupHeaderView()
        setupTitleForm()
        setupInterestTextField()
        setupOkButton()
        addTapGestureToHideKeyboard()
        addSwipeGestureToBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.statusBarBackgroundColor = .clear
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Setup views
    /// Установка текста над полем ввода
    private func setupTitleForm() {
        titleForm.font = UIFont.systemFontOfSize(size: 14)
        titleForm.textColor = .white
        titleForm.text = "Введите область научных интересов и нажмите кнопку “Добавить”"
        titleForm.textAlignment = .center
        titleForm.numberOfLines = 2
        view.addSubview(titleForm)
        
        titleForm.translatesAutoresizingMaskIntoConstraints = false
        titleForm.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: 70).isActive = true
        titleForm.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleForm.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        titleForm.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    /// Установка поля ввода интереса
    private func setupInterestTextField() {
        interestTextField.font = UIFont.systemFontOfSize(size: 14)
        interestTextField.textColor = .textFieldTextColor
        interestTextField.backgroundColor = .white
        interestTextField.layer.cornerRadius = 5
        view.addSubview(interestTextField)
        
        interestTextField.translatesAutoresizingMaskIntoConstraints = false
        interestTextField.topAnchor.constraint(equalTo: titleForm.bottomAnchor, constant: 15).isActive = true
        interestTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        interestTextField.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        interestTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    /// Установка кнопки "Добавить"
    private func setupOkButton() {
        okButton = HDButton(title: "Добавить")
        okButton.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
        okButton.isEnabled = true
        view.addSubview(okButton)
        
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        okButton.topAnchor.constraint(equalTo: interestTextField.bottomAnchor, constant: 10).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        okButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
    }
    
    /// Установка распознавания касания экрана
    private func addTapGestureToHideKeyboard() {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self,
                                                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideKeyboardGesture)
        
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
    @objc func hideKeyboard() {
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
        keyboardHeight = kbSize.height
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        keyboardHeight = 0
    }
    
    @objc private func backButtonPressed() {
        presenter?.back()
    }
    
    // MARK: - Navigation
    @objc private func okButtonPressed() {
        presenter?.createInterest(interest: interestTextField.text)
    }
}
*/
