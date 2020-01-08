//
//  AppointmentAddViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

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
    private let timerLabel = UILabel()
    private var tenMinutesButton = HDButton()
    private var thirtyMinutesButton = HDButton()
    private var oneHourButton = HDButton()
    private var otherTimeButton = HDButton()
    private let locationLabel = UILabel()
    private let saveButton = UIButton()
    private let deleteButton = UIButton()
    private var keyboardHeight: CGFloat = 0
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        setupBackground()
        setupScrollView()
        setupHeaderViewWithAvatar(title: "Новое событие",
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
        setupTimerLabel()
        setupTenMinutesButton()
        setupThirtyMinutesButton()
        setupOneHourButton()
        setupOtherTimeButton()
        setupLocationLabel()
        setupSaveButton()
        setupDeleteButton()
        addTapGestureToHideKeyboard()
        firstAppointmentButton.isSelected = true
        reAppointmentButton.isSelected = false
        firstAppointmentButton.alternateButton = [reAppointmentButton]
        reAppointmentButton.alternateButton = [firstAppointmentButton]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.statusBarBackgroundColor = .tabBarColor
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
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
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
        topLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
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
        startLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 10).isActive = true
        startLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        startLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        startLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
    }
    private func setupStartDatePicker() {
        startDatePicker.backgroundColor = .white
        scrollView.addSubview(startDatePicker)
        
        startDatePicker.translatesAutoresizingMaskIntoConstraints = false
        startDatePicker.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 1).isActive = true
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
        patientNameLabel.topAnchor.constraint(equalTo: finishDatePicker.bottomAnchor, constant: 10).isActive = true
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
                                                             height: patientNameTextField.frame.height))
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
    
    private func setupTimerLabel() {
        timerLabel.font = .boldSystemFontOfSize(size: 12)
        timerLabel.textColor = .white
        timerLabel.attributedText = redStar(text: "🔔 Уведомить за")
        timerLabel.textAlignment = .left
        timerLabel.numberOfLines = 1
        scrollView.addSubview(timerLabel)
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.topAnchor.constraint(equalTo: reAppointmentButton.bottomAnchor,
                                                    constant: 12).isActive = true
        timerLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        timerLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        timerLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    private func setupTenMinutesButton() {
        tenMinutesButton = HDButton(title: "10 минут", fontSize: 12)
        tenMinutesButton.layer.cornerRadius = 10
        tenMinutesButton.addTarget(self, action: #selector(tenMinutesButtonPressed), for: .touchUpInside)
        view.addSubview(tenMinutesButton)
        
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
        view.addSubview(thirtyMinutesButton)
        
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
        view.addSubview(oneHourButton)
        
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
        view.addSubview(otherTimeButton)
        
        otherTimeButton.translatesAutoresizingMaskIntoConstraints = false
        otherTimeButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor,
                                            constant: 5).isActive = true
        otherTimeButton.leadingAnchor.constraint(equalTo: oneHourButton.trailingAnchor,
                                                 constant: 5).isActive = true
        otherTimeButton.widthAnchor.constraint(equalToConstant: (width - 55) / 4).isActive = true
        otherTimeButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupLocationLabel() {
        locationLabel.font = .boldSystemFontOfSize(size: 12)
        locationLabel.textColor = .white
        locationLabel.attributedText = redStar(text: "Укажите место")
        locationLabel.textAlignment = .left
        locationLabel.numberOfLines = 1
        scrollView.addSubview(locationLabel)
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: tenMinutesButton.bottomAnchor,
                                                    constant: 9).isActive = true
        locationLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        locationLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    private func setupSaveButton() {
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        saveButton.setImage(UIImage(named: "Save.pdf"), for: .normal)
        saveButton.backgroundColor = .hdButtonColor
        saveButton.layer.cornerRadius = 22
        view.addSubview(saveButton)
        
        let window = UIApplication.shared.keyWindow
        let bottomPadding = window?.safeAreaInsets.bottom
        let yAnchor = height - (bottomPadding ?? 0) - (tabBarController?.tabBar.frame.height ?? 0) - 75
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.bottomAnchor.constraint(equalTo: scrollView.topAnchor,
                                           constant: yAnchor).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                            constant: (width - 98) / 2).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func setupDeleteButton() {
        deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        deleteButton.setImage(UIImage(named: "Trash Icon.pdf"), for: .normal)
        deleteButton.backgroundColor = .hdButtonColor
        deleteButton.layer.cornerRadius = 22
        view.addSubview(deleteButton)
        
        let window = UIApplication.shared.keyWindow
        let bottomPadding = window?.safeAreaInsets.bottom
        let yAnchor = height - (bottomPadding ?? 0) - (tabBarController?.tabBar.frame.height ?? 0) - 75
        
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
    
    // MARK: - Buttons methods
    @objc private func tenMinutesButtonPressed() {
        print("Tapped")
    }
    
    @objc private func thirtyMinutesButtonPressed() {
        print("Tapped")
    }
    
    @objc private func oneHourButtonPressed() {
        print("Tapped")
    }
    
    @objc private func otherTimeButtonPressed() {
        print("Tapped")
    }
    
    @objc private func saveButtonPressed() {
        print("Tapped")
    }
    
    @objc private func deleteButtonPressed() {
        print("Tapped")
    }

}
