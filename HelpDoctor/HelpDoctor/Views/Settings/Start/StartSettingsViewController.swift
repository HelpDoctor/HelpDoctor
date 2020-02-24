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
    private let settingsArray = [
        [SettingsRow.user, SettingsRow.generalSettings, SettingsRow.securitySettings, SettingsRow.addFriends],
        [SettingsRow.notificationSettings, SettingsRow.emailSettings],
        [SettingsRow.callback, SettingsRow.help]
    ]
    private let tableView = UITableView()
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.494, green: 0.737, blue: 0.902, alpha: 1)
        setupHeaderViewWithAvatar(title: "Настройки",
                                  text: nil,
                                  userImage: nil,
                                  presenter: presenter)
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.statusBarBackgroundColor = .tabBarColor
    }
    
    // MARK: - Setup views
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        tableView.backgroundColor = UIColor(red: 0.494, green: 0.737, blue: 0.902, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                       constant: 50).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                          constant: -48).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    

//    @objc private func logouButtonPressed() {
//        let logout = Registration(email: nil, password: nil, token: myToken)
//
//        getData(typeOfContent: .logout,
//                returning: (Int?, String?).self,
//                requestParams: logout.requestParams)
//        { [weak self] result in
//            let dispathGroup = DispatchGroup()
//            logout.responce = result
//
//            dispathGroup.notify(queue: DispatchQueue.main) {
//                DispatchQueue.main.async { [weak self]  in
//                    print("result=\(String(describing: logout.responce))")
//                    guard let code = logout.responce?.0 else { return }
//                    if responceCode(code: code) {
//                        print("Logout")
//                        AppDelegate.shared.rootViewController.switchToLogout()
//                    } else {
//                        self?.showAlert(message: logout.responce?.1)
//                    }
//                }
//            }
//        }
//    }
//
//    @objc private func deleteButtonPressed() {
//        let unRegistration = Registration(email: nil, password: nil, token: nil)
//        getData(typeOfContent: .deleteMail,
//                returning: (Int?, String?).self,
//                requestParams: [:])
//        { [weak self] result in
//            let dispathGroup = DispatchGroup()
//            unRegistration.responce = result
//
//            dispathGroup.notify(queue: DispatchQueue.main) {
//                DispatchQueue.main.async { [weak self] in
//                    print("result= \(String(describing: unRegistration.responce))")
//                }
//            }
//        }
//    }

}

// MARK: - Table View Delegate
extension StartSettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: Session.width, height: 40))
        let label = UILabel()
        label.font = .boldSystemFontOfSize(size: 14)
        label.textColor = .white
        headerView.backgroundColor = UIColor(red: 0.137, green: 0.455, blue: 0.671, alpha: 1)
        headerView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        switch section {
        case 0:
            label.text = "Настройки профиля и безопасности"
            return headerView
        case 1:
            label.text = "Настройки рассылки и уведомлений"
            return headerView
        case 2:
            label.text = "Помощь"
            return headerView
        default:
            label.text = ""
            return headerView
        }

    }
}

// MARK: - Table Data Source
extension StartSettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell",
                                                       for: indexPath) as? SettingsCell
            else { return UITableViewCell() }
        cell.configure(settingsRow: settingsArray[indexPath.section][indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                print("\(indexPath.section)")
            case 2:
                presenter?.securityRow()
            case 3:
                presenter?.inviteRow()
            default:
                print("\(indexPath.section)")
            }
        case 1:
            switch indexPath.row {
            case 0:
                print("\(indexPath.section)")
            case 1:
                presenter?.emailRow()
            default:
                print("\(indexPath.section)")
            }
        case 2:
            switch indexPath.row {
            case 0:
                presenter?.feedbackRow()
            default:
                presenter?.helpRow()
            }
        default:
            print("smth \(indexPath.row)")
        }
        
    }
    
}
