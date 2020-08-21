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
    private let verticalInset = 30.f
    private let heightButton = 44.f
    private let widthButton = 248.f
    private let topLabel = UILabel()
    private let appointmentButton = HDButton(title: "Прием пациентов", fontSize: 14)
    private let administrativeButton = HDButton(title: "Административная деятельность", fontSize: 14)
    private let scienceButton = HDButton(title: "Научная деятельность", fontSize: 14)
    private let otherButton = HDButton(title: "Другое", fontSize: 14)
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
//        setupHeaderViewWithAvatar(title: "Новое событие",
//                                  text: nil,
//                                  userImage: nil,
//                                  presenter: presenter)
        setupTopLabel()
        setupAppointmentButton()
        setupAdministrativeButton()
        setupScienceButton()
        setupOtherButton()
        addSwipeGestureToBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Setup views
    private func setupTopLabel() {
        topLabel.backgroundColor = .searchBarTintColor
        topLabel.font = .mediumSystemFontOfSize(size: 14)
        topLabel.textColor = .white
        topLabel.text = "Тип события"
        topLabel.textAlignment = .center
        topLabel.numberOfLines = 1
        view.addSubview(topLabel)
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: verticalInset).isActive = true
    }
    private func setupAppointmentButton() {
        appointmentButton.addTarget(self, action: #selector(appointmentButtonPressed), for: .touchUpInside)
        appointmentButton.isEnabled = true
        appointmentButton.backgroundColor = .receptionEventColor
        view.addSubview(appointmentButton)
        
        appointmentButton.translatesAutoresizingMaskIntoConstraints = false
        appointmentButton.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                               constant: verticalInset).isActive = true
        appointmentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appointmentButton.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        appointmentButton.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    private func setupAdministrativeButton() {
        administrativeButton.addTarget(self, action: #selector(administrativeButtonPressed), for: .touchUpInside)
        administrativeButton.isEnabled = true
        administrativeButton.backgroundColor = .administrativeEventColor
        view.addSubview(administrativeButton)
        
        administrativeButton.translatesAutoresizingMaskIntoConstraints = false
        administrativeButton.topAnchor.constraint(equalTo: appointmentButton.bottomAnchor,
                                                  constant: verticalInset).isActive = true
        administrativeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        administrativeButton.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        administrativeButton.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    private func setupScienceButton() {
        scienceButton.addTarget(self, action: #selector(scienceButtonPressed), for: .touchUpInside)
        scienceButton.isEnabled = true
        scienceButton.backgroundColor = .scientificEventColor
        view.addSubview(scienceButton)
        
        scienceButton.translatesAutoresizingMaskIntoConstraints = false
        scienceButton.topAnchor.constraint(equalTo: administrativeButton.bottomAnchor,
                                           constant: verticalInset).isActive = true
        scienceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scienceButton.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        scienceButton.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    private func setupOtherButton() {
        otherButton.addTarget(self, action: #selector(otherButtonPressed), for: .touchUpInside)
        otherButton.isEnabled = true
        otherButton.backgroundColor = .anotherEventColor
        view.addSubview(otherButton)
        
        otherButton.translatesAutoresizingMaskIntoConstraints = false
        otherButton.topAnchor.constraint(equalTo: scienceButton.bottomAnchor,
                                         constant: verticalInset).isActive = true
        otherButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        otherButton.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        otherButton.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    
    /// Добавляет свайп влево для перехода назад
    private func addSwipeGestureToBack() {
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.addTarget(self, action: #selector(backButtonPressed))
        swipeLeft.direction = .right
        view.addGestureRecognizer(swipeLeft)
    }
    
    // MARK: - Buttons methods
    @objc private func appointmentButtonPressed() {
        presenter?.appointmentButtonPressed()
    }
    
    @objc private func administrativeButtonPressed() {
        presenter?.administrativeButtonPressed()
    }
    
    @objc private func scienceButtonPressed() {
        presenter?.scienceButtonPressed()
    }
    
    @objc private func otherButtonPressed() {
        presenter?.otherButtonPressed()
    }
    
    /// Переход на предыдущий экран
    @objc private func backButtonPressed() {
        presenter?.back()
    }
    
}
