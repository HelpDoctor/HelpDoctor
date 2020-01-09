//
//  StartSettingsViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 30.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class StartSettingsViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: StartSettingsPresenterProtocol?
    
    // MARK: - Constants
    private let scheduleButton = TileButton(title: "Расписание", icon: "Schedule.pdf")
    private let contactsButton = TileButton(title: "Контакты", icon: "Contacts.pdf")
    private let emptyButton = TileButton(title: "Удалить", icon: "Trash Icon.pdf")
    private let messageButton = TileButton(title: "Сообщения", icon: "Message.pdf")
    private let findButton = TileButton(title: "Поиск коллег", icon: "Search.pdf")
    private let newsButton = TileButton(title: "Новости", icon: "News.pdf")
    private let profileButton = TileButton(title: "Профиль", icon: "Profile.pdf")
    private let settingsButton = TileButton(title: "Настройки", icon: "SettingsButton.pdf")
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    private var xInset: CGFloat = 0
    private var yInset: CGFloat = 0
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        xInset = (width - 200) / 3
        yInset = (height - 480 - (self.tabBarController?.tabBar.frame.height ?? 0)) / 5
        setupBackground()
        setupClearHeaderView()
        setupScheduleButton()
        setupContactsButton()
        setupEmptyButton()
        setupMessageButton()
        setupFindButton()
        setupNewsButton()
        setupProfileButton()
        setupSettingsButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.statusBarBackgroundColor = .clear
    }
    
    private func setupScheduleButton() {
        view.addSubview(scheduleButton)
        
        scheduleButton.translatesAutoresizingMaskIntoConstraints = false
        scheduleButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: yInset + 60).isActive = true
        scheduleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: xInset).isActive = true
        scheduleButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        scheduleButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupContactsButton() {
        view.addSubview(contactsButton)
        
        contactsButton.translatesAutoresizingMaskIntoConstraints = false
        contactsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: yInset + 60).isActive = true
        contactsButton.leadingAnchor.constraint(equalTo: scheduleButton.trailingAnchor,
                                                constant: xInset).isActive = true
        contactsButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        contactsButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupEmptyButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(deleteButtonPressed))
        emptyButton.addGestureRecognizer(tap)
        emptyButton.backgroundColor = .red
        view.addSubview(emptyButton)
        
        emptyButton.translatesAutoresizingMaskIntoConstraints = false
        emptyButton.topAnchor.constraint(equalTo: scheduleButton.bottomAnchor,
                                         constant: yInset).isActive = true
        emptyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: xInset).isActive = true
        emptyButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        emptyButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupMessageButton() {
        view.addSubview(messageButton)
        
        messageButton.translatesAutoresizingMaskIntoConstraints = false
        messageButton.topAnchor.constraint(equalTo: contactsButton.bottomAnchor, constant: yInset).isActive = true
        messageButton.leadingAnchor.constraint(equalTo: emptyButton.trailingAnchor,
                                                constant: xInset).isActive = true
        messageButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        messageButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupFindButton() {
        view.addSubview(findButton)
        
        findButton.translatesAutoresizingMaskIntoConstraints = false
        findButton.topAnchor.constraint(equalTo: emptyButton.bottomAnchor,
                                         constant: yInset).isActive = true
        findButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: xInset).isActive = true
        findButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        findButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupNewsButton() {
        view.addSubview(newsButton)
        
        newsButton.translatesAutoresizingMaskIntoConstraints = false
        newsButton.topAnchor.constraint(equalTo: messageButton.bottomAnchor, constant: yInset).isActive = true
        newsButton.leadingAnchor.constraint(equalTo: findButton.trailingAnchor,
                                                constant: xInset).isActive = true
        newsButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        newsButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupProfileButton() {
        view.addSubview(profileButton)
        
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        profileButton.topAnchor.constraint(equalTo: findButton.bottomAnchor,
                                         constant: yInset).isActive = true
        profileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: xInset).isActive = true
        profileButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupSettingsButton() {
        view.addSubview(settingsButton)
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.topAnchor.constraint(equalTo: newsButton.bottomAnchor, constant: yInset).isActive = true
        settingsButton.leadingAnchor.constraint(equalTo: profileButton.trailingAnchor,
                                                constant: xInset).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    @objc private func logouButtonPressed() {
        let logout = Registration(email: nil, password: nil, token: myToken)
        print("tapped")

        getData(typeOfContent: .logout,
                returning: (Int?, String?).self,
                requestParams: logout.requestParams)
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            logout.responce = result

            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    print("result=\(String(describing: logout.responce))")
                    guard let code = logout.responce?.0 else { return }
                    if responceCode(code: code) {
                        print("Logout")
                    } else {
                        self?.showAlert(message: logout.responce?.1)
                    }
                }
            }
        }
    }
    
    @objc private func deleteButtonPressed() {
        let unRegistration = Registration(email: nil, password: nil, token: nil)
        getData(typeOfContent: .deleteMail,
                returning: (Int?, String?).self,
                requestParams: [:])
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            unRegistration.responce = result

            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self] in
                    print("result= \(String(describing: unRegistration.responce))")
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
