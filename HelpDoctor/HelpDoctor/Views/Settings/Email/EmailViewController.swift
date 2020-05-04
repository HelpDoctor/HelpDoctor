//
//  EmailViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 23.02.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: EmailPresenterProtocol?
    
    // MARK: - Constants and variables
    private let headerHeight = 40.f
    private let onThumbTintColor = UIColor(red: 0.149, green: 0.404, blue: 1, alpha: 1)
    private let offThumbTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    private let topStackView = UIView()
    private let headerIcon = UIImageView()
    private let headerLabel = UILabel()
    private let allowLabel = UILabel()
    private let emailSwitch = UISwitch()
    private let periodLabel = UILabel()
    private let dayButton = PeriodicButton(title: "Раз в день")
    private let threeDaysButton = PeriodicButton(title: "Раз в 3 дня")
    private let weekButton = PeriodicButton(title: "Раз в неделю")
    private let monthButton = PeriodicButton(title: "Раз в месяц")
    private let bottomStackView = UIView()
    private let bottomHeaderIcon = UIImageView()
    private let bottomHeaderLabel = UILabel()
    private let companyCheckbox = CheckBox(type: .square)
    private let patientsCheckbox = CheckBox(type: .square)
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupHeaderView(color: .tabBarColor,
                        height: headerHeight,
                        presenter: presenter,
                        title: "Настройки",
                        font: .boldSystemFontOfSize(size: 14))
        setupTopStackView()
        setupHeaderIcon()
        setupHeaderLabel()
        setupAllowLabel()
        setupEmailSwitch()
        setupPeriodLabel()
        setupDayButton()
        setupThreeDaysButton()
        setupWeekButton()
        setupMonthButton()
        setupBottomStackView()
        setupBottomHeaderIcon()
        setupBottomHeaderLabel()
        setupCompanyCheckbox()
        setupPatientsCheckbox()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
        presenter?.setSettingsOnView()
    }
    
    // MARK: - Public methods
    func setValueOnSwitch(_ value: Bool) {
        emailSwitch.isOn = value
        emailSwitch.thumbTintColor = emailSwitch.isOn ? onThumbTintColor : offThumbTintColor
    }
    
    func setValueOnCompanyCheckbox(_ value: Bool) {
        companyCheckbox.isSelected = value
    }
    
    func setValueOnPatientsCheckbox(_ value: Bool) {
        patientsCheckbox.isSelected = value
    }
    
    // MARK: - Setup views
    private func setupTopStackView() {
        let height = 40.f
        
        topStackView.backgroundColor = .searchBarTintColor
        view.addSubview(topStackView)
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                          constant: headerHeight).isActive = true
        topStackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topStackView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupHeaderIcon() {
        let width = 30.f
        let leading = 20.f
        headerIcon.image = UIImage(named: "emailSettings")
        topStackView.addSubview(headerIcon)
        
        headerIcon.translatesAutoresizingMaskIntoConstraints = false
        headerIcon.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor,
                                               constant: leading).isActive = true
        headerIcon.widthAnchor.constraint(equalToConstant: width).isActive = true
        headerIcon.centerYAnchor.constraint(equalTo: topStackView.centerYAnchor).isActive = true
        headerIcon.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupHeaderLabel() {
        let leading = 20.f
        
        headerLabel.numberOfLines = 1
        headerLabel.textAlignment = .left
        headerLabel.font = .boldSystemFontOfSize(size: 14)
        headerLabel.textColor = .white
        headerLabel.text = "Настройки почтовой рассылки"
        topStackView.addSubview(headerLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.leadingAnchor.constraint(equalTo: headerIcon.trailingAnchor,
                                               constant: leading).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor,
                                                constant: -leading).isActive = true
        headerLabel.centerYAnchor.constraint(equalTo: topStackView.centerYAnchor).isActive = true
        headerLabel.heightAnchor.constraint(equalTo: topStackView.heightAnchor).isActive = true
    }
    
    private func setupAllowLabel() {
        let leading = 20.f
        let top = 11.f
        let height = 19.f
        let width = 210.f
        
        allowLabel.numberOfLines = 1
        allowLabel.textAlignment = .left
        allowLabel.font = .mediumSystemFontOfSize(size: 14)
        allowLabel.textColor = .white
        allowLabel.text = "Разрешить рассылку на e-mail"
        view.addSubview(allowLabel)
        
        allowLabel.translatesAutoresizingMaskIntoConstraints = false
        allowLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                            constant: leading).isActive = true
        allowLabel.topAnchor.constraint(equalTo: topStackView.bottomAnchor,
                                        constant: top).isActive = true
        allowLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        allowLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupEmailSwitch() {
        let trailing = 25.f
        emailSwitch.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
        emailSwitch.setOn(false, animated: true)
        emailSwitch.thumbTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        emailSwitch.onTintColor = .white
        emailSwitch.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        view.addSubview(emailSwitch)
        
        emailSwitch.translatesAutoresizingMaskIntoConstraints = false
        emailSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                            constant: -trailing).isActive = true
        emailSwitch.centerYAnchor.constraint(equalTo: allowLabel.centerYAnchor).isActive = true
    }
    
    private func setupPeriodLabel() {
        let leading = 20.f
        let top = 11.f
        let height = 19.f
        let width = 210.f
        
        periodLabel.numberOfLines = 1
        periodLabel.textAlignment = .left
        periodLabel.font = .mediumSystemFontOfSize(size: 14)
        periodLabel.textColor = .white
        periodLabel.text = "Периодичность"
        view.addSubview(periodLabel)
        
        periodLabel.translatesAutoresizingMaskIntoConstraints = false
        periodLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                            constant: leading).isActive = true
        periodLabel.topAnchor.constraint(equalTo: emailSwitch.bottomAnchor,
                                        constant: top).isActive = true
        periodLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        periodLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupDayButton() {
        let top = 19.f
        let leading = 40.f
        let width = 90.f
        let height = 30.f
        dayButton.addTarget(self, action: #selector(dayButtonPressed), for: .touchUpInside)
        dayButton.update(isSelected: false)
        view.addSubview(dayButton)
        
        dayButton.translatesAutoresizingMaskIntoConstraints = false
        dayButton.topAnchor.constraint(equalTo: periodLabel.bottomAnchor,
                                       constant: top).isActive = true
        dayButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: leading).isActive = true
        dayButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        dayButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupThreeDaysButton() {
        let trailing = 40.f
        let width = 90.f
        let height = 30.f
        threeDaysButton.addTarget(self, action: #selector(threeDaysButtonPressed), for: .touchUpInside)
        threeDaysButton.update(isSelected: false)
        view.addSubview(threeDaysButton)
        
        threeDaysButton.translatesAutoresizingMaskIntoConstraints = false
        threeDaysButton.centerYAnchor.constraint(equalTo: dayButton.centerYAnchor).isActive = true
        threeDaysButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                  constant: -trailing).isActive = true
        threeDaysButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        threeDaysButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupWeekButton() {
        let top = 10.f
        let leading = 40.f
        let width = 90.f
        let height = 30.f
        weekButton.addTarget(self, action: #selector(weekButtonPressed), for: .touchUpInside)
        weekButton.update(isSelected: false)
        view.addSubview(weekButton)
        
        weekButton.translatesAutoresizingMaskIntoConstraints = false
        weekButton.topAnchor.constraint(equalTo: dayButton.bottomAnchor,
                                       constant: top).isActive = true
        weekButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: leading).isActive = true
        weekButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        weekButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupMonthButton() {
        let trailing = 40.f
        let width = 90.f
        let height = 30.f
        monthButton.addTarget(self, action: #selector(monthButtonPressed), for: .touchUpInside)
        monthButton.update(isSelected: false)
        view.addSubview(monthButton)
        
        monthButton.translatesAutoresizingMaskIntoConstraints = false
        monthButton.centerYAnchor.constraint(equalTo: weekButton.centerYAnchor).isActive = true
        monthButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                  constant: -trailing).isActive = true
        monthButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        monthButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupBottomStackView() {
        let height = 40.f
        let top = 20.f
        
        bottomStackView.backgroundColor = UIColor(red: 0.137, green: 0.455, blue: 0.671, alpha: 1)
        view.addSubview(bottomStackView)
        
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomStackView.topAnchor.constraint(equalTo: monthButton.bottomAnchor,
                                          constant: top).isActive = true
        bottomStackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        bottomStackView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupBottomHeaderIcon() {
        let width = 30.f
        let leading = 20.f
        bottomHeaderIcon.image = UIImage(named: "emailInvite")
        bottomStackView.addSubview(bottomHeaderIcon)
        
        bottomHeaderIcon.translatesAutoresizingMaskIntoConstraints = false
        bottomHeaderIcon.leadingAnchor.constraint(equalTo: bottomStackView.leadingAnchor,
                                               constant: leading).isActive = true
        bottomHeaderIcon.widthAnchor.constraint(equalToConstant: width).isActive = true
        bottomHeaderIcon.centerYAnchor.constraint(equalTo: bottomStackView.centerYAnchor).isActive = true
        bottomHeaderIcon.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupBottomHeaderLabel() {
        let leading = 20.f
        
        bottomHeaderLabel.numberOfLines = 1
        bottomHeaderLabel.textAlignment = .left
        bottomHeaderLabel.font = .boldSystemFontOfSize(size: 14)
        bottomHeaderLabel.textColor = .white
        bottomHeaderLabel.text = "Настройки приглашений"
        bottomStackView.addSubview(bottomHeaderLabel)
        
        bottomHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomHeaderLabel.leadingAnchor.constraint(equalTo: bottomHeaderIcon.trailingAnchor,
                                               constant: leading).isActive = true
        bottomHeaderLabel.trailingAnchor.constraint(equalTo: bottomStackView.trailingAnchor,
                                                constant: -leading).isActive = true
        bottomHeaderLabel.centerYAnchor.constraint(equalTo: bottomStackView.centerYAnchor).isActive = true
        bottomHeaderLabel.heightAnchor.constraint(equalTo: bottomStackView.heightAnchor).isActive = true
    }
    
    private func setupCompanyCheckbox() {
        let top = 23.f
        let leading = 23.f
        let height = 20.f
        companyCheckbox.contentHorizontalAlignment = .left
        companyCheckbox.contentVerticalAlignment = .center
        companyCheckbox.setTitle("Получать приглашения от компаний", for: .normal)
        companyCheckbox.titleLabel?.font = .systemFontOfSize(size: 14)
        companyCheckbox.setTitleColor(.white, for: .normal)
        companyCheckbox.addTarget(self, action: #selector(companyCheckboxPressed), for: .touchUpInside)
        view.addSubview(companyCheckbox)
        
        companyCheckbox.translatesAutoresizingMaskIntoConstraints = false
        companyCheckbox.topAnchor.constraint(equalTo: bottomStackView.bottomAnchor,
                                             constant: top).isActive = true
        companyCheckbox.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                 constant: leading).isActive = true
        companyCheckbox.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                  constant: -leading).isActive = true
        companyCheckbox.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupPatientsCheckbox() {
        let top = 23.f
        let leading = 23.f
        let height = 35.f
        patientsCheckbox.contentHorizontalAlignment = .left
        patientsCheckbox.contentVerticalAlignment = .center
        patientsCheckbox.setTitle(" Получать запросы от пациентов на проведение консультаций", for: .normal)
        patientsCheckbox.titleLabel?.lineBreakMode = .byWordWrapping
        patientsCheckbox.titleLabel?.font = .systemFontOfSize(size: 14)
        patientsCheckbox.setTitleColor(.white, for: .normal)
        patientsCheckbox.addTarget(self, action: #selector(patientsCheckboxPressed), for: .touchUpInside)
        view.addSubview(patientsCheckbox)
        
        patientsCheckbox.translatesAutoresizingMaskIntoConstraints = false
        patientsCheckbox.topAnchor.constraint(equalTo: companyCheckbox.bottomAnchor,
                                              constant: top).isActive = true
        patientsCheckbox.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: leading).isActive = true
        patientsCheckbox.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: -leading).isActive = true
        patientsCheckbox.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    @objc func switchStateDidChange(_ sender: UISwitch) {
        emailSwitch.thumbTintColor = sender.isOn ? onThumbTintColor : offThumbTintColor

        if sender == emailSwitch {
            presenter?.updateSettings("email_notification", sender.isOn ? 1 : 0)
        }
    }
    
    @objc func dayButtonPressed() {
        dayButton.update(isSelected: !dayButton.isSelected)
        threeDaysButton.update(isSelected: false)
        weekButton.update(isSelected: false)
        monthButton.update(isSelected: false)
        presenter?.updateSettings("periodicity", 1)
    }
    
    @objc func threeDaysButtonPressed() {
        dayButton.update(isSelected: false)
        threeDaysButton.update(isSelected: !threeDaysButton.isSelected)
        weekButton.update(isSelected: false)
        monthButton.update(isSelected: false)
        presenter?.updateSettings("periodicity", 3)
    }
    
    @objc func weekButtonPressed() {
        dayButton.update(isSelected: false)
        threeDaysButton.update(isSelected: false)
        weekButton.update(isSelected: !weekButton.isSelected)
        monthButton.update(isSelected: false)
        presenter?.updateSettings("periodicity", 7)
    }
    
    @objc func monthButtonPressed() {
        dayButton.update(isSelected: false)
        threeDaysButton.update(isSelected: false)
        weekButton.update(isSelected: false)
        monthButton.update(isSelected: !monthButton.isSelected)
        presenter?.updateSettings("periodicity", 30)
    }
    
    @objc private func companyCheckboxPressed() {
        companyCheckbox.isSelected = !companyCheckbox.isSelected
        presenter?.updateSettings("invite_pharmcompany", companyCheckbox.isSelected ? 1 : 0)
    }
    
    @objc private func patientsCheckboxPressed() {
        patientsCheckbox.isSelected = !patientsCheckbox.isSelected
        presenter?.updateSettings("consultation", patientsCheckbox.isSelected ? 1 : 0)
    }
    
}
