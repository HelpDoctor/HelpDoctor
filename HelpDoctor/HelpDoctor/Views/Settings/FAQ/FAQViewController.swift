//
//  FAQViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 23.02.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class FAQViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: FAQPresenterProtocol?
    
    // MARK: - Constants and variables
    private let headerHeight = 40.f
    private let topStackView = UIView()
    private let headerIcon = UIImageView()
    private let headerLabel = UILabel()
    private let faqView = UIView()
    private let faqIcon = UIImageView()
    private let faqLabel = UILabel()
    private let policyView = UIView()
    private let policyIcon = UIImageView()
    private let policyLabel = UILabel()
    private let licenseView = UIView()
    private let licenseIcon = UIImageView()
    private let licenseLabel = UILabel()
    private let rulesView = UIView()
    private let rulesIcon = UIImageView()
    private let rulesLabel = UILabel()
    private let versionLabel = UILabel()
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupHeaderView(color: .tabBarColor, height: headerHeight, presenter: presenter, title: "Настройки")
        setupTopStackView()
        setupHeaderIcon()
        setupHeaderLabel()
        setupFaqView()
        setupFaqIcon()
        setupFaqLabel()
        setupPolicyView()
        setupPolicyIcon()
        setupPolicyLabel()
        setupLicenseView()
        setupLicenseIcon()
        setupLicenseLabel()
        setupRulesView()
        setupRulesIcon()
        setupRulesLabel()
        setupVersionLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
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
        headerIcon.image = UIImage(named: "help")
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
        headerLabel.font = .mediumSystemFontOfSize(size: 14)
        headerLabel.textColor = .white
        headerLabel.text = "Помощь HelpDoctor"
        topStackView.addSubview(headerLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.leadingAnchor.constraint(equalTo: headerIcon.trailingAnchor,
                                             constant: leading).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor,
                                              constant: -leading).isActive = true
        headerLabel.centerYAnchor.constraint(equalTo: topStackView.centerYAnchor).isActive = true
        headerLabel.heightAnchor.constraint(equalTo: topStackView.heightAnchor).isActive = true
    }
    
    private func setupFaqView() {
        let height = 50.f
        faqView.addViewBackedBorder(side: .bottom,
                                    thickness: 1,
                                    color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.2))
        view.addSubview(faqView)
        faqView.translatesAutoresizingMaskIntoConstraints = false
        faqView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        faqView.topAnchor.constraint(equalTo: topStackView.bottomAnchor).isActive = true
        faqView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        faqView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupFaqIcon() {
        let width = 30.f
        let leading = 30.f
        faqIcon.image = UIImage(named: "help")
        faqView.addSubview(faqIcon)
        
        faqIcon.translatesAutoresizingMaskIntoConstraints = false
        faqIcon.leadingAnchor.constraint(equalTo: faqView.leadingAnchor,
                                         constant: leading).isActive = true
        faqIcon.widthAnchor.constraint(equalToConstant: width).isActive = true
        faqIcon.centerYAnchor.constraint(equalTo: faqView.centerYAnchor).isActive = true
        faqIcon.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupFaqLabel() {
        let leading = 25.f
        faqLabel.textAlignment = .left
        faqLabel.font = .mediumSystemFontOfSize(size: 14)
        faqLabel.textColor = .white
        faqLabel.text = "F.A.Q. HelpDoctor"
        faqLabel.numberOfLines = 0
        faqView.addSubview(faqLabel)
        
        faqLabel.translatesAutoresizingMaskIntoConstraints = false
        faqLabel.leadingAnchor.constraint(equalTo: faqIcon.trailingAnchor,
                                          constant: leading).isActive = true
        faqLabel.trailingAnchor.constraint(equalTo: faqView.trailingAnchor,
                                           constant: -leading).isActive = true
        faqLabel.centerYAnchor.constraint(equalTo: faqView.centerYAnchor).isActive = true
        faqLabel.heightAnchor.constraint(equalTo: faqView.heightAnchor).isActive = true
    }
    
    private func setupPolicyView() {
        let height = 50.f
        policyView.addViewBackedBorder(side: .bottom,
                                       thickness: 1,
                                       color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.2))
        view.addSubview(policyView)
        
        policyView.translatesAutoresizingMaskIntoConstraints = false
        policyView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        policyView.topAnchor.constraint(equalTo: faqView.bottomAnchor).isActive = true
        policyView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        policyView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupPolicyIcon() {
        let width = 30.f
        let leading = 30.f
        policyIcon.image = UIImage(named: "PolicyIcon")
        policyView.addSubview(policyIcon)
        
        policyIcon.translatesAutoresizingMaskIntoConstraints = false
        policyIcon.leadingAnchor.constraint(equalTo: policyView.leadingAnchor,
                                            constant: leading).isActive = true
        policyIcon.widthAnchor.constraint(equalToConstant: width).isActive = true
        policyIcon.centerYAnchor.constraint(equalTo: policyView.centerYAnchor).isActive = true
        policyIcon.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupPolicyLabel() {
        let leading = 25.f
        policyLabel.textAlignment = .left
        policyLabel.font = .mediumSystemFontOfSize(size: 14)
        policyLabel.textColor = .white
        policyLabel.text = "Политика обработки персональных данных"
        policyLabel.numberOfLines = 0
        policyView.addSubview(policyLabel)
        
        policyLabel.translatesAutoresizingMaskIntoConstraints = false
        policyLabel.leadingAnchor.constraint(equalTo: policyIcon.trailingAnchor,
                                             constant: leading).isActive = true
        policyLabel.trailingAnchor.constraint(equalTo: policyView.trailingAnchor,
                                              constant: -leading).isActive = true
        policyLabel.centerYAnchor.constraint(equalTo: policyView.centerYAnchor).isActive = true
        policyLabel.heightAnchor.constraint(equalTo: policyView.heightAnchor).isActive = true
    }
    
    private func setupLicenseView() {
        let height = 50.f
        licenseView.addViewBackedBorder(side: .bottom,
                                        thickness: 1,
                                        color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.2))
        view.addSubview(licenseView)
        
        licenseView.translatesAutoresizingMaskIntoConstraints = false
        licenseView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        licenseView.topAnchor.constraint(equalTo: policyView.bottomAnchor).isActive = true
        licenseView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        licenseView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupLicenseIcon() {
        let width = 30.f
        let leading = 30.f
        licenseIcon.image = UIImage(named: "LicenseIcon")
        licenseView.addSubview(licenseIcon)
        
        licenseIcon.translatesAutoresizingMaskIntoConstraints = false
        licenseIcon.leadingAnchor.constraint(equalTo: licenseView.leadingAnchor,
                                             constant: leading).isActive = true
        licenseIcon.widthAnchor.constraint(equalToConstant: width).isActive = true
        licenseIcon.centerYAnchor.constraint(equalTo: licenseView.centerYAnchor).isActive = true
        licenseIcon.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupLicenseLabel() {
        let leading = 25.f
        licenseLabel.textAlignment = .left
        licenseLabel.font = .mediumSystemFontOfSize(size: 14)
        licenseLabel.textColor = .white
        licenseLabel.text = "Лицензионный договор"
        licenseLabel.numberOfLines = 0
        licenseView.addSubview(licenseLabel)
        
        licenseLabel.translatesAutoresizingMaskIntoConstraints = false
        licenseLabel.leadingAnchor.constraint(equalTo: licenseIcon.trailingAnchor,
                                              constant: leading).isActive = true
        licenseLabel.trailingAnchor.constraint(equalTo: licenseView.trailingAnchor,
                                               constant: -leading).isActive = true
        licenseLabel.centerYAnchor.constraint(equalTo: licenseView.centerYAnchor).isActive = true
        licenseLabel.heightAnchor.constraint(equalTo: licenseView.heightAnchor).isActive = true
    }
    
    private func setupRulesView() {
        let height = 50.f
        rulesView.addViewBackedBorder(side: .bottom,
                                        thickness: 1,
                                        color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.2))
        view.addSubview(rulesView)
        
        rulesView.translatesAutoresizingMaskIntoConstraints = false
        rulesView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        rulesView.topAnchor.constraint(equalTo: licenseView.bottomAnchor).isActive = true
        rulesView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        rulesView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupRulesIcon() {
        let width = 30.f
        let leading = 30.f
        rulesIcon.image = UIImage(named: "RulesIcon")
        rulesView.addSubview(rulesIcon)
        
        rulesIcon.translatesAutoresizingMaskIntoConstraints = false
        rulesIcon.leadingAnchor.constraint(equalTo: rulesView.leadingAnchor,
                                             constant: leading).isActive = true
        rulesIcon.widthAnchor.constraint(equalToConstant: width).isActive = true
        rulesIcon.centerYAnchor.constraint(equalTo: rulesView.centerYAnchor).isActive = true
        rulesIcon.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupRulesLabel() {
        let leading = 25.f
        rulesLabel.textAlignment = .left
        rulesLabel.font = .mediumSystemFontOfSize(size: 14)
        rulesLabel.textColor = .white
        rulesLabel.text = "Правила использования мобильного приложения"
        rulesLabel.numberOfLines = 0
        rulesView.addSubview(rulesLabel)
        
        rulesLabel.translatesAutoresizingMaskIntoConstraints = false
        rulesLabel.leadingAnchor.constraint(equalTo: rulesIcon.trailingAnchor,
                                              constant: leading).isActive = true
        rulesLabel.trailingAnchor.constraint(equalTo: rulesView.trailingAnchor,
                                               constant: -leading).isActive = true
        rulesLabel.centerYAnchor.constraint(equalTo: rulesView.centerYAnchor).isActive = true
        rulesLabel.heightAnchor.constraint(equalTo: rulesView.heightAnchor).isActive = true
    }
    
    private func setupVersionLabel() {
        guard let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else { return }
        let height = 17.f
        let trailing = 8.f
        let bottom = 10 + (tabBarController?.tabBar.frame.height ?? 0)
        versionLabel.textAlignment = .right
        versionLabel.font = .systemFontOfSize(size: 14)
        versionLabel.textColor = .white
        versionLabel.text = "Версия приложения \(appVersion)"
        view.addSubview(versionLabel)
        
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        versionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                              constant: -trailing).isActive = true
        versionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                          constant: -bottom).isActive = true
        versionLabel.widthAnchor.constraint(equalToConstant: Session.width - (trailing * 2)).isActive = true
        versionLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    @objc private func sendButtonPressed() {
        print("In develop")
    }
    
}
