//
//  AddMembersViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 13.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class AddMembersViewController: UIViewController {

    // MARK: - Dependency
    var presenter: AddMembersPresenterProtocol?
    
    // MARK: - Constants
    private var friendsButton = HDButton()
    private var findColleaguesButton = HDButton()
    private var sendInviteButton = HDButton()
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupHeaderViewWithAvatar(title: "Добавление участников",
                                  text: nil,
                                  userImage: nil,
                                  presenter: presenter)
        setupFriendButton()
        setupFindColleaguesButton()
        setupSendInviteButton()
        addTapGestureToHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.statusBarBackgroundColor = .tabBarColor
    }
    
    // MARK: - Setup views
    private func setupFriendButton() {
        friendsButton = HDButton(title: "Друзья", fontSize: 14)
        friendsButton.addTarget(self, action: #selector(friendsButtonPressed), for: .touchUpInside)
        friendsButton.isEnabled = true
        view.addSubview(friendsButton)

        friendsButton.translatesAutoresizingMaskIntoConstraints = false
        friendsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 164).isActive = true
        friendsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        friendsButton.widthAnchor.constraint(equalToConstant: 235).isActive = true
        friendsButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func setupFindColleaguesButton() {
        findColleaguesButton = HDButton(title: "Поиск коллег", fontSize: 14)
        findColleaguesButton.addTarget(self, action: #selector(findColleaguesButtonPressed), for: .touchUpInside)
        findColleaguesButton.isEnabled = true
        view.addSubview(findColleaguesButton)

        findColleaguesButton.translatesAutoresizingMaskIntoConstraints = false
        findColleaguesButton.topAnchor.constraint(equalTo: friendsButton.bottomAnchor, constant: 10).isActive = true
        findColleaguesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        findColleaguesButton.widthAnchor.constraint(equalToConstant: 235).isActive = true
        findColleaguesButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func setupSendInviteButton() {
        sendInviteButton = HDButton(title: "Научная деятельность", fontSize: 14)
        sendInviteButton.addTarget(self, action: #selector(sendInviteButtonPressed), for: .touchUpInside)
        sendInviteButton.isEnabled = true
        view.addSubview(sendInviteButton)

        sendInviteButton.translatesAutoresizingMaskIntoConstraints = false
        sendInviteButton.topAnchor.constraint(equalTo: findColleaguesButton.bottomAnchor, constant: 10).isActive = true
        sendInviteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendInviteButton.widthAnchor.constraint(equalToConstant: 235).isActive = true
        sendInviteButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func addTapGestureToHideKeyboard() {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self,
                                                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideKeyboardGesture)
    }
    
    // MARK: - Buttons methods
    @objc private func friendsButtonPressed() {
        showAlert(message: "В разработке")
        presenter?.friendsButtonPressed()
    }
    
    @objc private func findColleaguesButtonPressed() {
        showAlert(message: "В разработке")
        presenter?.findColleaguesButtonPressed()
    }
    
    @objc private func sendInviteButtonPressed() {
        showAlert(message: "В разработке")
        presenter?.sendInviteButtonPressed()
    }
    
    @objc func hideKeyboard() {
//        scrollView.endEditing(true)
        view.viewWithTag(998)?.removeFromSuperview()
        view.viewWithTag(999)?.removeFromSuperview()
    }

}
