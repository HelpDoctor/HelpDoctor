//
//  SelectNotifyViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 04.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class SelectNotifyViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: SelectNotifyPresenterProtocol?
    
    // MARK: - Constants
    private let heightTopLabel = 30.f
    private let verticalInset = 52.f
    private let heightButton = 40.f
    private let widthButton = 155.f
    private let topLabel = UILabel()
    private let tenButton = HDButton(title: "10 минут", fontSize: 14)
    private let thirtyButton = HDButton(title: "30 минут", fontSize: 14)
    private let oneHourButton = HDButton(title: "1 час", fontSize: 14)
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        setupTopLabel()
        setupTenButton()
        setupThirtyButton()
        setupOneHourButton()
    }
    
    // MARK: - Setup views
    private func setupTopLabel() {
        topLabel.backgroundColor = .searchBarTintColor
        topLabel.font = .mediumSystemFontOfSize(size: 14)
        topLabel.textColor = .white
        topLabel.text = "Уведомить за"
        topLabel.textAlignment = .center
        topLabel.numberOfLines = 1
        view.addSubview(topLabel)
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: heightTopLabel).isActive = true
    }
    
    private func setupTenButton() {
        tenButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        tenButton.isEnabled = true
        view.addSubview(tenButton)
        
        tenButton.translatesAutoresizingMaskIntoConstraints = false
        tenButton.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                               constant: verticalInset).isActive = true
        tenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tenButton.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        tenButton.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    private func setupThirtyButton() {
        thirtyButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        thirtyButton.isEnabled = true
        view.addSubview(thirtyButton)
        
        thirtyButton.translatesAutoresizingMaskIntoConstraints = false
        thirtyButton.topAnchor.constraint(equalTo: tenButton.bottomAnchor,
                                                  constant: verticalInset).isActive = true
        thirtyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        thirtyButton.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        thirtyButton.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    private func setupOneHourButton() {
        oneHourButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        oneHourButton.isEnabled = true
        view.addSubview(oneHourButton)
        
        oneHourButton.translatesAutoresizingMaskIntoConstraints = false
        oneHourButton.topAnchor.constraint(equalTo: thirtyButton.bottomAnchor,
                                           constant: verticalInset).isActive = true
        oneHourButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        oneHourButton.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        oneHourButton.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    // MARK: - Buttons methods
    @objc func buttonTapped(_ sender: UIButton) {
        switch sender {
        case tenButton:
            presenter?.buttonPressed(10)
        case thirtyButton:
            presenter?.buttonPressed(30)
        case oneHourButton:
            presenter?.buttonPressed(60)
        default:
            presenter?.buttonPressed(0)
        }
    }
    
}
