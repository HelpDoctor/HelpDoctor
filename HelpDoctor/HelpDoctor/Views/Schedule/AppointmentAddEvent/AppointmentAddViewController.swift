//
//  AppointmentAddViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import MapKit
import UIKit

class AppointmentAddViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: AppointmentAddPresenterProtocol?
    
    // MARK: - Constants
    private let scrollView = UIScrollView()
    private let titleLabel = UILabel()
    private let topLabel = UILabel()
    private let startLabel = UILabel()
    private let startDatePicker = UIDatePicker()
    private let finishLabel = UILabel()
    private let finishDatePicker = UIDatePicker()
    private let patientNameLabel = UILabel()
    private let patientNameTextField = UITextField()
    private let descriptionTopLabel = UILabel()
    private let descriptionBottomLabel = UILabel()
    private let descriptionTextField = UITextField()
    private let firstAppointmentButton = RadioButton()
    private let reAppointmentButton = RadioButton()
    private let bellIcon = UIImageView()
    private let timerLabel = UILabel()
    private var tenMinutesButton = HDButton()
    private var thirtyMinutesButton = HDButton()
    private var oneHourButton = HDButton()
    private var otherTimeButton = HDButton()
    private let locationIcon = UIImageView()
    private let locationButton = UIButton()
    private let saveButton = UIButton()
    private let deleteButton = UIButton()
    private var keyboardHeight: CGFloat = 0
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getEvent()
        setupBackground()
        setupScrollView()
        setupHeaderViewWithAvatar(title: presenter?.getStatusEvent() ?? "",
                                  text: nil,
                                  userImage: nil,
                                  presenter: presenter)
        setupScrollView()
        setupTitleLabel()
        setupTopLabel()
        setupStartLabel()
        setupStartDatePicker()
        setupFinishLabel()
        setupFinishDatePicker()
        setupPatientNameLabel()
        setupPatientNameTextField()
        setupDescriptionTopLabel()
        setupDescriptionBottomLabel()
        setupDescriptionTextField()
        setupFirstAppointmentButton()
        setupReAppointmentButton()
        setupBellIcon()
        setupTimerLabel()
        setupTenMinutesButton()
        setupThirtyMinutesButton()
        setupOneHourButton()
        setupOtherTimeButton()
        setupLocationIcon()
        setupLocationButton()
        setupSaveButton()
        setupDeleteButton()
        addTapGestureToHideKeyboard()
        addSwipeGestureToBack()
        firstAppointmentButton.isSelected = true
        reAppointmentButton.isSelected = false
        firstAppointmentButton.alternateButton = [reAppointmentButton]
        reAppointmentButton.alternateButton = [firstAppointmentButton]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Public methods
    func setEventOnView(event: ScheduleEvents) {
        guard let startDate = presenter?.convertStringToDate(date: event.start_date),
            let endDate = presenter?.convertStringToDate(date: event.end_date) else { return }
        startDatePicker.setDate(startDate, animated: true)
        finishDatePicker.setDate(endDate, animated: true)
        patientNameTextField.text = event.title
        descriptionTextField.text = event.description
        guard let notifyDate = event.notify_date else { return }
        guard let notify = presenter?.convertStringToDate(date: notifyDate) else { return }
        let dateDiff = Calendar.current.dateComponents([.minute], from: notify, to: startDate).minute
        switch dateDiff {
        case 0:
            tenMinutesButton.update(isSelected: false)
            thirtyMinutesButton.update(isSelected: false)
            oneHourButton.update(isSelected: false)
            otherTimeButton.update(isSelected: false)
        case 10:
            tenMinutesButton.update(isSelected: true)
            thirtyMinutesButton.update(isSelected: false)
            oneHourButton.update(isSelected: false)
            otherTimeButton.update(isSelected: false)
        case 30:
            tenMinutesButton.update(isSelected: false)
            thirtyMinutesButton.update(isSelected: true)
            oneHourButton.update(isSelected: false)
            otherTimeButton.update(isSelected: false)
        case 60:
            tenMinutesButton.update(isSelected: false)
            thirtyMinutesButton.update(isSelected: false)
            oneHourButton.update(isSelected: true)
            otherTimeButton.update(isSelected: false)
        default:
            tenMinutesButton.update(isSelected: false)
            thirtyMinutesButton.update(isSelected: false)
            oneHourButton.update(isSelected: false)
            otherTimeButton.update(isSelected: true)
        }
    }
    
    // MARK: - Setup views
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: width, height: height)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: view.frame.size.height).isActive = true
    }
    
    private func setupTitleLabel() {
        titleLabel.font = .boldSystemFontOfSize(size: 18)
        titleLabel.textColor = .white
        titleLabel.text = "Прием пациентов"
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        scrollView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 5).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupTopLabel() {
        topLabel.font = .systemFontOfSize(size: 14)
        topLabel.textColor = .white
        topLabel.attributedText = redStar(text: "Выберите дату и время события*")
        topLabel.textAlignment = .center
        topLabel.numberOfLines = 1
        scrollView.addSubview(topLabel)
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        topLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
    }
    
    private func setupStartLabel() {
        startLabel.font = .boldSystemFontOfSize(size: 12)
        startLabel.textColor = .white
        startLabel.attributedText = redStar(text: "Начало события")
        startLabel.textAlignment = .center
        startLabel.numberOfLines = 1
        scrollView.addSubview(startLabel)
        
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        startLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 8).isActive = true
        startLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        startLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        startLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
    }
    private func setupStartDatePicker() {
        startDatePicker.backgroundColor = .white
        startDatePicker.setDate(Date(), animated: true)
        startDatePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        scrollView.addSubview(startDatePicker)
        
        startDatePicker.translatesAutoresizingMaskIntoConstraints = false
        startDatePicker.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: 1).isActive = true
        startDatePicker.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        startDatePicker.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        startDatePicker.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    private func setupFinishLabel() {
        finishLabel.font = .boldSystemFontOfSize(size: 12)
        finishLabel.textColor = .white
        finishLabel.attributedText = redStar(text: "Конец события")
        finishLabel.textAlignment = .center
        finishLabel.numberOfLines = 1
        scrollView.addSubview(finishLabel)
        
        finishLabel.translatesAutoresizingMaskIntoConstraints = false
        finishLabel.topAnchor.constraint(equalTo: startDatePicker.bottomAnchor, constant: 3).isActive = true
        finishLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        finishLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        finishLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
    }
    
    private func setupFinishDatePicker() {
        finishDatePicker.backgroundColor = .white
        finishDatePicker.setDate(startDatePicker.date + 1800, animated: true)
        finishDatePicker.minimumDate = startDatePicker.date
        scrollView.addSubview(finishDatePicker)
        
        finishDatePicker.translatesAutoresizingMaskIntoConstraints = false
        finishDatePicker.topAnchor.constraint(equalTo: finishLabel.bottomAnchor, constant: 1).isActive = true
        finishDatePicker.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        finishDatePicker.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        finishDatePicker.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    private func setupPatientNameLabel() {
        patientNameLabel.font = .boldSystemFontOfSize(size: 12)
        patientNameLabel.textColor = .white
        patientNameLabel.attributedText = redStar(text: "Введите ФИО пациента*")
        patientNameLabel.textAlignment = .left
        patientNameLabel.numberOfLines = 1
        scrollView.addSubview(patientNameLabel)
        
        patientNameLabel.translatesAutoresizingMaskIntoConstraints = false
        patientNameLabel.topAnchor.constraint(equalTo: finishDatePicker.bottomAnchor, constant: 8).isActive = true
        patientNameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        patientNameLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        patientNameLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    private func setupPatientNameTextField() {
        patientNameTextField.font = UIFont.systemFontOfSize(size: 14)
        patientNameTextField.textColor = .black
        patientNameTextField.placeholder = "Иванов Иван Иванович"
        patientNameTextField.textAlignment = .left
        patientNameTextField.backgroundColor = .white
        patientNameTextField.layer.cornerRadius = 5
        patientNameTextField.leftView = UIView(frame: CGRect(x: 0,
                                                             y: 0,
                                                             width: 8,
                                                             height: patientNameTextField.frame.height))
        patientNameTextField.leftViewMode = .always
        scrollView.addSubview(patientNameTextField)
        
        patientNameTextField.translatesAutoresizingMaskIntoConstraints = false
        patientNameTextField.topAnchor.constraint(equalTo: patientNameLabel.bottomAnchor, constant: 1).isActive = true
        patientNameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        patientNameTextField.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        patientNameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupDescriptionTopLabel() {
        descriptionTopLabel.font = .boldSystemFontOfSize(size: 12)
        descriptionTopLabel.textColor = .white
        descriptionTopLabel.attributedText = redStar(text: "Добавьте описание")
        descriptionTopLabel.textAlignment = .left
        descriptionTopLabel.numberOfLines = 1
        scrollView.addSubview(descriptionTopLabel)
        
        descriptionTopLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTopLabel.topAnchor.constraint(equalTo: patientNameTextField.bottomAnchor,
                                                 constant: 5).isActive = true
        descriptionTopLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        descriptionTopLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        descriptionTopLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    private func setupDescriptionBottomLabel() {
        descriptionBottomLabel.font = .italicSystemFontOfSize(size: 11)
        descriptionBottomLabel.textColor = .white
        descriptionBottomLabel.attributedText = redStar(text: "Не более 100 символов")
        descriptionBottomLabel.textAlignment = .left
        descriptionBottomLabel.numberOfLines = 1
        scrollView.addSubview(descriptionBottomLabel)
        
        descriptionBottomLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionBottomLabel.topAnchor.constraint(equalTo: descriptionTopLabel.bottomAnchor,
                                                    constant: 1).isActive = true
        descriptionBottomLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        descriptionBottomLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        descriptionBottomLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    private func setupDescriptionTextField() {
        descriptionTextField.font = UIFont.systemFontOfSize(size: 14)
        descriptionTextField.textColor = .black
        descriptionTextField.placeholder = "Назначить ОАК, ОАМ"
        descriptionTextField.textAlignment = .left
        descriptionTextField.backgroundColor = .white
        descriptionTextField.layer.cornerRadius = 5
        descriptionTextField.leftView = UIView(frame: CGRect(x: 0,
                                                             y: 0,
                                                             width: 8,
                                                             height: descriptionTextField.frame.height))
        descriptionTextField.leftViewMode = .always
        scrollView.addSubview(descriptionTextField)
        
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.topAnchor.constraint(equalTo: descriptionBottomLabel.bottomAnchor,
                                                  constant: 1).isActive = true
        descriptionTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        descriptionTextField.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        descriptionTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupFirstAppointmentButton() {
        firstAppointmentButton.setTitle(" Первичный прием", for: .normal)
        firstAppointmentButton.titleLabel?.font = UIFont.boldSystemFontOfSize(size: 12)
        firstAppointmentButton.setTitleColor(.white, for: .normal)
        scrollView.addSubview(firstAppointmentButton)
        
        firstAppointmentButton.translatesAutoresizingMaskIntoConstraints = false
        firstAppointmentButton.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor,
                                                    constant: 8).isActive = true
        firstAppointmentButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        firstAppointmentButton.heightAnchor.constraint(equalToConstant: 11).isActive = true
    }
    
    private func setupReAppointmentButton() {
        reAppointmentButton.setTitle(" Повторный прием", for: .normal)
        reAppointmentButton.titleLabel?.font = UIFont.boldSystemFontOfSize(size: 12)
        reAppointmentButton.setTitleColor(.white, for: .normal)
        scrollView.addSubview(reAppointmentButton)
        
        reAppointmentButton.translatesAutoresizingMaskIntoConstraints = false
        reAppointmentButton.topAnchor.constraint(equalTo: firstAppointmentButton.bottomAnchor,
                                                 constant: 4).isActive = true
        reAppointmentButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        reAppointmentButton.heightAnchor.constraint(equalToConstant: 11).isActive = true
    }
    
    /// Установка иконки колокольчика
    private func setupBellIcon() {
        bellIcon.image = UIImage(named: "BellIcon.pdf")
        scrollView.addSubview(bellIcon)
        
        bellIcon.translatesAutoresizingMaskIntoConstraints = false
        bellIcon.topAnchor.constraint(equalTo: reAppointmentButton.bottomAnchor, constant: 12).isActive = true
        bellIcon.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                          constant: 20).isActive = true
        bellIcon.widthAnchor.constraint(equalToConstant: 14).isActive = true
        bellIcon.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    private func setupTimerLabel() {
        timerLabel.font = .boldSystemFontOfSize(size: 12)
        timerLabel.textColor = .white
        timerLabel.attributedText = redStar(text: "Уведомить за")
        timerLabel.textAlignment = .left
        timerLabel.numberOfLines = 1
        scrollView.addSubview(timerLabel)
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.topAnchor.constraint(equalTo: reAppointmentButton.bottomAnchor,
                                        constant: 12).isActive = true
        timerLabel.leadingAnchor.constraint(equalTo: bellIcon.trailingAnchor, constant: 2).isActive = true
        timerLabel.widthAnchor.constraint(equalToConstant: width - 56).isActive = true
        timerLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    private func setupTenMinutesButton() {
        tenMinutesButton = HDButton(title: "10 минут", fontSize: 12)
        tenMinutesButton.layer.cornerRadius = 10
        tenMinutesButton.addTarget(self, action: #selector(tenMinutesButtonPressed), for: .touchUpInside)
        scrollView.addSubview(tenMinutesButton)
        
        tenMinutesButton.translatesAutoresizingMaskIntoConstraints = false
        tenMinutesButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor,
                                              constant: 5).isActive = true
        tenMinutesButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                  constant: 20).isActive = true
        tenMinutesButton.widthAnchor.constraint(equalToConstant: (width - 55) / 4).isActive = true
        tenMinutesButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupThirtyMinutesButton() {
        thirtyMinutesButton = HDButton(title: "30 минут", fontSize: 12)
        thirtyMinutesButton.layer.cornerRadius = 10
        thirtyMinutesButton.addTarget(self, action: #selector(thirtyMinutesButtonPressed), for: .touchUpInside)
        scrollView.addSubview(thirtyMinutesButton)
        
        thirtyMinutesButton.translatesAutoresizingMaskIntoConstraints = false
        thirtyMinutesButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor,
                                                 constant: 5).isActive = true
        thirtyMinutesButton.leadingAnchor.constraint(equalTo: tenMinutesButton.trailingAnchor,
                                                     constant: 5).isActive = true
        thirtyMinutesButton.widthAnchor.constraint(equalToConstant: (width - 55) / 4).isActive = true
        thirtyMinutesButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupOneHourButton() {
        oneHourButton = HDButton(title: "1 час", fontSize: 12)
        oneHourButton.layer.cornerRadius = 10
        oneHourButton.addTarget(self, action: #selector(oneHourButtonPressed), for: .touchUpInside)
        scrollView.addSubview(oneHourButton)
        
        oneHourButton.translatesAutoresizingMaskIntoConstraints = false
        oneHourButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor,
                                           constant: 5).isActive = true
        oneHourButton.leadingAnchor.constraint(equalTo: thirtyMinutesButton.trailingAnchor,
                                               constant: 5).isActive = true
        oneHourButton.widthAnchor.constraint(equalToConstant: (width - 55) / 4).isActive = true
        oneHourButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupOtherTimeButton() {
        otherTimeButton = HDButton(title: "Другое", fontSize: 12)
        otherTimeButton.layer.cornerRadius = 10
        otherTimeButton.addTarget(self, action: #selector(otherTimeButtonPressed), for: .touchUpInside)
        scrollView.addSubview(otherTimeButton)
        
        otherTimeButton.translatesAutoresizingMaskIntoConstraints = false
        otherTimeButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor,
                                             constant: 5).isActive = true
        otherTimeButton.leadingAnchor.constraint(equalTo: oneHourButton.trailingAnchor,
                                                 constant: 5).isActive = true
        otherTimeButton.widthAnchor.constraint(equalToConstant: (width - 55) / 4).isActive = true
        otherTimeButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    /// Установка иконки местоположения
    private func setupLocationIcon() {
        locationIcon.image = UIImage(named: "LocationIcon.pdf")
        scrollView.addSubview(locationIcon)
        
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        locationIcon.topAnchor.constraint(equalTo: tenMinutesButton.bottomAnchor, constant: 5).isActive = true
        locationIcon.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                              constant: 20).isActive = true
        locationIcon.widthAnchor.constraint(equalToConstant: 14).isActive = true
        locationIcon.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    /// Установка кнопки указания местоположения
    private func setupLocationButton() {
        locationButton.addTarget(self, action: #selector(locationButtonPressed), for: .touchUpInside)
        locationButton.contentHorizontalAlignment = .left
        locationButton.titleLabel?.font = .boldSystemFontOfSize(size: 12)
        locationButton.titleLabel?.textColor = .white
        locationButton.setTitle("Укажите место", for: .normal)
        scrollView.addSubview(locationButton)
        
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.topAnchor.constraint(equalTo: tenMinutesButton.bottomAnchor,
                                           constant: 5).isActive = true
        locationButton.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 2).isActive = true
        locationButton.widthAnchor.constraint(equalToConstant: width - 56).isActive = true
        locationButton.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    private func setupSaveButton() {
        let yAnchor = height - Session.bottomPadding - (tabBarController?.tabBar.frame.height ?? 0) - 75
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        saveButton.setImage(UIImage(named: "SaveButton.pdf"), for: .normal)
        saveButton.backgroundColor = .hdButtonColor
        saveButton.layer.cornerRadius = 22
        view.addSubview(saveButton)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.bottomAnchor.constraint(equalTo: scrollView.topAnchor,
                                           constant: yAnchor).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
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
        deleteButton.bottomAnchor.constraint(equalTo: scrollView.topAnchor,
                                             constant: yAnchor).isActive = true
        deleteButton.leadingAnchor.constraint(equalTo: saveButton.trailingAnchor, constant: 10).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func addTapGestureToHideKeyboard() {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self,
                                                         action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(hideKeyboardGesture)
        
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
        scrollView.addGestureRecognizer(swipeLeft)
    }
    
    // MARK: - IBActions
    @objc func hideKeyboard() {
        scrollView.endEditing(true)
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
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        keyboardHeight = kbSize.height
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func datePickerValueChanged(_ datePicker: UIDatePicker) {
        finishDatePicker.minimumDate = datePicker.date
        if tenMinutesButton.isSelected {
            presenter?.setNotifyDate(date: startDatePicker.date - 600)
        } else if thirtyMinutesButton.isSelected {
            presenter?.setNotifyDate(date: startDatePicker.date - 1800)
        } else if oneHourButton.isSelected {
            presenter?.setNotifyDate(date: startDatePicker.date - 3600)
        } else if otherTimeButton.isSelected {
            showAlert(message: "Скорректируйте время уведомления")
            otherTimeButton.update(isSelected: false)
            presenter?.setNotifyDate(date: nil)
        }
    }
    
    /// Переход на предыдущий экран
    @objc private func backButtonPressed() {
        presenter?.back()
    }
    
    @objc private func locationButtonPressed() {
        presenter?.toMap()
    }
    
    // MARK: - Buttons methods
    @objc private func tenMinutesButtonPressed() {
        presenter?.setNotifyDate(date: startDatePicker.date - 600)
        tenMinutesButton.update(isSelected: true)
        thirtyMinutesButton.update(isSelected: false)
        oneHourButton.update(isSelected: false)
        otherTimeButton.update(isSelected: false)
    }
    
    @objc private func thirtyMinutesButtonPressed() {
        presenter?.setNotifyDate(date: startDatePicker.date - 1800)
        tenMinutesButton.update(isSelected: false)
        thirtyMinutesButton.update(isSelected: true)
        oneHourButton.update(isSelected: false)
        otherTimeButton.update(isSelected: false)
    }
    
    @objc private func oneHourButtonPressed() {
        presenter?.setNotifyDate(date: startDatePicker.date - 3600)
        tenMinutesButton.update(isSelected: false)
        thirtyMinutesButton.update(isSelected: false)
        oneHourButton.update(isSelected: true)
        otherTimeButton.update(isSelected: false)
    }
    
    @objc private func otherTimeButtonPressed() {
        tenMinutesButton.update(isSelected: false)
        thirtyMinutesButton.update(isSelected: false)
        oneHourButton.update(isSelected: false)
        otherTimeButton.update(isSelected: true)
        presenter?.otherNotifyTime(startDate: startDatePicker.date)
    }
    
    @objc private func saveButtonPressed() {
        presenter?.saveEvent(startDate: startDatePicker.date,
                             endDate: finishDatePicker.date,
                             title: patientNameTextField.text,
                             desc: descriptionTextField.text,
                             location: locationButton.titleLabel?.text)
    }
    
    @objc private func deleteButtonPressed() {
        presenter?.deleteEvent()
    }
    
}

extension AppointmentAddViewController: MapKitSearchDelegate {
    
    func mapKitSearch(_ locationSearchViewController: LocationSearchViewController, mapItem: MKMapItem) {
        locationButton.setTitle(mapItem.name, for: .normal)
    }
    
}
