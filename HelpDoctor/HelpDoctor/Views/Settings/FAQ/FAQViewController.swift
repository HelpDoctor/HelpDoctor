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
    private let versionTitle = UILabel()
    private let versionLabel = UILabel()
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.494, green: 0.737, blue: 0.902, alpha: 1)
        setupHeaderViewWithAvatar(title: "Настройки",
                                  text: nil,
                                  userImage: nil,
                                  presenter: presenter)
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
        setupVersionTitle()
        setupVersionLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.statusBarBackgroundColor = .tabBarColor
    }
    
    // MARK: - Setup views
    private func setupTopStackView() {
        let height: CGFloat = 40
        
        topStackView.backgroundColor = UIColor(red: 0.137, green: 0.455, blue: 0.671, alpha: 1)
        view.addSubview(topStackView)
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                          constant: 50).isActive = true
        topStackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topStackView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupHeaderIcon() {
        let width: CGFloat = 30
        let leading: CGFloat = 20
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
        let leading: CGFloat = 20
        
        headerLabel.numberOfLines = 1
        headerLabel.textAlignment = .left
        headerLabel.font = .systemFontOfSize(size: 14)
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
        let height: CGFloat = 50
        faqView.addBorder(toSide: .bottom, withColor: UIColor.red.cgColor, andThickness: 2)
        view.addSubview(faqView)
        faqView.translatesAutoresizingMaskIntoConstraints = false
        faqView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        faqView.topAnchor.constraint(equalTo: topStackView.bottomAnchor).isActive = true
        faqView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        faqView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupFaqIcon() {
        let width: CGFloat = 30
        let leading: CGFloat = 30
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
        let leading: CGFloat = 25
        
        faqLabel.textAlignment = .left
        faqLabel.font = .systemFontOfSize(size: 14)
        faqLabel.textColor = .white
        faqLabel.text = "F.A.Q. HelpDoctor"
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
        let height: CGFloat = 50
        policyView.addBorder(toSide: .bottom, withColor: UIColor.red.cgColor, andThickness: 2)
        view.addSubview(policyView)
        
        policyView.translatesAutoresizingMaskIntoConstraints = false
        policyView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        policyView.topAnchor.constraint(equalTo: faqView.bottomAnchor).isActive = true
        policyView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        policyView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupPolicyIcon() {
        let width: CGFloat = 30
        let leading: CGFloat = 30
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
        let leading: CGFloat = 25
        
        policyLabel.textAlignment = .left
        policyLabel.font = .systemFontOfSize(size: 14)
        policyLabel.textColor = .white
        policyLabel.text = "Условия и политика конфиденциальности"
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
        let height: CGFloat = 50
        licenseView.addBorder(toSide: .bottom, withColor: UIColor.red.cgColor, andThickness: 2)
        view.addSubview(licenseView)
        
        licenseView.translatesAutoresizingMaskIntoConstraints = false
        licenseView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        licenseView.topAnchor.constraint(equalTo: policyView.bottomAnchor).isActive = true
        licenseView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        licenseView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupLicenseIcon() {
        let width: CGFloat = 30
        let leading: CGFloat = 30
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
        let leading: CGFloat = 25
        
        licenseLabel.textAlignment = .left
        licenseLabel.font = .systemFontOfSize(size: 14)
        licenseLabel.textColor = .white
        licenseLabel.text = "Лицензии"
        licenseView.addSubview(licenseLabel)
        
        licenseLabel.translatesAutoresizingMaskIntoConstraints = false
        licenseLabel.leadingAnchor.constraint(equalTo: licenseIcon.trailingAnchor,
                                             constant: leading).isActive = true
        licenseLabel.trailingAnchor.constraint(equalTo: licenseView.trailingAnchor,
                                              constant: -leading).isActive = true
        licenseLabel.centerYAnchor.constraint(equalTo: licenseView.centerYAnchor).isActive = true
        licenseLabel.heightAnchor.constraint(equalTo: licenseView.heightAnchor).isActive = true
    }
    
    private func setupVersionTitle() {
        let leading: CGFloat = 30
        let width: CGFloat = 130
        let height: CGFloat = 17
        let top: CGFloat = 20
        
        versionTitle.textAlignment = .left
        versionTitle.font = .systemFontOfSize(size: 14)
        versionTitle.textColor = .white
        versionTitle.text = "Версия программы"
        view.addSubview(versionTitle)
        
        versionTitle.translatesAutoresizingMaskIntoConstraints = false
        versionTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                             constant: leading).isActive = true
        versionTitle.topAnchor.constraint(equalTo: licenseView.bottomAnchor,
                                          constant: top).isActive = true
        versionTitle.widthAnchor.constraint(equalToConstant: width).isActive = true
        versionTitle.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupVersionLabel() {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let leading: CGFloat = 30
        let width: CGFloat = 130
        let height: CGFloat = 17
        let top: CGFloat = 20
        
        versionLabel.textAlignment = .left
        versionLabel.font = .systemFontOfSize(size: 14)
        versionLabel.textColor = .white
        versionLabel.text = appVersion
        view.addSubview(versionLabel)
        
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        versionLabel.leadingAnchor.constraint(equalTo: versionTitle.trailingAnchor,
                                             constant: leading).isActive = true
        versionLabel.topAnchor.constraint(equalTo: licenseView.bottomAnchor,
                                          constant: top).isActive = true
        versionLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        versionLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    @objc private func sendButtonPressed() {
        print("In develop")
    }
    
}

extension UIView {
    
    enum ViewSide {
        case left, right, top, bottom
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .left:
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height)
        case .top:
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness)
        case .bottom:
            border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness)
        }
        
        layer.addSublayer(border)
    }
}
