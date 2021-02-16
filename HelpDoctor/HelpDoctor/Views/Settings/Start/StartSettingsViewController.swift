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
    private let headerHeight = 40.f
    private var heightTableHeader = 0.f
    private var heightTableRow = 0.f
    private var countItems = 0
    private var countRows = 0
    private let settingsArray = [
        [SettingsRow.user,
         SettingsRow.verification,
         SettingsRow.blockedUsers,
         SettingsRow.securitySettings,
         SettingsRow.addFriends],
        [SettingsRow.notificationSettings,
         SettingsRow.emailSettings],
        [SettingsRow.callback,
         SettingsRow.help]
    ]
    private let tableView = UITableView()
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupHeaderView(color: .tabBarColor,
                        height: headerHeight,
                        presenter: presenter,
                        title: "Настройки",
                        font: .boldSystemFontOfSize(size: 14))
        setupTableView()
        presenter?.loadSettings()
        guard let headerView = view.viewWithTag(Session.tagHeaderView) as? HeaderView else { return }
        headerView.hideBackButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tableHeight = tableView.frame.height
        countItems = 0
        countRows = 0
        settingsArray.forEach({ arr in
            countItems += arr.count
            countRows += arr.count
        })
        countItems += settingsArray.count
        heightTableHeader = tableHeight / CGFloat(countItems) * 0.8
        heightTableRow = (tableHeight - (heightTableHeader * CGFloat(settingsArray.count))) / CGFloat(countRows)
    }
    
    // MARK: - Setup views
    private func setupTableView() {
        let bottom = tabBarController?.tabBar.frame.height ?? 0
        view.addSubview(tableView)
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        tableView.backgroundColor = .backgroundColor
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                       constant: headerHeight).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                          constant: -bottom).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
}

// MARK: - Table View Delegate
extension StartSettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightTableHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightTableRow
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: Session.width,
                                              height: heightTableHeader))
        let label = UILabel()
        label.font = .boldSystemFontOfSize(size: 14)
        label.textColor = .white
        headerView.backgroundColor = UIColor.searchBarTintColor
        headerView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        label.heightAnchor.constraint(equalToConstant: heightTableHeader).isActive = true
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                presenter?.userRow()
            case 1:
                presenter?.verificationRow()
            case 2:
                presenter?.blockedRow()
            case 3:
                presenter?.securityRow()
            case 4:
                presenter?.inviteRow()
            default:
                print("\(indexPath.section)")
            }
        case 1:
            switch indexPath.row {
            case 0:
                presenter?.pushRow()
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
//        if indexPath.section == 0 && indexPath.row == 2 {
//            cell.configureDisabled(settingsRow: settingsArray[indexPath.section][indexPath.row])
//        } else {
            cell.configure(settingsRow: settingsArray[indexPath.section][indexPath.row])
//        }
        cell.backgroundColor = .clear
        return cell
    }
    
}
