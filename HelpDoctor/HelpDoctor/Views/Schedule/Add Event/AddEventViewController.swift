//
//  AddEventViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 20.08.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: AddEventPresenterProtocol?
    
    // MARK: - Constants
    private let onThumbTintColor = UIColor.hdButtonColor
    private let offThumbTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    private let insetDateLabel = 10.f
    private let headerHeight = 40.f
    private let heightTextView = 60.f
    private let heightTopView = 40.f
    private let heightLabel = 20.f
    private let heightTextField = 30.f
    private let widthDateLabel = 50.f
    private var widthDateTextField = 0.f
    private let widthTextField = Session.width - 40
    private let scrollView = UIScrollView()
    private let topView = UIView()
    private let cancelButton = UIButton()
    private let okButton = UIButton()
    private let titleTextField = UITextField()
    private let eventTypeTextField = UITextField()
    private let dateLabel = UILabel()
    private let startDateLabel = UILabel()
    private let startDateTextField = UITextField()
    private let endDateLabel = UILabel()
    private let endDateTextField = UITextField()
    private let locationTextField = UITextField()
    private let guestLabel = UILabel()
    private let guestTextView = UITextView()
    private let alldayLabel = UILabel()
    private let alldayButton = UIButton()
    private let repeatLabel = UILabel()
    private let repeatSwitch = UISwitch()
    private let majorLabel = UILabel()
    private let majorSwitch = UISwitch()
    private let timerImage = UIImageView()
    private let timerLabel = UILabel()
    private let tenMinutesButton = HDButton(title: "10 минут", fontSize: 12)
    private let thirtyMinutesButton = HDButton(title: "30 минут", fontSize: 12)
    private let oneHourButton = HDButton(title: "1 час", fontSize: 12)
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        widthDateTextField = (Session.width - 40 - (2 * widthDateLabel) - (3 * insetDateLabel)) / 2
        setupHeaderView(color: .tabBarColor,
                        height: headerHeight,
                        presenter: presenter,
                        title: "Новое событие",
                        font: .boldSystemFontOfSize(size: 14))
        setupScrollView()
        setupTopView()
        setupCancelButton()
        setupOkButton()
        setupTitleTextField()
        setupEventTypeTextField()
        setupDateLabel()
        setupStartDateLabel()
        setupStartDateTextField()
        setupEndDateLabel()
        setupEndDateTextField()
        setupLocationTextField()
        setupGuestLabel()
        setupGuestTextView()
        setupAlldayLabel()
        setupAlldayButton()
        setupRepeatLabel()
        setupRepeatSwitch()
        setupMajorLabel()
        setupMajorSwitch()
        setupTimerImage()
        setupTimerLabel()
        setupTenMinutesButton()
        setupThirtyMinutesButton()
        setupOneHourButton()
        addSwipeGestureToBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Setup views
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: Session.width, height: Session.height - headerHeight)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: headerHeight).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: Session.height).isActive = true
    }
    
    private func setupTopView() {
        topView.backgroundColor = .searchBarTintColor
        scrollView.addSubview(topView)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: heightTopView).isActive = true
    }
    
    private func setupCancelButton() {
        let leading = 20.f
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        cancelButton.setImage(UIImage(named: "Cross"), for: .normal)
        topView.addSubview(cancelButton)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: leading).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: leading).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: leading).isActive = true
    }
    
    private func setupOkButton() {
        let leading = 20.f
        okButton.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
        okButton.setImage(UIImage(named: "Checkmark"), for: .normal)
        topView.addSubview(okButton)
        
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        okButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -leading).isActive = true
        okButton.widthAnchor.constraint(equalToConstant: leading).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: leading).isActive = true
    }
    
    private func setupTitleTextField() {
        let top = 10.f
        titleTextField.font = .systemFontOfSize(size: 14)
        titleTextField.textColor = .textFieldTextColor
        titleTextField.placeholder = "Название события"
        titleTextField.textAlignment = .left
        titleTextField.autocorrectionType = .no
        titleTextField.backgroundColor = .white
        titleTextField.layer.cornerRadius = 5
        titleTextField.leftView = UIView(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: 8,
                                                       height: titleTextField.frame.height))
        titleTextField.leftViewMode = .always
        scrollView.addSubview(titleTextField)
        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.topAnchor.constraint(equalTo: topView.bottomAnchor,
                                            constant: top).isActive = true
        titleTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        titleTextField.widthAnchor.constraint(equalToConstant: widthTextField).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    private func setupEventTypeTextField() {
        let top = 20.f
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(eventTypeButtonPressed))
        eventTypeTextField.font = .systemFontOfSize(size: 14)
        eventTypeTextField.textColor = .textFieldTextColor
        eventTypeTextField.placeholder = "Тип события"
        eventTypeTextField.textAlignment = .left
        eventTypeTextField.autocorrectionType = .no
        eventTypeTextField.backgroundColor = .white
        eventTypeTextField.layer.cornerRadius = 5
        eventTypeTextField.leftView = UIView(frame: CGRect(x: 0,
                                                           y: 0,
                                                           width: 8,
                                                           height: eventTypeTextField.frame.height))
        eventTypeTextField.leftViewMode = .always
        eventTypeTextField.addGestureRecognizer(tap)
        scrollView.addSubview(eventTypeTextField)
        
        eventTypeTextField.translatesAutoresizingMaskIntoConstraints = false
        eventTypeTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor,
                                                constant: top).isActive = true
        eventTypeTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        eventTypeTextField.widthAnchor.constraint(equalToConstant: widthTextField).isActive = true
        eventTypeTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    private func setupDateLabel() {
        let top = 7.f
        dateLabel.font = .boldSystemFontOfSize(size: 14)
        dateLabel.textColor = .white
        dateLabel.text = "Дата и время события"
        dateLabel.textAlignment = .left
        dateLabel.numberOfLines = 1
        scrollView.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: eventTypeTextField.bottomAnchor,
                                       constant: top).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: widthTextField).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupStartDateLabel() {
        let leading = 20.f
        let top = 11.f
        startDateLabel.font = .boldSystemFontOfSize(size: 14)
        startDateLabel.textColor = .white
        startDateLabel.text = "Начало"
        startDateLabel.textAlignment = .left
        startDateLabel.numberOfLines = 1
        scrollView.addSubview(startDateLabel)
        
        startDateLabel.translatesAutoresizingMaskIntoConstraints = false
        startDateLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor,
                                            constant: top).isActive = true
        startDateLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                constant: leading).isActive = true
        startDateLabel.widthAnchor.constraint(equalToConstant: widthDateLabel).isActive = true
        startDateLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupStartDateTextField() {
        startDateTextField.font = .systemFontOfSize(size: 14)
        startDateTextField.textColor = .textFieldTextColor
        startDateTextField.textAlignment = .left
        startDateTextField.autocorrectionType = .no
        startDateTextField.backgroundColor = .white
        startDateTextField.layer.cornerRadius = 5
        startDateTextField.leftView = UIView(frame: CGRect(x: 0,
                                                           y: 0,
                                                           width: 8,
                                                           height: heightTextField))
        startDateTextField.leftViewMode = .always
        scrollView.addSubview(startDateTextField)
        
        startDateTextField.translatesAutoresizingMaskIntoConstraints = false
        startDateTextField.centerYAnchor.constraint(equalTo: startDateLabel.centerYAnchor).isActive = true
        startDateTextField.leadingAnchor.constraint(equalTo: startDateLabel.trailingAnchor,
                                                    constant: insetDateLabel).isActive = true
        startDateTextField.widthAnchor.constraint(equalToConstant: widthDateTextField).isActive = true
        startDateTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    private func setupEndDateLabel() {
        endDateLabel.font = .boldSystemFontOfSize(size: 14)
        endDateLabel.textColor = .white
        endDateLabel.text = "Конец"
        endDateLabel.textAlignment = .left
        endDateLabel.numberOfLines = 1
        scrollView.addSubview(endDateLabel)
        
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        endDateLabel.centerYAnchor.constraint(equalTo: startDateLabel.centerYAnchor).isActive = true
        endDateLabel.leadingAnchor.constraint(equalTo: startDateTextField.trailingAnchor,
                                              constant: insetDateLabel).isActive = true
        endDateLabel.widthAnchor.constraint(equalToConstant: widthDateLabel).isActive = true
        endDateLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupEndDateTextField() {
        endDateTextField.font = .systemFontOfSize(size: 14)
        endDateTextField.textColor = .textFieldTextColor
        endDateTextField.textAlignment = .left
        endDateTextField.autocorrectionType = .no
        endDateTextField.backgroundColor = .white
        endDateTextField.layer.cornerRadius = 5
        endDateTextField.leftView = UIView(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: 8,
                                                         height: heightTextField))
        endDateTextField.leftViewMode = .always
        scrollView.addSubview(endDateTextField)
        
        endDateTextField.translatesAutoresizingMaskIntoConstraints = false
        endDateTextField.centerYAnchor.constraint(equalTo: startDateLabel.centerYAnchor).isActive = true
        endDateTextField.leadingAnchor.constraint(equalTo: endDateLabel.trailingAnchor,
                                                  constant: insetDateLabel).isActive = true
        endDateTextField.widthAnchor.constraint(equalToConstant: widthDateTextField).isActive = true
        endDateTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    private func setupLocationTextField() {
        let top = 20.f
        locationTextField.font = .systemFontOfSize(size: 14)
        locationTextField.textColor = .textFieldTextColor
        locationTextField.placeholder = "Место"
        locationTextField.textAlignment = .left
        locationTextField.autocorrectionType = .no
        locationTextField.backgroundColor = .white
        locationTextField.layer.cornerRadius = 5
        locationTextField.leftView = UIView(frame: CGRect(x: 0,
                                                          y: 0,
                                                          width: 8,
                                                          height: heightTextField))
        locationTextField.leftViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 11,
                                                  height: heightTextField))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "LocationMark")
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 23,
                                        height: heightTextField))
        view.addSubview(imageView)
        locationTextField.rightView = view
        locationTextField.rightViewMode = .always
        scrollView.addSubview(locationTextField)
        
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        locationTextField.topAnchor.constraint(equalTo: endDateTextField.bottomAnchor,
                                               constant: top).isActive = true
        locationTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        locationTextField.widthAnchor.constraint(equalToConstant: widthTextField).isActive = true
        locationTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    private func setupGuestLabel() {
        let top = 14.f
        guestLabel.font = .boldSystemFontOfSize(size: 16)
        guestLabel.textColor = .white
        guestLabel.text = "Участники"
        guestLabel.textAlignment = .left
        guestLabel.numberOfLines = 1
        scrollView.addSubview(guestLabel)
        
        guestLabel.translatesAutoresizingMaskIntoConstraints = false
        guestLabel.topAnchor.constraint(equalTo: locationTextField.bottomAnchor,
                                       constant: top).isActive = true
        guestLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        guestLabel.widthAnchor.constraint(equalToConstant: widthTextField).isActive = true
        guestLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupGuestTextView() {
        let top = 7.f
        guestTextView.font = .systemFontOfSize(size: 14)
        guestTextView.textColor = .textFieldTextColor
        guestTextView.textAlignment = .left
        guestTextView.autocorrectionType = .no
        guestTextView.backgroundColor = .white
        guestTextView.layer.cornerRadius = 5
        scrollView.addSubview(guestTextView)
        
        guestTextView.translatesAutoresizingMaskIntoConstraints = false
        guestTextView.topAnchor.constraint(equalTo: guestLabel.bottomAnchor,
                                               constant: top).isActive = true
        guestTextView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        guestTextView.widthAnchor.constraint(equalToConstant: widthTextField).isActive = true
        guestTextView.heightAnchor.constraint(equalToConstant: heightTextView).isActive = true
    }
    
    private func setupAlldayLabel() {
        let top = 20.f
        let leading = 20.f
        let width = 135.f
        alldayLabel.font = .systemFontOfSize(size: 14)
        alldayLabel.textColor = .white
        alldayLabel.text = "Весь день"
        alldayLabel.textAlignment = .left
        alldayLabel.numberOfLines = 1
        scrollView.addSubview(alldayLabel)
        
        alldayLabel.translatesAutoresizingMaskIntoConstraints = false
        alldayLabel.topAnchor.constraint(equalTo: guestTextView.bottomAnchor,
                                       constant: top).isActive = true
        alldayLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: leading).isActive = true
        alldayLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        alldayLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupAlldayButton() {
        let size = 20.f
        alldayButton.setImage(UIImage(named: "WhiteEllipse"), for: .normal)
        alldayButton.setImage(UIImage(named: "WhiteSelectedEllipse"), for: .selected)
        alldayButton.imageView?.contentMode = .scaleAspectFill
        alldayButton.contentHorizontalAlignment = .center
        alldayButton.contentVerticalAlignment = .center
        alldayButton.addTarget(self, action: #selector(alldayButtonPressed), for: .touchUpInside)
        scrollView.addSubview(alldayButton)
        
        alldayButton.translatesAutoresizingMaskIntoConstraints = false
        alldayButton.centerYAnchor.constraint(equalTo: alldayLabel.centerYAnchor).isActive = true
        alldayButton.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                              constant: Session.width - 20).isActive = true
        alldayButton.widthAnchor.constraint(equalToConstant: size).isActive = true
        alldayButton.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupRepeatLabel() {
        let top = 20.f
        let leading = 20.f
        let width = 135.f
        repeatLabel.font = .systemFontOfSize(size: 14)
        repeatLabel.textColor = .white
        repeatLabel.text = "Повторять событие"
        repeatLabel.textAlignment = .left
        repeatLabel.numberOfLines = 1
        scrollView.addSubview(repeatLabel)
        
        repeatLabel.translatesAutoresizingMaskIntoConstraints = false
        repeatLabel.topAnchor.constraint(equalTo: alldayLabel.bottomAnchor,
                                       constant: top).isActive = true
        repeatLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: leading).isActive = true
        repeatLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        repeatLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupRepeatSwitch() {
        repeatSwitch.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
        repeatSwitch.setOn(false, animated: true)
        repeatSwitch.thumbTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        repeatSwitch.onTintColor = .white
        repeatSwitch.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
//        repeatSwitch.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        scrollView.addSubview(repeatSwitch)
        
        repeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        repeatSwitch.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                               constant: Session.width - 20).isActive = true
        repeatSwitch.centerYAnchor.constraint(equalTo: repeatLabel.centerYAnchor).isActive = true
    }
    
    private func setupMajorLabel() {
        let top = 20.f
        let leading = 20.f
        let width = 135.f
        majorLabel.font = .systemFontOfSize(size: 14)
        majorLabel.textColor = .white
        majorLabel.text = "Важное"
        majorLabel.textAlignment = .left
        majorLabel.numberOfLines = 1
        scrollView.addSubview(majorLabel)
        
        majorLabel.translatesAutoresizingMaskIntoConstraints = false
        majorLabel.topAnchor.constraint(equalTo: repeatLabel.bottomAnchor,
                                       constant: top).isActive = true
        majorLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: leading).isActive = true
        majorLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        majorLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupMajorSwitch() {
        majorSwitch.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
        majorSwitch.setOn(false, animated: true)
        majorSwitch.thumbTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        majorSwitch.onTintColor = .white
        majorSwitch.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        scrollView.addSubview(majorSwitch)
        
        majorSwitch.translatesAutoresizingMaskIntoConstraints = false
        majorSwitch.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                               constant: Session.width - 20).isActive = true
        majorSwitch.centerYAnchor.constraint(equalTo: majorLabel.centerYAnchor).isActive = true
    }
    
    private func setupTimerImage() {
        let top = 10.f
        let leading = 20.f
        let size = 20.f
        timerImage.image = UIImage(named: "BellIcon")
        scrollView.addSubview(timerImage)
        
        timerImage.translatesAutoresizingMaskIntoConstraints = false
        timerImage.topAnchor.constraint(equalTo: majorLabel.bottomAnchor,
                                        constant: top).isActive = true
        timerImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                          constant: leading).isActive = true
        timerImage.widthAnchor.constraint(equalToConstant: size).isActive = true
        timerImage.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupTimerLabel() {
        let leading = 10.f
        timerLabel.font = .boldSystemFontOfSize(size: 14)
        timerLabel.textColor = .white
        timerLabel.text = "Уведомить за"
        timerLabel.textAlignment = .left
        timerLabel.numberOfLines = 1
        scrollView.addSubview(timerLabel)
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.centerYAnchor.constraint(equalTo: timerImage.centerYAnchor).isActive = true
        timerLabel.leadingAnchor.constraint(equalTo: timerImage.trailingAnchor,
                                            constant: leading).isActive = true
        timerLabel.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: Session.width - 20).isActive = true
        timerLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupTenMinutesButton() {
        let top = 10.f
        tenMinutesButton.layer.cornerRadius = 20
        tenMinutesButton.addTarget(self, action: #selector(tenMinutesButtonPressed), for: .touchUpInside)
        scrollView.addSubview(tenMinutesButton)
        
        tenMinutesButton.translatesAutoresizingMaskIntoConstraints = false
        tenMinutesButton.topAnchor.constraint(equalTo: timerImage.bottomAnchor,
                                              constant: top).isActive = true
        tenMinutesButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                  constant: 20).isActive = true
        tenMinutesButton.widthAnchor.constraint(equalToConstant: (Session.width - 80) / 3).isActive = true
        tenMinutesButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupThirtyMinutesButton() {
        thirtyMinutesButton.layer.cornerRadius = 20
        thirtyMinutesButton.addTarget(self, action: #selector(thirtyMinutesButtonPressed), for: .touchUpInside)
        scrollView.addSubview(thirtyMinutesButton)
        
        thirtyMinutesButton.translatesAutoresizingMaskIntoConstraints = false
        thirtyMinutesButton.topAnchor.constraint(equalTo: timerImage.bottomAnchor,
                                                 constant: 10).isActive = true
        thirtyMinutesButton.leadingAnchor.constraint(equalTo: tenMinutesButton.trailingAnchor,
                                                     constant: 20).isActive = true
        thirtyMinutesButton.widthAnchor.constraint(equalToConstant: (Session.width - 80) / 3).isActive = true
        thirtyMinutesButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupOneHourButton() {
        oneHourButton.layer.cornerRadius = 20
        oneHourButton.addTarget(self, action: #selector(oneHourButtonPressed), for: .touchUpInside)
        scrollView.addSubview(oneHourButton)
        
        oneHourButton.translatesAutoresizingMaskIntoConstraints = false
        oneHourButton.topAnchor.constraint(equalTo: timerImage.bottomAnchor,
                                           constant: 10).isActive = true
        oneHourButton.leadingAnchor.constraint(equalTo: thirtyMinutesButton.trailingAnchor,
                                               constant: 20).isActive = true
        oneHourButton.widthAnchor.constraint(equalToConstant: (Session.width - 80) / 3).isActive = true
        oneHourButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    /// Добавляет свайп влево для перехода назад
    private func addSwipeGestureToBack() {
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.addTarget(self, action: #selector(backButtonPressed))
        swipeLeft.direction = .right
        view.addGestureRecognizer(swipeLeft)
    }
    
    func handleSwitchOn(_ sender: UISwitch) {
        
        if sender.isOn {
            topView.backgroundColor = .majorEventColor
        } else {
            topView.backgroundColor = .searchBarTintColor
        }
        
    }
    
    // MARK: - Buttons methods
    @objc private func cancelButtonPressed() {
        print("Tap cancel")
    }
    
    @objc private func okButtonPressed() {
        print("Tap ok")
    }
    
    @objc private func eventTypeButtonPressed() {
        presenter?.eventTypeChoice()
    }
    
    @objc private func alldayButtonPressed() {
        alldayButton.isSelected = !alldayButton.isSelected
    }
    
    @objc func switchStateDidChange(_ sender: UISwitch) {
        if sender == majorSwitch {
            sender.thumbTintColor = sender.isOn ? UIColor.majorEventColor : offThumbTintColor
            handleSwitchOn(sender)
        } else {
            sender.thumbTintColor = sender.isOn ? onThumbTintColor : offThumbTintColor
        }
    }
    
    @objc private func tenMinutesButtonPressed() {
//        presenter?.setNotifyDate(date: startDatePicker.date - 600)
        tenMinutesButton.update(isSelected: true)
        thirtyMinutesButton.update(isSelected: false)
        oneHourButton.update(isSelected: false)
    }
    
    @objc private func thirtyMinutesButtonPressed() {
//        presenter?.setNotifyDate(date: startDatePicker.date - 1800)
        tenMinutesButton.update(isSelected: false)
        thirtyMinutesButton.update(isSelected: true)
        oneHourButton.update(isSelected: false)
    }
    
    @objc private func oneHourButtonPressed() {
//        presenter?.setNotifyDate(date: startDatePicker.date - 3600)
        tenMinutesButton.update(isSelected: false)
        thirtyMinutesButton.update(isSelected: false)
        oneHourButton.update(isSelected: true)
    }
    
    /// Переход на предыдущий экран
    @objc private func backButtonPressed() {
        presenter?.back()
    }
    
}
