//
//  StartAddEventViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class StartAddEventViewController: UIViewController {

    // MARK: - Dependency
    var presenter: StartAddEventPresenterProtocol?
    
    // MARK: - Constants
    private let topLabel = UILabel()
    private var appointmentButton = HDButton()
    private var administrativeButton = HDButton()
    private var scienceButton = HDButton()
    private var otherButton = HDButton()
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupHeaderViewWithAvatar(title: "Новое событие",
                                  text: nil,
                                  userImage: nil,
                                  presenter: presenter)
        setupTopLabel()
        setupAppointmentButton()
        setupAdministrativeButton()
        setupScienceButton()
        setupOtherButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.statusBarBackgroundColor = .tabBarColor
    }
    
    // MARK: - Setup views
    private func setupTopLabel() {
        topLabel.font = .systemFontOfSize(size: 14)
        topLabel.textColor = .white
        topLabel.attributedText = redStar(text: "Выберите к какому виду деятельности относится новое событие*")
        topLabel.textAlignment = .center
        topLabel.numberOfLines = 0
        view.addSubview(topLabel)
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    private func setupAppointmentButton() {
        appointmentButton = HDButton(title: "Прием пациентов", fontSize: 14)
        appointmentButton.addTarget(self, action: #selector(appointmentButtonPressed), for: .touchUpInside)
        appointmentButton.isEnabled = true
        view.addSubview(appointmentButton)

        appointmentButton.translatesAutoresizingMaskIntoConstraints = false
        appointmentButton.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 36).isActive = true
        appointmentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appointmentButton.widthAnchor.constraint(equalToConstant: 235).isActive = true
        appointmentButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func setupAdministrativeButton() {
        administrativeButton = HDButton(title: "Административная деятельность", fontSize: 14)
        administrativeButton.addTarget(self, action: #selector(administrativeButtonPressed), for: .touchUpInside)
        administrativeButton.isEnabled = true
        view.addSubview(administrativeButton)

        administrativeButton.translatesAutoresizingMaskIntoConstraints = false
        administrativeButton.topAnchor.constraint(equalTo: appointmentButton.bottomAnchor, constant: 10).isActive = true
        administrativeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        administrativeButton.widthAnchor.constraint(equalToConstant: 235).isActive = true
        administrativeButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func setupScienceButton() {
        scienceButton = HDButton(title: "Научная деятельность", fontSize: 14)
        scienceButton.addTarget(self, action: #selector(scienceButtonPressed), for: .touchUpInside)
        scienceButton.isEnabled = true
        view.addSubview(scienceButton)

        scienceButton.translatesAutoresizingMaskIntoConstraints = false
        scienceButton.topAnchor.constraint(equalTo: administrativeButton.bottomAnchor, constant: 10).isActive = true
        scienceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scienceButton.widthAnchor.constraint(equalToConstant: 235).isActive = true
        scienceButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func setupOtherButton() {
        otherButton = HDButton(title: "Научная деятельность", fontSize: 14)
        otherButton.addTarget(self, action: #selector(otherButtonPressed), for: .touchUpInside)
        otherButton.isEnabled = true
        view.addSubview(otherButton)

        otherButton.translatesAutoresizingMaskIntoConstraints = false
        otherButton.topAnchor.constraint(equalTo: scienceButton.bottomAnchor, constant: 10).isActive = true
        otherButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        otherButton.widthAnchor.constraint(equalToConstant: 235).isActive = true
        otherButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    // MARK: - Buttons methods
    @objc private func appointmentButtonPressed() {
        presenter?.appointmentButtonPressed()
    }
    
    @objc private func administrativeButtonPressed() {
        print("Tapped")
    }
    
    @objc private func scienceButtonPressed() {
        print("Tapped")
    }
    
    @objc private func otherButtonPressed() {
        print("Tapped")
    }

}
