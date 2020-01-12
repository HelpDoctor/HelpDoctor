//
//  OtherTimeNotifyViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 12.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class OtherTimeNotifyViewController: UIViewController {

    // MARK: - Dependency
    var presenter: OtherTimeNotifyPresenterProtocol?
    var delegate: OtherTimeControllerDelegate?
    
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
        setupHeaderViewWithAvatar(title: "Время напоминания",
                                  text: nil,
                                  userImage: nil,
                                  presenter: presenter)
        setupTitleLabel()
        setupNotifyPicker()
        setupSaveButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.statusBarBackgroundColor = .tabBarColor
    }
    
    // MARK: - Public methods
    func setStartTime(startTime: Date) {
        notifyPicker.maximumDate = startTime
    }
    
    // MARK: - Setup views
    private func setupTitleLabel() {
        titleLabel.font = .boldSystemFontOfSize(size: 18)
        titleLabel.textColor = .white
        titleLabel.text = "На какое время установить напоминание"
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
        view.addSubview(notifyPicker)
        
        notifyPicker.translatesAutoresizingMaskIntoConstraints = false
        notifyPicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        notifyPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        notifyPicker.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        notifyPicker.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    private func setupSaveButton() {
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        saveButton.setImage(UIImage(named: "SaveButton.pdf"), for: .normal)
        saveButton.backgroundColor = .hdButtonColor
        saveButton.layer.cornerRadius = 22
        view.addSubview(saveButton)
        
        let window = UIApplication.shared.keyWindow
        let bottomPadding = window?.safeAreaInsets.bottom
        let yAnchor = height - (bottomPadding ?? 0) - (tabBarController?.tabBar.frame.height ?? 0) - 75
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.bottomAnchor.constraint(equalTo: view.topAnchor,
                                           constant: yAnchor).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    // MARK: - IBActions
    // MARK: - Buttons methods
    @objc private func saveButtonPressed() {
        delegate?.callback(notifyDate: notifyPicker.date)
        presenter?.back()
    }

}
