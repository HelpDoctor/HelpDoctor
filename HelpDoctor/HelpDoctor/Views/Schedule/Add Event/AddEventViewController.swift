//
//  AddEventViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 20.08.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import MapKit
import UIKit

class AddEventViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: AddEventPresenterProtocol?
    
    // MARK: - Constants
    private let onThumbTintColor = UIColor.hdButtonColor
    private let offThumbTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    private let insetDateLabel = 10.f
    private let headerHeight = 40.f
    private let heightCollectionView = 70.f
    private let heightLabel = 20.f
    private let heightTextField = Session.heightTextField
    private let widthDateLabel = 50.f
    private var widthDateTextField = 0.f
    private let widthTextField = Session.width - 40
    private var keyboardHeight: CGFloat = 0
    private let scrollView = UIScrollView()
    private let titleTextField = UITextField()
    private let eventTypeTextField = UITextField()
    private let eventTypeRightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    private let dateLabel = UILabel()
    private let startDateLabel = UILabel()
    private let startDateTextField = UITextField()
    private let endDateLabel = UILabel()
    private let endDateTextField = UITextField()
    private let locationTextField = UITextField()
    private let guestLabel = UILabel()
    private let guestCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let repeatLabel = UILabel()
    private let repeatSwitch = ScaleSwitch()//UISwitch()
    private let repeatDateLabel = UILabel()
    private let repeatButton = UIButton()
    private let majorLabel = UILabel()
    private let majorSwitch = ScaleSwitch()
    private let timerImage = UIImageView()
    private let timerTextField = UITextField()
    private let deleteButton = HDButton(title: "Удалить", fontSize: 18)
    private let saveButton = HDButton(title: "Сохранить", fontSize: 18)
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getEvent()
        view.backgroundColor = UIColor.backgroundColor
        eventTypeRightView.backgroundColor = .clear
        widthDateTextField = (Session.width - 40 - (2 * widthDateLabel) - (3 * insetDateLabel)) / 2
        setupHeaderView(color: .tabBarColor,
                        height: headerHeight,
                        presenter: presenter,
                        title: "Новое событие",
                        font: .boldSystemFontOfSize(size: 14))
        setupScrollView()
        setupTitleTextField()
        setupEventTypeTextField()
        setupDateLabel()
        setupStartDateLabel()
        setupStartDateTextField()
        setupEndDateLabel()
        setupEndDateTextField()
        setupLocationTextField()
        setupGuestLabel()
        setupGuestCollectionView()
        setupRepeatLabel()
        setupRepeatSwitch()
        setupRepeatButton()
        setupRepeatDateLabel()
        setupMajorLabel()
        setupMajorSwitch()
        setupTimerImage()
        setupTimerTextField()
        setupDeleteButton()
        setupSaveButton()
        addTapGestureToHideKeyboard()
        addSwipeGestureToBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Public methods
    func reloadCollectionView() {
        guestCollectionView.reloadData()
    }
    
    func setEventType(eventType: String, color: UIColor) {
        eventTypeTextField.text = eventType
        eventTypeRightView.backgroundColor = color
        eventTypeTextField.leftView = setupDefaultLeftView()
    }
    
    func setStartDate(startDate: String) {
        startDateTextField.text = startDate
        startDateTextField.leftView = setupDefaultLeftView()
    }
    
    func setEndDate(endDate: String) {
        endDateTextField.text = endDate
        endDateTextField.leftView = setupDefaultLeftView()
    }
    
    func setRepeatLabel(repeatText: String) {
        repeatDateLabel.text = repeatText
        repeatSwitch.isHidden = true
        repeatButton.isHidden = false
    }
    
    func setNeverRepeat() {
        repeatDateLabel.text = ""
        repeatSwitch.isHidden = false
        repeatButton.isHidden = true
        repeatSwitch.isOn = false
        repeatSwitch.thumbTintColor = offThumbTintColor
    }
    
    func setNotifyTime(notifyTime: String) {
        timerTextField.text = notifyTime
    }
    
    func setEventOnView(event: Event) {
        let headerView = view.viewWithTag(Session.tagHeaderView) as? HeaderView
        headerView?.titleLabel.text = "Редактирование события"
        switch event.eventType {
        case .reception:
            setEventType(eventType: "Приём пациентов", color: .receptionEventColor)
        case .administrative:
            setEventType(eventType: "Административная деятельность", color: .administrativeEventColor)
        case .science:
            setEventType(eventType: "Научная деятельность", color: .scientificEventColor)
        case .other:
            setEventType(eventType: "Другое", color: .anotherEventColor)
        default:
            self.showAlert(message: "Не верный тип события")
        }
        startDateTextField.text = presenter?.convertDate(date: event.startDate) ?? event.startDate
        startDateTextField.leftView = setupDefaultLeftView()
        endDateTextField.text = presenter?.convertDate(date: event.endDate) ?? event.endDate
        endDateTextField.leftView = setupDefaultLeftView()
        titleTextField.text = event.title
        titleTextField.leftView = setupDefaultLeftView()
        locationTextField.text = event.eventPlace
        if event.isMajor ?? false {
            majorSwitch.isOn = true
            majorSwitch.thumbTintColor = UIColor.majorEventColor
        }
        guard let notifyDate = event.notifyDate else { return }
        guard let startDate = event.startDate.toDate(withFormat: "yyyy-MM-dd HH:mm:ss"),
            let notify = notifyDate.toDate(withFormat: "yyyy-MM-dd HH:mm:ss") else { return }
        guard let dateDiff = Calendar.current.dateComponents([.minute],
                                                             from: notify,
                                                             to: startDate).minute else { return }
        timerTextField.text = "Уведомить за \(dateDiff) минут"
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
    
    private func setupTitleTextField() {
        let top = 10.f
        titleTextField.delegate = self
        titleTextField.font = .systemFontOfSize(size: 14)
        titleTextField.textColor = .textFieldTextColor
        titleTextField.placeholder = "Название события"
        titleTextField.textAlignment = .left
        titleTextField.autocorrectionType = .no
        titleTextField.backgroundColor = .white
        titleTextField.layer.cornerRadius = 5
        titleTextField.leftView = setupLeftView()
        titleTextField.leftViewMode = .always
        scrollView.addSubview(titleTextField)
        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.topAnchor.constraint(equalTo: scrollView.topAnchor,
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
        eventTypeTextField.clipsToBounds = true
        let imageView = UIImageView(frame: CGRect(x: 10,
                                                  y: 0,
                                                  width: 12,
                                                  height: heightTextField))
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "calendar")
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 28,
                                        height: heightTextField))
        view.addSubview(imageView)
        eventTypeTextField.leftView = view
        eventTypeTextField.leftViewMode = .always
        eventTypeTextField.rightView = eventTypeRightView
        eventTypeTextField.rightViewMode = .always
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
        let top = 16.f
        dateLabel.font = .boldSystemFontOfSize(size: 14)
        dateLabel.textColor = .white
        dateLabel.text = "Установите дату и время события"
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
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(startDateButtonPressed))
        startDateTextField.font = .systemFontOfSize(size: 14)
        startDateTextField.textColor = .textFieldTextColor
        startDateTextField.textAlignment = .left
        startDateTextField.autocorrectionType = .no
        startDateTextField.backgroundColor = .white
        startDateTextField.layer.cornerRadius = 5
        let imageView = UIImageView(frame: CGRect(x: 10,
                                                  y: 0,
                                                  width: 12,
                                                  height: heightTextField))
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ClockIcon")
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 28,
                                        height: heightTextField))
        view.addSubview(imageView)
        startDateTextField.leftView = view
        startDateTextField.leftViewMode = .always
        startDateTextField.addGestureRecognizer(tap)
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
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(endDateButtonPressed))
        endDateTextField.font = .systemFontOfSize(size: 14)
        endDateTextField.textColor = .textFieldTextColor
        endDateTextField.textAlignment = .left
        endDateTextField.autocorrectionType = .no
        endDateTextField.backgroundColor = .white
        endDateTextField.layer.cornerRadius = 5
        let imageView = UIImageView(frame: CGRect(x: 10,
                                                  y: 0,
                                                  width: 12,
                                                  height: heightTextField))
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ClockIcon")
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 28,
                                        height: heightTextField))
        view.addSubview(imageView)
        endDateTextField.leftView = view
        endDateTextField.leftViewMode = .always
        endDateTextField.addGestureRecognizer(tap)
        scrollView.addSubview(endDateTextField)
        
        endDateTextField.translatesAutoresizingMaskIntoConstraints = false
        endDateTextField.centerYAnchor.constraint(equalTo: startDateLabel.centerYAnchor).isActive = true
        endDateTextField.leadingAnchor.constraint(equalTo: endDateLabel.trailingAnchor,
                                                  constant: insetDateLabel).isActive = true
        endDateTextField.widthAnchor.constraint(equalToConstant: widthDateTextField).isActive = true
        endDateTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    private func setupLocationTextField() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(locationButtonPressed))
        let top = 20.f
        locationTextField.font = .systemFontOfSize(size: 14)
        locationTextField.textColor = .textFieldTextColor
        locationTextField.placeholder = "Место"
        locationTextField.textAlignment = .left
        locationTextField.autocorrectionType = .no
        locationTextField.backgroundColor = .white
        locationTextField.layer.cornerRadius = 5
        let imageView = UIImageView(frame: CGRect(x: 10,
                                                  y: 0,
                                                  width: 12,
                                                  height: heightTextField))
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "LocationMark")
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 28,
                                        height: heightTextField))
        view.addSubview(imageView)
        locationTextField.leftView = view
        locationTextField.leftViewMode = .always
        locationTextField.addGestureRecognizer(tap)
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
    
    private func setupGuestCollectionView() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(guestButtonPressed))
        let top = 7.f
        guestCollectionView.backgroundColor = .white
        guestCollectionView.layer.cornerRadius = 5
        guestCollectionView.register(GuestCell.self, forCellWithReuseIdentifier: "GuestCell")
        guestCollectionView.dataSource = self
        guestCollectionView.delegate = self
        guestCollectionView.addGestureRecognizer(tap)
        scrollView.addSubview(guestCollectionView)
        
        guestCollectionView.translatesAutoresizingMaskIntoConstraints = false
        guestCollectionView.topAnchor.constraint(equalTo: guestLabel.bottomAnchor,
                                                 constant: top).isActive = true
        guestCollectionView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        guestCollectionView.widthAnchor.constraint(equalToConstant: widthTextField).isActive = true
        guestCollectionView.heightAnchor.constraint(equalToConstant: heightCollectionView).isActive = true
    }
    
    private func setupRepeatLabel() {
        let top = 20.f
        let leading = 20.f
        let width = 135.f
        repeatLabel.font = .boldSystemFontOfSize(size: 14)
        repeatLabel.textColor = .white
        repeatLabel.text = "Повторять событие"
        repeatLabel.textAlignment = .left
        repeatLabel.numberOfLines = 1
        scrollView.addSubview(repeatLabel)
        
        repeatLabel.translatesAutoresizingMaskIntoConstraints = false
        repeatLabel.topAnchor.constraint(equalTo: guestCollectionView.bottomAnchor,
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
        scrollView.addSubview(repeatSwitch)
        
        repeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        repeatSwitch.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                               constant: Session.width - 20).isActive = true
        repeatSwitch.centerYAnchor.constraint(equalTo: repeatLabel.centerYAnchor).isActive = true
    }
    
    private func setupRepeatButton() {
        let size = 20.f
        repeatButton.backgroundColor = .hdButtonColor
        repeatButton.layer.cornerRadius = 10
        repeatButton.setImage(UIImage(named: "Edit_Button"), for: .normal)
        repeatButton.imageView?.contentMode = .scaleAspectFill
        repeatButton.contentHorizontalAlignment = .center
        repeatButton.contentVerticalAlignment = .center
        repeatButton.addTarget(self, action: #selector(repeatButtonPressed), for: .touchUpInside)
        repeatButton.isHidden = true
        scrollView.addSubview(repeatButton)
        
        repeatButton.translatesAutoresizingMaskIntoConstraints = false
        repeatButton.centerYAnchor.constraint(equalTo: repeatLabel.centerYAnchor).isActive = true
        repeatButton.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                               constant: Session.width - 20).isActive = true
        repeatButton.widthAnchor.constraint(equalToConstant: size).isActive = true
        repeatButton.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupRepeatDateLabel() {
        let leading = 10.f
        repeatDateLabel.font = .systemFontOfSize(size: 14)
        repeatDateLabel.textColor = .white
        repeatDateLabel.textAlignment = .right
        repeatDateLabel.numberOfLines = 1
        scrollView.addSubview(repeatDateLabel)
        
        repeatDateLabel.translatesAutoresizingMaskIntoConstraints = false
        repeatDateLabel.centerYAnchor.constraint(equalTo: repeatLabel.centerYAnchor).isActive = true
        repeatDateLabel.trailingAnchor.constraint(equalTo: repeatButton.leadingAnchor,
                                                  constant: -leading).isActive = true
        repeatDateLabel.widthAnchor.constraint(equalToConstant: (Session.width / 2) - 50).isActive = true
        repeatDateLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupMajorLabel() {
        let top = 30.f
        let leading = 20.f
        let width = 135.f
        majorLabel.font = .boldSystemFontOfSize(size: 14)
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
        timerImage.image = UIImage(named: "BellIcon")
        scrollView.addSubview(timerImage)
        
        timerImage.translatesAutoresizingMaskIntoConstraints = false
        timerImage.topAnchor.constraint(equalTo: majorLabel.bottomAnchor,
                                        constant: top).isActive = true
        timerImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                            constant: leading).isActive = true
        timerImage.widthAnchor.constraint(equalToConstant: heightTextField).isActive = true
        timerImage.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    private func setupTimerTextField() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(timerButtonPressed))
        let leading = 10.f
        timerTextField.font = .systemFontOfSize(size: 14)
        timerTextField.textColor = .textFieldTextColor
        timerTextField.placeholder = "Уведомить за"
        timerTextField.textAlignment = .left
        timerTextField.autocorrectionType = .no
        timerTextField.backgroundColor = .white
        timerTextField.layer.cornerRadius = 5
        timerTextField.leftView = setupDefaultLeftView()
        timerTextField.leftViewMode = .always
        timerTextField.clipsToBounds = true
        let imageView = UIImageView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: heightTextField,
                                                  height: heightTextField))
        
        imageView.contentMode = .center
        imageView.image = UIImage(named: "CheckMarkE")
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: heightTextField,
                                        height: heightTextField))
        view.backgroundColor = .hdButtonColor
        view.addSubview(imageView)
        timerTextField.rightView = view
        timerTextField.rightViewMode = .always
        
        timerTextField.addGestureRecognizer(tap)
        scrollView.addSubview(timerTextField)
        
        timerTextField.translatesAutoresizingMaskIntoConstraints = false
        timerTextField.leadingAnchor.constraint(equalTo: timerImage.trailingAnchor,
                                                constant: leading).isActive = true
        timerTextField.centerYAnchor.constraint(equalTo: timerImage.centerYAnchor).isActive = true
        timerTextField.widthAnchor.constraint(equalToConstant: Session.width - 80).isActive = true
        timerTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    private func setupDeleteButton() {
        deleteButton.clearBackground()
        deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        scrollView.addSubview(deleteButton)
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.topAnchor.constraint(equalTo: timerImage.bottomAnchor,
                                          constant: 35).isActive = true
        deleteButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                              constant: 20).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: (Session.width - 60) / 2).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func setupSaveButton() {
        saveButton.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
        scrollView.addSubview(saveButton)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: timerImage.bottomAnchor,
                                        constant: 35).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: deleteButton.trailingAnchor,
                                            constant: 20).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: (Session.width - 60) / 2).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func setupLeftView() -> UIView {
        let imageView = UIImageView(frame: CGRect(x: 10,
                                                  y: 0,
                                                  width: 12,
                                                  height: heightTextField))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "TitleIcon")
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 28,
                                        height: heightTextField))
        view.addSubview(imageView)
        return view
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
    
    @objc func hideKeyboard() {
        scrollView.endEditing(true)
        view.viewWithTag(Session.tagSavedView)?.removeFromSuperview()
        view.viewWithTag(Session.tagAlertView)?.removeFromSuperview()
    }
    
    /// Изменение размера ScrollView при появлении клавиатуры
    /// - Parameter notification: событие появления клавиатуры
    @objc func keyboardWasShown​(notification: Notification) {
        guard let info = notification.userInfo else {
            assertionFailure()
            return
        }
        guard let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let kbSize = keyboardFrame.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        keyboardHeight = kbSize.height
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    /// Изменение размера ScrollView при скрытии клавиатуры
    /// - Parameter notification: событие скрытия клавиатуры
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
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
            presenter?.repeatChoice()
        }
    }
    
    // MARK: - Buttons methods
    @objc private func deleteButtonPressed() {
        presenter?.deleteEvent()
    }
    
    @objc private func okButtonPressed() {
        presenter?.saveEvent(isMajor: majorSwitch.isOn,
                             title: titleTextField.text,
                             location: locationTextField.text)
    }
    
    @objc private func eventTypeButtonPressed() {
        presenter?.eventTypeChoice()
    }
    
    @objc private func startDateButtonPressed() {
        presenter?.dateChoice(isStart: true)
    }
    
    @objc private func endDateButtonPressed() {
        presenter?.dateChoice(isStart: false)
    }
    
    @objc private func locationButtonPressed() {
        presenter?.toMap()
    }
    
    @objc private func guestButtonPressed() {
        presenter?.toAddGuests()
    }
    
    @objc private func repeatButtonPressed() {
        presenter?.repeatChoice()
    }
    
    @objc private func timerButtonPressed() {
        presenter?.notifyChoice()
    }
    
    @objc func switchStateDidChange(_ sender: UISwitch) {
        if sender == majorSwitch {
            sender.thumbTintColor = sender.isOn ? UIColor.majorEventColor : offThumbTintColor
        } else {
            sender.thumbTintColor = sender.isOn ? onThumbTintColor : offThumbTintColor
            handleSwitchOn(sender)
            repeatDateLabel.text = ""
        }
    }
    
    /// Переход на предыдущий экран
    @objc private func backButtonPressed() {
        presenter?.back()
    }
    
}

// MARK: - MapKitSearchDelegate
extension AddEventViewController: MapKitSearchDelegate {
    func mapKitSearch(_ locationSearchViewController: LocationSearchViewController, mapItem: MKMapItem) {
        locationTextField.text = mapItem.name
        locationTextField.leftView = setupDefaultLeftView()
    }
}

// MARK: - UITextFieldDelegate
extension AddEventViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == titleTextField {
            titleTextField.leftView = setupDefaultLeftView()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == titleTextField {
            if titleTextField.text?.count == 0 {
                titleTextField.leftView = setupLeftView()
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension AddEventViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        presenter?.addInterest(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //        presenter?.deleteInterest(index: indexPath.item)
    }
}

// MARK: - UICollectionViewDataSource
extension AddEventViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getCountContacts() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GuestCell",
                                                            for: indexPath) as? GuestCell else {
                                                                return UICollectionViewCell()
        }
        cell.configure(contact: (presenter?.getContact(index: indexPath.item)))
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AddEventViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((widthTextField - 40) / 2), height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
