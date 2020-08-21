//
//  SelectDateViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 25.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class SelectDateViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: SelectDatePresenterProtocol?
    weak var delegate: SelectDateControllerDelegate?
    
    // MARK: - Constants and variables
    private let titleLabel = UILabel()
    private let notifyPicker = UIDatePicker()
    private let saveButton = UIButton()
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupHeaderViewWithAvatar(title: "Выбор даты",
                                  text: nil,
                                  userImage: nil,
                                  presenter: presenter)
        setupTitleLabel()
        setupNotifyPicker()
        setupSaveButton()
        addSwipeGestureToBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Public methods
    func setStartDate(startDate: Date) {
        notifyPicker.setDate(startDate, animated: true)
    }
    
    // MARK: - Setup views
    private func setupTitleLabel() {
        titleLabel.font = .boldSystemFontOfSize(size: 18)
        titleLabel.textColor = .white
        titleLabel.attributedText = redStar(text: "Выберите дату*")
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 68).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupNotifyPicker() {
        notifyPicker.backgroundColor = .white
        notifyPicker.setDate(Date(), animated: true)
        notifyPicker.datePickerMode = .date
        view.addSubview(notifyPicker)
        
        notifyPicker.translatesAutoresizingMaskIntoConstraints = false
        notifyPicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        notifyPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        notifyPicker.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        notifyPicker.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    private func setupSaveButton() {
        let yAnchor = height - Session.bottomPadding - (tabBarController?.tabBar.frame.height ?? 0) - 75
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        saveButton.setImage(UIImage(named: "SaveButton.pdf"), for: .normal)
        saveButton.backgroundColor = .hdButtonColor
        saveButton.layer.cornerRadius = 22
        view.addSubview(saveButton)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.bottomAnchor.constraint(equalTo: view.topAnchor,
                                           constant: yAnchor).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    /// Добавляет свайп влево для перехода назад
    private func addSwipeGestureToBack() {
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.addTarget(self, action: #selector(backButtonPressed))
        swipeLeft.direction = .right
        view.addGestureRecognizer(swipeLeft)
    }
    
    // MARK: - IBActions
    /// Переход на предыдущий экран
    @objc private func backButtonPressed() {
        presenter?.back()
    }
    
    // MARK: - Buttons methods
    @objc private func saveButtonPressed() {
        delegate?.callback(newDate: notifyPicker.date)
        presenter?.back()
    }
    
}

