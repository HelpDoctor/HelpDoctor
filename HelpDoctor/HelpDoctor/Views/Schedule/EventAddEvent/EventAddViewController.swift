//
//  EventAddViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 09.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class EventAddViewController: UIViewController, UIScrollViewDelegate {

    // MARK: - Dependency
    var presenter: EventAddPresenterProtocol?
    
    // MARK: - Constants
    private let scrollView = UIScrollView()
    private let titleLabel = UILabel()
    private let topLabel = UILabel()
    private let startLabel = UILabel()
    private let startDatePicker = UIDatePicker()
    private let finishLabel = UILabel()
    private let finishDatePicker = UIDatePicker()
    private let eventNameLabel = UILabel()
    private let eventNameTextField = UITextField()
    private let majorCheckBox = CheckBox()
    private let replyCheckBox = CheckBox()
    private let alldayCheckBox = CheckBox()
    private let descriptionTopLabel = UILabel()
    private let descriptionBottomLabel = UILabel()
    private let descriptionTextField = UITextField()
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
        setupEventNameLabel()
        setupEventNameTextField()
        setupMajorCheckBox()
        setupReplyCheckBox()
        setupAlldayCheckBox()
        setupDescriptionTopLabel()
        setupDescriptionBottomLabel()
        setupDescriptionTextField()
        setupTimerLabel()
        setupTenMinutesButton()
        setupThirtyMinutesButton()
        setupOneHourButton()
        setupOtherTimeButton()
        setupLocationLabel()
        setupSaveButton()
        setupDeleteButton()
        addTapGestureToHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.statusBarBackgroundColor = .tabBarColor
    }
    
    // MARK: - Public methods
    func setEventOnView(event: ScheduleEvents) {
        guard let startDate = presenter?.convertStringToDate(date: event.start_date),
            let endDate = presenter?.convertStringToDate(date: event.end_date) else { return }
        startDatePicker.setDate(startDate, animated: true)
        finishDatePicker.setDate(endDate, animated: true)
        eventNameTextField.text = event.title
        descriptionTextField.text = event.description
        majorCheckBox.isSelected = event.is_major ?? false
        
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
        titleLabel.text = presenter?.getEventTitle() ?? ""
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
    
    private func setupEventNameLabel() {
        eventNameLabel.font = .boldSystemFontOfSize(size: 12)
        eventNameLabel.textColor = .white
        eventNameLabel.attributedText = redStar(text: "Введите название*")
        eventNameLabel.textAlignment = .left
        eventNameLabel.numberOfLines = 1
        scrollView.addSubview(eventNameLabel)
        
        eventNameLabel.translatesAutoresizingMaskIntoConstraints = false
        eventNameLabel.topAnchor.constraint(equalTo: finishDatePicker.bottomAnchor, constant: 8).isActive = true
        eventNameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        eventNameLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        eventNameLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    private func setupEventNameTextField() {
        eventNameTextField.font = UIFont.systemFontOfSize(size: 14)
        eventNameTextField.textColor = .black
        eventNameTextField.placeholder = "Конференция по хирургии"
        eventNameTextField.textAlignment = .left
        eventNameTextField.backgroundColor = .white
        eventNameTextField.layer.cornerRadius = 5
        eventNameTextField.leftView = UIView(frame: CGRect(x: 0,
                                                             y: 0,
                                                             width: 8,
                                                             height: eventNameTextField.frame.height))
        eventNameTextField.leftViewMode = .always
        scrollView.addSubview(eventNameTextField)
        
        eventNameTextField.translatesAutoresizingMaskIntoConstraints = false
        eventNameTextField.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor, constant: 1).isActive = true
        eventNameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        eventNameTextField.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        eventNameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupMajorCheckBox() {
        majorCheckBox.setTitle(" Важное", for: .normal)
        majorCheckBox.titleLabel?.font = UIFont.boldSystemFontOfSize(size: 12)
        majorCheckBox.setTitleColor(.white, for: .normal)
        majorCheckBox.addTarget(self, action: #selector(majorCheckBoxPressed), for: .touchUpInside)
        scrollView.addSubview(majorCheckBox)
        
        majorCheckBox.translatesAutoresizingMaskIntoConstraints = false
        majorCheckBox.topAnchor.constraint(equalTo: eventNameTextField.bottomAnchor,
                                           constant: 8).isActive = true
        majorCheckBox.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 66).isActive = true
        majorCheckBox.heightAnchor.constraint(equalToConstant: 11).isActive = true
    }
    
    private func setupReplyCheckBox() {
        replyCheckBox.setTitle(" Повтор", for: .normal)
        replyCheckBox.titleLabel?.font = UIFont.boldSystemFontOfSize(size: 12)
        replyCheckBox.setTitleColor(.white, for: .normal)
        replyCheckBox.addTarget(self, action: #selector(replyCheckBoxPressed), for: .touchUpInside)
        scrollView.addSubview(replyCheckBox)
        
        replyCheckBox.translatesAutoresizingMaskIntoConstraints = false
        replyCheckBox.topAnchor.constraint(equalTo: majorCheckBox.bottomAnchor,
                                           constant: 8).isActive = true
        replyCheckBox.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 66).isActive = true
        replyCheckBox.heightAnchor.constraint(equalToConstant: 11).isActive = true
    }
    
    private func setupAlldayCheckBox() {
        alldayCheckBox.setTitle(" Весь день", for: .normal)
        alldayCheckBox.titleLabel?.font = UIFont.boldSystemFontOfSize(size: 12)
        alldayCheckBox.setTitleColor(.white, for: .normal)
        alldayCheckBox.addTarget(self, action: #selector(alldayCheckBoxPressed), for: .touchUpInside)
        scrollView.addSubview(alldayCheckBox)
        
        alldayCheckBox.translatesAutoresizingMaskIntoConstraints = false
        alldayCheckBox.topAnchor.constraint(equalTo: eventNameTextField.bottomAnchor,
                                           constant: 8).isActive = true
        alldayCheckBox.leadingAnchor.constraint(equalTo: majorCheckBox.trailingAnchor, constant: 25).isActive = true
        alldayCheckBox.heightAnchor.constraint(equalToConstant: 11).isActive = true
    }
    
    private func setupDescriptionTopLabel() {
        descriptionTopLabel.font = .boldSystemFontOfSize(size: 12)
        descriptionTopLabel.textColor = .white
        descriptionTopLabel.attributedText = redStar(text: "Добавьте описание")
        descriptionTopLabel.textAlignment = .left
        descriptionTopLabel.numberOfLines = 1
        scrollView.addSubview(descriptionTopLabel)
        
        descriptionTopLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTopLabel.topAnchor.constraint(equalTo: replyCheckBox.bottomAnchor,
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
        descriptionTextField.placeholder = "Прехать заранее на регистрацию"
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
    
    private func setupTimerLabel() {
        timerLabel.font = .boldSystemFontOfSize(size: 12)
        timerLabel.textColor = .white
        timerLabel.attributedText = redStar(text: "🔔 Уведомить за")
        timerLabel.textAlignment = .left
        timerLabel.numberOfLines = 1
        scrollView.addSubview(timerLabel)
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor,
                                                    constant: 8).isActive = true
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
                                                    constant: 5).isActive = true
        locationLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        locationLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
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
    
    @objc private func datePickerValueChanged(_ datePicker: UIDatePicker) {
        finishDatePicker.minimumDate = datePicker.date
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
                             isMajor: majorCheckBox.isSelected,
                             title: eventNameTextField.text,
                             desc: descriptionTextField.text)
    }
    
    @objc private func deleteButtonPressed() {
        presenter?.deleteEvent()
    }
    
    @objc private func majorCheckBoxPressed() {
        majorCheckBox.isSelected = !majorCheckBox.isSelected
    }
    
    @objc private func replyCheckBoxPressed() {
        replyCheckBox.isSelected = !replyCheckBox.isSelected
    }

    @objc private func alldayCheckBoxPressed() {
        alldayCheckBox.isSelected = !alldayCheckBox.isSelected
        startDatePicker.isEnabled = !alldayCheckBox.isSelected
        finishDatePicker.isEnabled = !alldayCheckBox.isSelected
        setAlldayPicker()
    }
    
    func setAlldayPicker() {
        var components = Calendar.current.dateComponents([.year, .month, .day, .minute, .hour],
                                                         from: startDatePicker.date)
        components.setValue(0, for: .minute)
        components.setValue(9, for: .hour)
        guard let finalTime = Calendar.current.date(from: components) else { return }
        startDatePicker.setDate(finalTime, animated: true)
        finishDatePicker.setDate(finalTime + 43200, animated: true)
    }

}
