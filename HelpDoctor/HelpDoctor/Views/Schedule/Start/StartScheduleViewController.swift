//
//  StartScheduleViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 30.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class StartScheduleViewController: UIViewController {

    // MARK: - Dependency
    var presenter: StartSchedulePresenterProtocol?
    
    // MARK: - Constants
    private let tableView = UITableView()
    private var addButton = PlusButton()
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupHeaderViewWithAvatar(title: "Расписание", text: nil, userImage: nil, presenter: presenter)
        setupTableView()
        setupAddButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.statusBarBackgroundColor = .tabBarColor
    }
    
    // MARK: - Setup views
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(DateCell.self, forCellReuseIdentifier: "DateCell")
        tableView.register(AppointmentCell.self, forCellReuseIdentifier: "AppointmentCell")
        tableView.register(TodayEventCell.self, forCellReuseIdentifier: "TodayEventCell")
        tableView.register(SeparatorCell.self, forCellReuseIdentifier: "SeparatorCell")
        tableView.register(EventCell.self, forCellReuseIdentifier: "EventCell")
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 62).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    private func setupAddButton() {
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        view.addSubview(addButton)

        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    // MARK: - Buttons methods
    @objc private func addButtonPressed() {
        presenter?.addButtonPressed()
    }

}

extension StartScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 25))
        footerView.backgroundColor = .clear
        return footerView
    }
}

extension StartScheduleViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell",
                                                           for: indexPath) as? DateCell
                else { return UITableViewCell() }
            cell.configure("вс, 05/01/2020")
            cell.backgroundColor = .clear
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentCell",
                                                           for: indexPath) as? AppointmentCell
                else { return UITableViewCell() }
            cell.configure(5)
            cell.backgroundColor = .clear
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodayEventCell",
                                                           for: indexPath) as? TodayEventCell
                else { return UITableViewCell() }
            cell.configure(3)
            cell.backgroundColor = .clear
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SeparatorCell",
                                                           for: indexPath) as? SeparatorCell
                else { return UITableViewCell() }
            cell.backgroundColor = .clear
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell",
                                                           for: indexPath) as? EventCell
                else { return UITableViewCell() }
            cell.configure(timeEvent: "9:00-9:30", flag: false, event: "Иванов Иван Иванович")
            cell.backgroundColor = .clear
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell",
                                                           for: indexPath) as? EventCell
                else { return UITableViewCell() }
            cell.configure(timeEvent: "9:30-10:00", flag: true, event: "Конференция по хирургии")
            cell.backgroundColor = .clear
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 25
        case 1:
            return 25
        case 2:
            return 25
        case 3:
            return 25
        case 4:
            return 25
        default:
            return 25
        }
    }

}
