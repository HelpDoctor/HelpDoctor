//
//  StartMainViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 30.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class StartMainViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: StartMainPresenterProtocol?
    
    // MARK: - Constants
    private let headerHeight = 60.f
    private let contactsButton = HDButton(title: "Контакты", fontSize: 14)
    private let findUsers = HDButton(title: "Поиск коллег", fontSize: 14)
    private let fillProfileButton = HDButton(title: "Заполнить профиль", fontSize: 14)
    private let profileButton = HDButton(title: "Профиль", fontSize: 14)
    private let searchButton = HDButton(title: "Поиск коллег", fontSize: 14)
    private let deleteProfileButton = HDButton(title: "Удалить профиль", fontSize: 14)
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupHeaderView(color: .backgroundColor, height: headerHeight, presenter: presenter)
        setupContactsButton()
        setupFindUsersButton()
        setupFillProfileButton()
        setupProfileButton()
        setupSearchButton()
        setupDeleteProfileButton()
        presenter?.profileCheck()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .backgroundColor)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Public methods
    func hideFillProfileButton() {
        fillProfileButton.isHidden = true
    }
    
    func showFillProfileButton() {
        fillProfileButton.isHidden = false
    }
    
    // MARK: - Setup views
    private func setupContactsButton() {
        contactsButton.addTarget(self, action: #selector(contactsButtonPressed), for: .touchUpInside)
        contactsButton.isEnabled = true
        view.addSubview(contactsButton)
        
        contactsButton.translatesAutoresizingMaskIntoConstraints = false
        contactsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: headerHeight + 10).isActive = true
        contactsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contactsButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        contactsButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupFindUsersButton() {
        findUsers.addTarget(self, action: #selector(findUsersButtonPressed), for: .touchUpInside)
        findUsers.isEnabled = true
        view.addSubview(findUsers)
        
        findUsers.translatesAutoresizingMaskIntoConstraints = false
        findUsers.topAnchor.constraint(equalTo: contactsButton.bottomAnchor, constant: 10).isActive = true
        findUsers.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        findUsers.widthAnchor.constraint(equalToConstant: 150).isActive = true
        findUsers.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupFillProfileButton() {
        fillProfileButton.addTarget(self, action: #selector(fillProfileButtonPressed), for: .touchUpInside)
        fillProfileButton.isEnabled = true
        fillProfileButton.isHidden = true
        view.addSubview(fillProfileButton)
        
        fillProfileButton.translatesAutoresizingMaskIntoConstraints = false
        fillProfileButton.topAnchor.constraint(equalTo: findUsers.bottomAnchor, constant: 10).isActive = true
        fillProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fillProfileButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        fillProfileButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupProfileButton() {
        profileButton.addTarget(self, action: #selector(profileButtonPressed), for: .touchUpInside)
        profileButton.isEnabled = true
        view.addSubview(profileButton)
        
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        profileButton.topAnchor.constraint(equalTo: fillProfileButton.bottomAnchor, constant: 10).isActive = true
        profileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupSearchButton() {
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        searchButton.isEnabled = true
        view.addSubview(searchButton)
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 10).isActive = true
        searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupDeleteProfileButton() {
        deleteProfileButton.addTarget(self, action: #selector(deleteProfileButtonPressed), for: .touchUpInside)
        deleteProfileButton.isEnabled = true
        deleteProfileButton.backgroundColor = .red
        view.addSubview(deleteProfileButton)
        
        deleteProfileButton.translatesAutoresizingMaskIntoConstraints = false
        deleteProfileButton.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 10).isActive = true
        deleteProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        deleteProfileButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        deleteProfileButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    // MARK: - Buttons methods
    @objc private func contactsButtonPressed() {
        presenter?.toContacts()
    }
    
    @objc private func findUsersButtonPressed() {
        presenter?.toSearchContacts()
    }
    
    /// Отработка нажатия кнопки Заполнить профиль
    @objc private func fillProfileButtonPressed() {
        presenter?.fillProfile()
    }
    
    /// Отработка нажатия кнопки Профиль
    @objc private func profileButtonPressed() {
        let viewController = ProfileViewController()
        let presenter = ProfilePresenter(view: viewController)
        viewController.presenter = presenter
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func searchButtonPressed() {
        let viewController = StartSearchViewController()
        let presenter = StartSearchPresenter(view: viewController)
        viewController.presenter = presenter
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func deleteProfileButtonPressed() {
        NetworkManager.shared.deleteUser { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    UserDefaults.standard.set("not_verification", forKey: "userStatus")
                    AppDelegate.shared.rootViewController.switchToLogout()
                case .failure(let error):
                    self?.showAlert(message: error.description)
                }
            }
        }
    }
    
}
