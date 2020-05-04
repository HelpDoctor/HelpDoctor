//
//  PushAndSoundViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.04.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class PushAndSoundViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: PushAndSoundPresenterProtocol?
    
    // MARK: - Constants and variables
    private let headerHeight = 40.f
    private let rowHeight = 40.f
    private let borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
    private let onThumbTintColor = UIColor.hdButtonColor
    private let offThumbTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    private let topStackView = UIView()
    private let headerIcon = UIImageView()
    private let headerLabel = UILabel()
    private let pushView = UIView()
    private let allowLabel = UILabel()
    private let pushSwitch = UISwitch()
    private let messagesView = UIView()
    private let messagesLabel = UILabel()
    private let messagesCheckbox = CheckBox(type: .square)
    private let contactsView = UIView()
    private let contactsLabel = UILabel()
    private let contactsCheckbox = CheckBox(type: .square)
    private let eventsView = UIView()
    private let eventsLabel = UILabel()
    private let eventsCheckbox = CheckBox(type: .square)
    private let chatView = UIView()
    private let chatLabel = UILabel()
    private let chatSwitch = UISwitch()
    private let blockedUserView = UIView()
    private let blockedUserLabel = UILabel()
    private let bottomStackView = UIView()
    private let bottomHeaderIcon = UIImageView()
    private let bottomHeaderLabel = UILabel()
    private let vibrationView = UIView()
    private let vibrationLabel = UILabel()
    private let vibrationValueLabel = UILabel()
    private let ringtoneView = UIView()
    private let ringtoneLabel = UILabel()
    private let ringtoneValueLabel = UILabel()
    private let chatSoundView = UIView()
    private let chatSoundLabel = UILabel()
    private let chatSoundSwitch = UISwitch()
    private let counterView = UIView()
    private let counterLabel = UILabel()
    private let counterSwitch = UISwitch()
    private let maskView = UIView()
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupHeaderView(color: .tabBarColor,
                        height: headerHeight,
                        presenter: presenter,
                        title: "Настройки",
                        font: .boldSystemFontOfSize(size: 14))
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
        presenter?.setSettingsOnView()
    }
    
    // MARK: - Public methods
    func setValueOnSwitch(_ value: Bool) {
        pushSwitch.isOn = value
        pushSwitch.thumbTintColor = pushSwitch.isOn ? onThumbTintColor : offThumbTintColor
    }
    
    func setMessagesCheckbox(_ value: Bool) {
        messagesCheckbox.isSelected = value
    }
    
    func setContactsCheckbox(_ value: Bool) {
        contactsCheckbox.isSelected = value
    }
    
    // MARK: - Setup views
    private func setupViews() {
        setupTopStackView()
        setupHeaderIcon()
        setupHeaderLabel()
        setupPushView()
        setupAllowLabel()
        setupPushSwitch()
        setupMessagesView()
        setupMessagesLabel()
        setupMessagesCheckbox()
        setupContactsView()
        setupContactsLabel()
        setupContactsCheckbox()
        setupEventsView()
        setupEventsLabel()
        setupEventsCheckbox()
        setupChatView()
        setupChatLabel()
        setupChatSwitch()
        setupBlockedUserView()
        setupBlockedUserLabel()
        setupBottomStackView()
        setupBottomHeaderIcon()
        setupBottomHeaderLabel()
        setupVibrationView()
        setupVibrationLabel()
        setupVibrationValueLabel()
        setupRingtoneView()
        setupRingtoneLabel()
        setupRingtoneValueLabel()
        setupChatSoundView()
        setupChatSoundLabel()
        setupChatSoundSwitch()
        setupCounterView()
        setupCounterLabel()
        setupCounterSwitch()
        setupMaskView()
    }
    
    private func setupTopStackView() {
        topStackView.backgroundColor = .searchBarTintColor
        view.addSubview(topStackView)
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                          constant: headerHeight).isActive = true
        topStackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topStackView.heightAnchor.constraint(equalToConstant: rowHeight).isActive = true
    }
    
    private func setupHeaderIcon() {
        let width = 30.f
        let leading = 20.f
        headerIcon.image = UIImage(named: "notificationSettings")
        topStackView.addSubview(headerIcon)
        
        headerIcon.translatesAutoresizingMaskIntoConstraints = false
        headerIcon.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor,
                                            constant: leading).isActive = true
        headerIcon.widthAnchor.constraint(equalToConstant: width).isActive = true
        headerIcon.centerYAnchor.constraint(equalTo: topStackView.centerYAnchor).isActive = true
        headerIcon.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupHeaderLabel() {
        let leading = 20.f
        headerLabel.numberOfLines = 1
        headerLabel.textAlignment = .left
        headerLabel.font = .boldSystemFontOfSize(size: 14)
        headerLabel.textColor = .white
        headerLabel.text = "Настройки уведомлений"
        topStackView.addSubview(headerLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.leadingAnchor.constraint(equalTo: headerIcon.trailingAnchor,
                                             constant: leading).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor,
                                              constant: -leading).isActive = true
        headerLabel.centerYAnchor.constraint(equalTo: topStackView.centerYAnchor).isActive = true
        headerLabel.heightAnchor.constraint(equalTo: topStackView.heightAnchor).isActive = true
    }
    
    private func setupPushView() {
        pushView.addViewBackedBorder(side: .bottom, thickness: 1, color: borderColor)
        view.addSubview(pushView)
        
        pushView.translatesAutoresizingMaskIntoConstraints = false
        pushView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pushView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pushView.topAnchor.constraint(equalTo: topStackView.bottomAnchor).isActive = true
        pushView.heightAnchor.constraint(equalToConstant: rowHeight).isActive = true
    }
    
    private func setupAllowLabel() {
        let leading = 10.f
        let width = 230.f
        allowLabel.numberOfLines = 1
        allowLabel.textAlignment = .left
        allowLabel.font = .mediumSystemFontOfSize(size: 14)
        allowLabel.textColor = .white
        allowLabel.text = "Разрешить push-уведомления"
        pushView.addSubview(allowLabel)
        
        allowLabel.translatesAutoresizingMaskIntoConstraints = false
        allowLabel.leadingAnchor.constraint(equalTo: pushView.leadingAnchor,
                                            constant: leading).isActive = true
        allowLabel.centerYAnchor.constraint(equalTo: pushView.centerYAnchor).isActive = true
        allowLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupPushSwitch() {
        let leading = 75.f
        pushSwitch.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
        pushSwitch.setOn(false, animated: true)
        pushSwitch.thumbTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        pushSwitch.onTintColor = .white
        pushSwitch.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        pushView.addSubview(pushSwitch)
        
        pushSwitch.translatesAutoresizingMaskIntoConstraints = false
        pushSwitch.leadingAnchor.constraint(equalTo: pushView.trailingAnchor,
                                            constant: -leading).isActive = true
        pushSwitch.centerYAnchor.constraint(equalTo: pushView.centerYAnchor).isActive = true
    }
    
    private func setupMessagesView() {
        messagesView.addViewBackedBorder(side: .bottom, thickness: 1, color: borderColor)
        view.addSubview(messagesView)
        
        messagesView.translatesAutoresizingMaskIntoConstraints = false
        messagesView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        messagesView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        messagesView.topAnchor.constraint(equalTo: pushView.bottomAnchor).isActive = true
        messagesView.heightAnchor.constraint(equalToConstant: rowHeight).isActive = true
    }
    
    private func setupMessagesLabel() {
        let leading = 20.f
        let width = 220.f
        messagesLabel.numberOfLines = 1
        messagesLabel.textAlignment = .left
        messagesLabel.font = .systemFontOfSize(size: 14)
        messagesLabel.textColor = .white
        messagesLabel.text = "Новые сообщения"
        messagesView.addSubview(messagesLabel)
        
        messagesLabel.translatesAutoresizingMaskIntoConstraints = false
        messagesLabel.leadingAnchor.constraint(equalTo: messagesView.leadingAnchor,
                                               constant: leading).isActive = true
        messagesLabel.centerYAnchor.constraint(equalTo: messagesView.centerYAnchor).isActive = true
        messagesLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupMessagesCheckbox() {
        let leading = 75.f
        let height = 20.f
        messagesCheckbox.contentHorizontalAlignment = .center
        messagesCheckbox.contentVerticalAlignment = .center
        messagesCheckbox.addTarget(self, action: #selector(messagesCheckboxPressed), for: .touchUpInside)
        messagesView.addSubview(messagesCheckbox)
        
        messagesCheckbox.translatesAutoresizingMaskIntoConstraints = false
        messagesCheckbox.centerYAnchor.constraint(equalTo: messagesView.centerYAnchor).isActive = true
        messagesCheckbox.leadingAnchor.constraint(equalTo: view.trailingAnchor,
                                                  constant: -leading).isActive = true
        messagesCheckbox.widthAnchor.constraint(equalToConstant: height).isActive = true
        messagesCheckbox.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupContactsView() {
        contactsView.addViewBackedBorder(side: .bottom, thickness: 1, color: borderColor)
        view.addSubview(contactsView)
        
        contactsView.translatesAutoresizingMaskIntoConstraints = false
        contactsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contactsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contactsView.topAnchor.constraint(equalTo: messagesView.bottomAnchor).isActive = true
        contactsView.heightAnchor.constraint(equalToConstant: rowHeight).isActive = true
    }
    
    private func setupContactsLabel() {
        let leading = 20.f
        let width = 220.f
        contactsLabel.numberOfLines = 1
        contactsLabel.textAlignment = .left
        contactsLabel.font = .systemFontOfSize(size: 14)
        contactsLabel.textColor = .white
        contactsLabel.text = "Новые запросы в контакты"
        contactsView.addSubview(contactsLabel)
        
        contactsLabel.translatesAutoresizingMaskIntoConstraints = false
        contactsLabel.leadingAnchor.constraint(equalTo: contactsView.leadingAnchor,
                                               constant: leading).isActive = true
        contactsLabel.centerYAnchor.constraint(equalTo: contactsView.centerYAnchor).isActive = true
        contactsLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupContactsCheckbox() {
        let leading = 75.f
        let height = 20.f
        contactsCheckbox.contentHorizontalAlignment = .center
        contactsCheckbox.contentVerticalAlignment = .center
        contactsCheckbox.addTarget(self, action: #selector(contactsCheckboxPressed), for: .touchUpInside)
        contactsView.addSubview(contactsCheckbox)
        
        contactsCheckbox.translatesAutoresizingMaskIntoConstraints = false
        contactsCheckbox.centerYAnchor.constraint(equalTo: contactsView.centerYAnchor).isActive = true
        contactsCheckbox.leadingAnchor.constraint(equalTo: view.trailingAnchor,
                                                  constant: -leading).isActive = true
        contactsCheckbox.widthAnchor.constraint(equalToConstant: height).isActive = true
        contactsCheckbox.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupEventsView() {
        eventsView.addViewBackedBorder(side: .bottom, thickness: 1, color: borderColor)
        view.addSubview(eventsView)
        
        eventsView.translatesAutoresizingMaskIntoConstraints = false
        eventsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        eventsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        eventsView.topAnchor.constraint(equalTo: contactsView.bottomAnchor).isActive = true
        eventsView.heightAnchor.constraint(equalToConstant: rowHeight).isActive = true
    }
    
    private func setupEventsLabel() {
        let leading = 20.f
        let width = 220.f
        eventsLabel.numberOfLines = 1
        eventsLabel.textAlignment = .left
        eventsLabel.font = .systemFontOfSize(size: 14)
        eventsLabel.textColor = .white
        eventsLabel.text = "Уведомления о событиях"
        eventsView.addSubview(eventsLabel)
        
        eventsLabel.translatesAutoresizingMaskIntoConstraints = false
        eventsLabel.leadingAnchor.constraint(equalTo: eventsView.leadingAnchor,
                                             constant: leading).isActive = true
        eventsLabel.centerYAnchor.constraint(equalTo: eventsView.centerYAnchor).isActive = true
        eventsLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupEventsCheckbox() {
        let leading = 75.f
        let height = 20.f
        eventsCheckbox.contentHorizontalAlignment = .center
        eventsCheckbox.contentVerticalAlignment = .center
        eventsCheckbox.addTarget(self, action: #selector(eventsCheckboxPressed), for: .touchUpInside)
        eventsView.addSubview(eventsCheckbox)
        
        eventsCheckbox.translatesAutoresizingMaskIntoConstraints = false
        eventsCheckbox.centerYAnchor.constraint(equalTo: eventsView.centerYAnchor).isActive = true
        eventsCheckbox.leadingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -leading).isActive = true
        eventsCheckbox.widthAnchor.constraint(equalToConstant: height).isActive = true
        eventsCheckbox.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupChatView() {
        chatView.addViewBackedBorder(side: .bottom, thickness: 1, color: borderColor)
        view.addSubview(chatView)
        
        chatView.translatesAutoresizingMaskIntoConstraints = false
        chatView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        chatView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        chatView.topAnchor.constraint(equalTo: eventsView.bottomAnchor).isActive = true
        chatView.heightAnchor.constraint(equalToConstant: rowHeight).isActive = true
    }
    
    private func setupChatLabel() {
        let leading = 10.f
        let width = 230.f
        chatLabel.numberOfLines = 1
        chatLabel.textAlignment = .left
        chatLabel.font = .mediumSystemFontOfSize(size: 14)
        chatLabel.textColor = .white
        chatLabel.text = "Разрешить уведомления из чатов"
        chatView.addSubview(chatLabel)
        
        chatLabel.translatesAutoresizingMaskIntoConstraints = false
        chatLabel.leadingAnchor.constraint(equalTo: chatView.leadingAnchor,
                                           constant: leading).isActive = true
        chatLabel.centerYAnchor.constraint(equalTo: chatView.centerYAnchor).isActive = true
        chatLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupChatSwitch() {
        let leading = 75.f
        chatSwitch.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
        chatSwitch.setOn(false, animated: true)
        chatSwitch.thumbTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        chatSwitch.onTintColor = .white
        chatSwitch.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        chatView.addSubview(chatSwitch)
        
        chatSwitch.translatesAutoresizingMaskIntoConstraints = false
        chatSwitch.leadingAnchor.constraint(equalTo: chatView.trailingAnchor,
                                            constant: -leading).isActive = true
        chatSwitch.centerYAnchor.constraint(equalTo: chatView.centerYAnchor).isActive = true
    }
    
    private func setupBlockedUserView() {
        // TODO: - добавить действие
        blockedUserView.addViewBackedBorder(side: .bottom, thickness: 1, color: borderColor)
        view.addSubview(blockedUserView)
        
        blockedUserView.translatesAutoresizingMaskIntoConstraints = false
        blockedUserView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        blockedUserView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        blockedUserView.topAnchor.constraint(equalTo: chatView.bottomAnchor).isActive = true
        blockedUserView.heightAnchor.constraint(equalToConstant: rowHeight).isActive = true
    }
    
    private func setupBlockedUserLabel() {
        let leading = 10.f
        blockedUserLabel.numberOfLines = 1
        blockedUserLabel.textAlignment = .left
        blockedUserLabel.font = .mediumSystemFontOfSize(size: 14)
        blockedUserLabel.textColor = .white
        blockedUserLabel.text = "Список заблокированных пользователей"
        blockedUserView.addSubview(blockedUserLabel)
        
        blockedUserLabel.translatesAutoresizingMaskIntoConstraints = false
        blockedUserLabel.leadingAnchor.constraint(equalTo: blockedUserView.leadingAnchor,
                                                  constant: leading).isActive = true
        blockedUserLabel.centerYAnchor.constraint(equalTo: blockedUserView.centerYAnchor).isActive = true
        blockedUserLabel.widthAnchor.constraint(equalToConstant: Session.width - 2 * leading).isActive = true
    }
    
    private func setupBottomStackView() {
        bottomStackView.backgroundColor = .searchBarTintColor
        view.addSubview(bottomStackView)
        
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomStackView.topAnchor.constraint(equalTo: blockedUserView.bottomAnchor).isActive = true
        bottomStackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        bottomStackView.heightAnchor.constraint(equalToConstant: rowHeight).isActive = true
    }
    
    private func setupBottomHeaderIcon() {
        let width = 30.f
        let leading = 20.f
        bottomHeaderIcon.image = UIImage(named: "sound")
        bottomStackView.addSubview(bottomHeaderIcon)
        
        bottomHeaderIcon.translatesAutoresizingMaskIntoConstraints = false
        bottomHeaderIcon.leadingAnchor.constraint(equalTo: bottomStackView.leadingAnchor,
                                                  constant: leading).isActive = true
        bottomHeaderIcon.widthAnchor.constraint(equalToConstant: width).isActive = true
        bottomHeaderIcon.centerYAnchor.constraint(equalTo: bottomStackView.centerYAnchor).isActive = true
        bottomHeaderIcon.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupBottomHeaderLabel() {
        let leading = 20.f
        bottomHeaderLabel.numberOfLines = 1
        bottomHeaderLabel.textAlignment = .left
        bottomHeaderLabel.font = .boldSystemFontOfSize(size: 14)
        bottomHeaderLabel.textColor = .white
        bottomHeaderLabel.text = "Звук уведомлений"
        bottomStackView.addSubview(bottomHeaderLabel)
        
        bottomHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomHeaderLabel.leadingAnchor.constraint(equalTo: bottomHeaderIcon.trailingAnchor,
                                                   constant: leading).isActive = true
        bottomHeaderLabel.trailingAnchor.constraint(equalTo: bottomStackView.trailingAnchor,
                                                    constant: -leading).isActive = true
        bottomHeaderLabel.centerYAnchor.constraint(equalTo: bottomStackView.centerYAnchor).isActive = true
        bottomHeaderLabel.heightAnchor.constraint(equalTo: bottomStackView.heightAnchor).isActive = true
    }
    
    private func setupVibrationView() {
        vibrationView.addViewBackedBorder(side: .bottom, thickness: 1, color: borderColor)
        view.addSubview(vibrationView)
        
        vibrationView.translatesAutoresizingMaskIntoConstraints = false
        vibrationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        vibrationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        vibrationView.topAnchor.constraint(equalTo: bottomStackView.bottomAnchor).isActive = true
        vibrationView.heightAnchor.constraint(equalToConstant: rowHeight).isActive = true
    }
    
    private func setupVibrationLabel() {
        let leading = 10.f
        let width = 230.f
        vibrationLabel.numberOfLines = 1
        vibrationLabel.textAlignment = .left
        vibrationLabel.font = .mediumSystemFontOfSize(size: 14)
        vibrationLabel.textColor = .white
        vibrationLabel.text = "Вибросигнал"
        vibrationView.addSubview(vibrationLabel)
        
        vibrationLabel.translatesAutoresizingMaskIntoConstraints = false
        vibrationLabel.leadingAnchor.constraint(equalTo: vibrationView.leadingAnchor,
                                                constant: leading).isActive = true
        vibrationLabel.centerYAnchor.constraint(equalTo: vibrationView.centerYAnchor).isActive = true
        vibrationLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupVibrationValueLabel() {
        let trailing = 10.f
        let width = 100.f
        // TODO: - добавить действие
        vibrationValueLabel.numberOfLines = 1
        vibrationValueLabel.textAlignment = .left
        vibrationValueLabel.font = .mediumSystemFontOfSize(size: 14)
        vibrationValueLabel.textColor = .white
        vibrationValueLabel.text = "По умолчанию"
        vibrationView.addSubview(vibrationValueLabel)
        
        vibrationValueLabel.translatesAutoresizingMaskIntoConstraints = false
        vibrationValueLabel.trailingAnchor.constraint(equalTo: vibrationView.trailingAnchor,
                                                      constant: -trailing).isActive = true
        vibrationValueLabel.centerYAnchor.constraint(equalTo: vibrationView.centerYAnchor).isActive = true
        vibrationValueLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupRingtoneView() {
        ringtoneView.addViewBackedBorder(side: .bottom, thickness: 1, color: borderColor)
        view.addSubview(ringtoneView)
        
        ringtoneView.translatesAutoresizingMaskIntoConstraints = false
        ringtoneView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        ringtoneView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        ringtoneView.topAnchor.constraint(equalTo: vibrationView.bottomAnchor).isActive = true
        ringtoneView.heightAnchor.constraint(equalToConstant: rowHeight).isActive = true
    }
    
    private func setupRingtoneLabel() {
        let leading = 10.f
        let width = 230.f
        ringtoneLabel.numberOfLines = 1
        ringtoneLabel.textAlignment = .left
        ringtoneLabel.font = .mediumSystemFontOfSize(size: 14)
        ringtoneLabel.textColor = .white
        ringtoneLabel.text = "Рингтон"
        ringtoneView.addSubview(ringtoneLabel)
        
        ringtoneLabel.translatesAutoresizingMaskIntoConstraints = false
        ringtoneLabel.leadingAnchor.constraint(equalTo: ringtoneView.leadingAnchor,
                                               constant: leading).isActive = true
        ringtoneLabel.centerYAnchor.constraint(equalTo: ringtoneView.centerYAnchor).isActive = true
        ringtoneLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupRingtoneValueLabel() {
        let trailing = 10.f
        let width = 100.f
        // TODO: - добавить действие
        ringtoneValueLabel.numberOfLines = 1
        ringtoneValueLabel.textAlignment = .left
        ringtoneValueLabel.font = .mediumSystemFontOfSize(size: 14)
        ringtoneValueLabel.textColor = .white
        ringtoneValueLabel.text = "По умолчанию"
        ringtoneView.addSubview(ringtoneValueLabel)
        
        ringtoneValueLabel.translatesAutoresizingMaskIntoConstraints = false
        ringtoneValueLabel.trailingAnchor.constraint(equalTo: ringtoneView.trailingAnchor,
                                                     constant: -trailing).isActive = true
        ringtoneValueLabel.centerYAnchor.constraint(equalTo: ringtoneView.centerYAnchor).isActive = true
        ringtoneValueLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupChatSoundView() {
        chatSoundView.addViewBackedBorder(side: .bottom, thickness: 1, color: borderColor)
        view.addSubview(chatSoundView)
        
        chatSoundView.translatesAutoresizingMaskIntoConstraints = false
        chatSoundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        chatSoundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        chatSoundView.topAnchor.constraint(equalTo: ringtoneView.bottomAnchor).isActive = true
        chatSoundView.heightAnchor.constraint(equalToConstant: rowHeight).isActive = true
    }
    
    private func setupChatSoundLabel() {
        let leading = 10.f
        let width = 230.f
        chatSoundLabel.numberOfLines = 1
        chatSoundLabel.textAlignment = .left
        chatSoundLabel.font = .mediumSystemFontOfSize(size: 14)
        chatSoundLabel.textColor = .white
        chatSoundLabel.text = "Звук в чате"
        chatSoundView.addSubview(chatSoundLabel)
        
        chatSoundLabel.translatesAutoresizingMaskIntoConstraints = false
        chatSoundLabel.leadingAnchor.constraint(equalTo: chatSoundView.leadingAnchor,
                                                constant: leading).isActive = true
        chatSoundLabel.centerYAnchor.constraint(equalTo: chatSoundView.centerYAnchor).isActive = true
        chatSoundLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupChatSoundSwitch() {
        let leading = 75.f
        chatSoundSwitch.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
        chatSoundSwitch.setOn(false, animated: true)
        chatSoundSwitch.thumbTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        chatSoundSwitch.onTintColor = .white
        chatSoundSwitch.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        chatSoundView.addSubview(chatSoundSwitch)
        
        chatSoundSwitch.translatesAutoresizingMaskIntoConstraints = false
        chatSoundSwitch.leadingAnchor.constraint(equalTo: chatSoundView.trailingAnchor,
                                                 constant: -leading).isActive = true
        chatSoundSwitch.centerYAnchor.constraint(equalTo: chatSoundView.centerYAnchor).isActive = true
    }
    
    private func setupCounterView() {
        counterView.addViewBackedBorder(side: .bottom, thickness: 1, color: borderColor)
        view.addSubview(counterView)
        
        counterView.translatesAutoresizingMaskIntoConstraints = false
        counterView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        counterView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        counterView.topAnchor.constraint(equalTo: chatSoundView.bottomAnchor).isActive = true
        counterView.heightAnchor.constraint(equalToConstant: rowHeight).isActive = true
    }
    
    private func setupCounterLabel() {
        let leading = 10.f
        let width = 230.f
        counterLabel.numberOfLines = 1
        counterLabel.textAlignment = .left
        counterLabel.font = .mediumSystemFontOfSize(size: 14)
        counterLabel.textColor = .white
        counterLabel.text = "Счетчик сообщений"
        counterView.addSubview(counterLabel)
        
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        counterLabel.leadingAnchor.constraint(equalTo: counterView.leadingAnchor,
                                              constant: leading).isActive = true
        counterLabel.centerYAnchor.constraint(equalTo: counterView.centerYAnchor).isActive = true
        counterLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupCounterSwitch() {
        let leading = 75.f
        counterSwitch.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
        counterSwitch.setOn(false, animated: true)
        counterSwitch.thumbTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        counterSwitch.onTintColor = .white
        counterSwitch.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        counterView.addSubview(counterSwitch)
        
        counterSwitch.translatesAutoresizingMaskIntoConstraints = false
        counterSwitch.leadingAnchor.constraint(equalTo: counterView.trailingAnchor,
                                               constant: -leading).isActive = true
        counterSwitch.centerYAnchor.constraint(equalTo: counterView.centerYAnchor).isActive = true
    }
    
    private func setupMaskView() {
        maskView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        view.addSubview(maskView)
        
        maskView.translatesAutoresizingMaskIntoConstraints = false
        maskView.topAnchor.constraint(equalTo: bottomStackView.topAnchor).isActive = true
        maskView.bottomAnchor.constraint(equalTo: counterView.bottomAnchor).isActive = true
        maskView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        maskView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    
    @objc func switchStateDidChange(_ sender: UISwitch) {
        sender.thumbTintColor = sender.isOn ? onThumbTintColor : offThumbTintColor
        
        if sender == pushSwitch {
            presenter?.updateSettings("push_notification", sender.isOn ? 1 : 0)
        }
    }
    
    @objc private func messagesCheckboxPressed() {
        messagesCheckbox.isSelected = !messagesCheckbox.isSelected
        presenter?.updateSettings("message_friend", messagesCheckbox.isSelected ? 1 : 0)
    }
    
    @objc private func contactsCheckboxPressed() {
        contactsCheckbox.isSelected = !contactsCheckbox.isSelected
        presenter?.updateSettings("add_friend", contactsCheckbox.isSelected ? 1 : 0)
    }
    
    @objc private func eventsCheckboxPressed() {
        eventsCheckbox.isSelected = !eventsCheckbox.isSelected
    }
    
}
