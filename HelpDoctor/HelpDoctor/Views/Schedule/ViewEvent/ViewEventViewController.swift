//
//  ViewEventViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 11.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class ViewEventViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: ViewEventPresenterProtocol?
    
    // MARK: - Constants and variables
    private let titleLabel = UILabel()
    private let startLabel = UILabel()
    private let startDateLabel = UILabel()
    private let finishLabel = UILabel()
    private let finishDateLabel = UILabel()
    private let patientNameLabel = UILabel()
    private let titleBlueView = UIView()
    private let patientLabel = UILabel()
    private let descriptionTopLabel = UILabel()
    private let descBlueView = UIView()
    private let descriptionBottomLabel = UILabel()
    private let appointmentLabel = UILabel()
    private let bellIcon = UIImageView()
    private let timerLabel = UILabel()
    private let locationIcon = UIImageView()
    private let locationLabel = UILabel()
    private let saveButton = UIButton()
    private let deleteButton = UIButton()
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getEvent()
        setupBackground()
        setupHeaderViewWithAvatar(title: "Просмотр события",
                                  text: nil,
                                  userImage: nil,
                                  presenter: presenter)
        setupTitleLabel()
        setupStartLabel()
        setupStartDateLabel()
        setupFinishLabel()
        setupFinishDateLabel()
        setupPatientNameLabel()
        setupTitleBlueView()
        setupPatientLabel()
        setupDescriptionTopLabel()
        setupDescBlueView()
        setupDescriptionBottomLabel()
        setupAppointmentLabel()
        setupBellIcon()
        setupTimerLabel()
        setupLocationIcon()
        setupLocationLabel()
        setupSaveButton()
        setupDeleteButton()
        addSwipeGestureToBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Public methods
    func setEventOnView(event: ScheduleEvents) {
        let eventType = event.event_type
        switch eventType {
        case "reception":
            titleLabel.text = "Приём пациентов"
            patientNameLabel.text = "ФИО пациента"
        case "administrative":
            titleLabel.text = "Административная деятельность"
            patientNameLabel.text = "Название события"
        case "scientific":
            titleLabel.text = "Научная деятельность"
            patientNameLabel.text = "Название события"
        case "another":
            titleLabel.text = "Другое"
            patientNameLabel.text = "Название события"
        default:
            self.showAlert(message: "Не верный тип события")
        }
        startDateLabel.text = presenter?.convertDate(date: event.start_date) ?? event.start_date
        finishDateLabel.text = presenter?.convertDate(date: event.end_date) ?? event.end_date
        patientLabel.text = event.title
        descriptionBottomLabel.text = event.description
        appointmentLabel.text = "Первичный прием" //Нет в информации приходящей с сервера
        locationLabel.text = event.event_place
        guard let notifyDate = event.notify_date else { return }
        guard let startDate = presenter?.convertStringToDate(date: event.start_date),
            let notify = presenter?.convertStringToDate(date: notifyDate) else { return }
        guard let dateDiff = Calendar.current.dateComponents([.minute],
                                                             from: notify,
                                                             to: startDate).minute else { return }
        timerLabel.text = "Уведомить за \(dateDiff) минут"
    }
    
    // MARK: - Setup views
    private func setupTitleLabel() {
        titleLabel.font = .boldSystemFontOfSize(size: 18)
        titleLabel.textColor = .white
        titleLabel.text = "Прием пациентов"
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 68).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupStartLabel() {
        startLabel.font = .boldSystemFontOfSize(size: 12)
        startLabel.textColor = .white
        startLabel.attributedText = redStar(text: "Начало события")
        startLabel.textAlignment = .center
        startLabel.numberOfLines = 1
        view.addSubview(startLabel)
        
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        startLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1).isActive = true
        startLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        startLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
    }
    private func setupStartDateLabel() {
        startDateLabel.font = .systemFontOfSize(size: 12)
        startDateLabel.textColor = .white
        startDateLabel.textAlignment = .center
        startDateLabel.numberOfLines = 1
        view.addSubview(startDateLabel)
        
        startDateLabel.translatesAutoresizingMaskIntoConstraints = false
        startDateLabel.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: 1).isActive = true
        startDateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startDateLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        startDateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupFinishLabel() {
        finishLabel.font = .boldSystemFontOfSize(size: 12)
        finishLabel.textColor = .white
        finishLabel.attributedText = redStar(text: "Конец события")
        finishLabel.textAlignment = .center
        finishLabel.numberOfLines = 1
        view.addSubview(finishLabel)
        
        finishLabel.translatesAutoresizingMaskIntoConstraints = false
        finishLabel.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor, constant: 1).isActive = true
        finishLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        finishLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        finishLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
    }
    
    private func setupFinishDateLabel() {
        finishDateLabel.font = .systemFontOfSize(size: 12)
        finishDateLabel.textColor = .white
        finishDateLabel.textAlignment = .center
        finishDateLabel.numberOfLines = 1
        view.addSubview(finishDateLabel)
        
        finishDateLabel.translatesAutoresizingMaskIntoConstraints = false
        finishDateLabel.topAnchor.constraint(equalTo: finishLabel.bottomAnchor, constant: 1).isActive = true
        finishDateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        finishDateLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        finishDateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupPatientNameLabel() {
        patientNameLabel.font = .boldSystemFontOfSize(size: 12)
        patientNameLabel.textColor = .white
        patientNameLabel.textAlignment = .left
        patientNameLabel.numberOfLines = 1
        view.addSubview(patientNameLabel)
        
        patientNameLabel.translatesAutoresizingMaskIntoConstraints = false
        patientNameLabel.topAnchor.constraint(equalTo: finishDateLabel.bottomAnchor, constant: 20).isActive = true
        patientNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        patientNameLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        patientNameLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    private func setupTitleBlueView() {
        titleBlueView.backgroundColor = .hdButtonColor
        view.addSubview(titleBlueView)
        
        titleBlueView.translatesAutoresizingMaskIntoConstraints = false
        titleBlueView.topAnchor.constraint(equalTo: patientNameLabel.bottomAnchor, constant: 1).isActive = true
        titleBlueView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleBlueView.widthAnchor.constraint(equalToConstant: 3).isActive = true
        titleBlueView.heightAnchor.constraint(equalToConstant: 23).isActive = true
    }
    
    private func setupPatientLabel() {
        patientLabel.font = .systemFontOfSize(size: 14)
        patientLabel.textColor = .white
        patientLabel.textAlignment = .left
        patientLabel.backgroundColor = .backgroundLabelColor
        view.addSubview(patientLabel)
        
        patientLabel.translatesAutoresizingMaskIntoConstraints = false
        patientLabel.topAnchor.constraint(equalTo: patientNameLabel.bottomAnchor, constant: 1).isActive = true
        patientLabel.leadingAnchor.constraint(equalTo: titleBlueView.trailingAnchor).isActive = true
        patientLabel.widthAnchor.constraint(equalToConstant: width - 43).isActive = true
        patientLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
    }
    
    private func setupDescriptionTopLabel() {
        descriptionTopLabel.font = .boldSystemFontOfSize(size: 12)
        descriptionTopLabel.textColor = .white
        descriptionTopLabel.attributedText = redStar(text: "Описание")
        descriptionTopLabel.textAlignment = .left
        descriptionTopLabel.numberOfLines = 1
        view.addSubview(descriptionTopLabel)
        
        descriptionTopLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTopLabel.topAnchor.constraint(equalTo: patientLabel.bottomAnchor,
                                                 constant: 8).isActive = true
        descriptionTopLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionTopLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        descriptionTopLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    private func setupDescBlueView() {
        descBlueView.backgroundColor = .hdButtonColor
        view.addSubview(descBlueView)
        
        descBlueView.translatesAutoresizingMaskIntoConstraints = false
        descBlueView.topAnchor.constraint(equalTo: descriptionTopLabel.bottomAnchor, constant: 1).isActive = true
        descBlueView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        descBlueView.widthAnchor.constraint(equalToConstant: 3).isActive = true
        descBlueView.heightAnchor.constraint(equalToConstant: 23).isActive = true
    }
    
    private func setupDescriptionBottomLabel() {
        descriptionBottomLabel.font = .systemFontOfSize(size: 14)
        descriptionBottomLabel.textColor = .white
        descriptionBottomLabel.textAlignment = .left
        descriptionBottomLabel.backgroundColor = .backgroundLabelColor
        view.addSubview(descriptionBottomLabel)
        
        descriptionBottomLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionBottomLabel.topAnchor.constraint(equalTo: descriptionTopLabel.bottomAnchor,
                                                    constant: 1).isActive = true
        descriptionBottomLabel.leadingAnchor.constraint(equalTo: descBlueView.trailingAnchor).isActive = true
        descriptionBottomLabel.widthAnchor.constraint(equalToConstant: width - 43).isActive = true
        descriptionBottomLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
    }
    
    private func setupAppointmentLabel() {
        appointmentLabel.font = .boldSystemFontOfSize(size: 12)
        appointmentLabel.textColor = .white
        appointmentLabel.textAlignment = .left
        appointmentLabel.numberOfLines = 1
        view.addSubview(appointmentLabel)
        
        appointmentLabel.translatesAutoresizingMaskIntoConstraints = false
        appointmentLabel.topAnchor.constraint(equalTo: descriptionBottomLabel.bottomAnchor,
                                              constant: 13).isActive = true
        appointmentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appointmentLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        appointmentLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    /// Установка иконки колокольчика
    private func setupBellIcon() {
        bellIcon.image = UIImage(named: "BellIcon.pdf")
        view.addSubview(bellIcon)
        
        bellIcon.translatesAutoresizingMaskIntoConstraints = false
        bellIcon.topAnchor.constraint(equalTo: appointmentLabel.bottomAnchor, constant: 12).isActive = true
        bellIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                          constant: 20).isActive = true
        bellIcon.widthAnchor.constraint(equalToConstant: 14).isActive = true
        bellIcon.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    private func setupTimerLabel() {
        timerLabel.font = .boldSystemFontOfSize(size: 12)
        timerLabel.textColor = .white
        timerLabel.textAlignment = .left
        timerLabel.numberOfLines = 1
        view.addSubview(timerLabel)
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.topAnchor.constraint(equalTo: appointmentLabel.bottomAnchor,
                                        constant: 12).isActive = true
        timerLabel.leadingAnchor.constraint(equalTo: bellIcon.trailingAnchor, constant: 2).isActive = true
        timerLabel.widthAnchor.constraint(equalToConstant: width - 56).isActive = true
        timerLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    /// Установка иконки местоположения
    private func setupLocationIcon() {
        locationIcon.image = UIImage(named: "LocationIcon.pdf")
        view.addSubview(locationIcon)
        
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        locationIcon.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 12).isActive = true
        locationIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                              constant: 20).isActive = true
        locationIcon.widthAnchor.constraint(equalToConstant: 14).isActive = true
        locationIcon.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    private func setupLocationLabel() {
        locationLabel.font = .boldSystemFontOfSize(size: 12)
        locationLabel.textColor = .white
        locationLabel.textAlignment = .left
        locationLabel.numberOfLines = 1
        view.addSubview(locationLabel)
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor,
                                           constant: 12).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 2).isActive = true
        locationLabel.widthAnchor.constraint(equalToConstant: width - 56).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    private func setupSaveButton() {
        let yAnchor = height - Session.bottomPadding - (tabBarController?.tabBar.frame.height ?? 0) - 75
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        saveButton.setImage(UIImage(named: "Edit.pdf"), for: .normal)
        saveButton.backgroundColor = .hdButtonColor
        saveButton.layer.cornerRadius = 22
        view.addSubview(saveButton)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.bottomAnchor.constraint(equalTo: view.topAnchor,
                                           constant: yAnchor).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                            constant: (width - 98) / 2).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func setupDeleteButton() {
        let yAnchor = height - Session.bottomPadding - (tabBarController?.tabBar.frame.height ?? 0) - 75
        deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        deleteButton.setImage(UIImage(named: "Trash Icon.pdf"), for: .normal)
        deleteButton.backgroundColor = .hdButtonColor
        deleteButton.layer.cornerRadius = 22
        view.addSubview(deleteButton)
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.bottomAnchor.constraint(equalTo: view.topAnchor,
                                             constant: yAnchor).isActive = true
        deleteButton.leadingAnchor.constraint(equalTo: saveButton.trailingAnchor, constant: 10).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
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
        presenter?.saveEvent()
    }
    
    @objc private func deleteButtonPressed() {
        presenter?.deleteEvent()
    }
    
}
