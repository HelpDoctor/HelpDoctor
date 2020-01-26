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
    private var currentDate = Date()
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupHeaderViewWithAvatar(title: "Расписание", text: nil, userImage: nil, presenter: presenter)
        setupTableView()
        setupAddButton()
        presenter?.getEvents(newDate: currentDate)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.statusBarBackgroundColor = .tabBarColor
    }
    
    // MARK: - Public methods
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func setDate(date: Date = Date()) {
        currentDate = date
    }
    
    func getDate() -> Date {
        return currentDate
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
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Идет обновление...")
        tableView.refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: UIControl.Event.valueChanged)
        
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
    
    // MARK: - Private methods
    @objc private func refresh(_ sender: Any) {
        refreshBegin(refreshEnd: {() -> Void in
            self.tableView.refreshControl?.endRefreshing()
        })
    }
    
    private func refreshBegin(refreshEnd: @escaping () -> Void) {
        DispatchQueue.global().async {
            self.presenter?.getEvents(newDate: self.currentDate)
            DispatchQueue.main.async {
                refreshEnd()
            }
        }
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (presenter?.getCountEvents() ?? 0) + 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell",
                                                           for: indexPath) as? DateCell
                else { return UITableViewCell() }
            cell.configure(presenter?.getCurrentDate(date: currentDate) ?? "")
            cell.backgroundColor = .clear
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentCell",
                                                           for: indexPath) as? AppointmentCell
                else { return UITableViewCell() }
            cell.configure(presenter?.getCountPatients() ?? 0)
            cell.backgroundColor = .clear
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodayEventCell",
                                                           for: indexPath) as? TodayEventCell
                else { return UITableViewCell() }
            cell.configure(presenter?.getCountMajorEvents() ?? 0)
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
            cell.configure(timeEvent: presenter?.getTimeEvent(index: indexPath.row - 4) ?? "",
                           flag: presenter?.getMajorFlag(index: indexPath.row - 4) ?? false,
                           event: presenter?.getTitleEvent(index: indexPath.row - 4) ?? "")
            cell.backgroundColor = .clear
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell",
                                                           for: indexPath) as? EventCell
                else { return UITableViewCell() }
            cell.configure(timeEvent: presenter?.getTimeEvent(index: indexPath.row - 4) ?? "",
                           flag: presenter?.getMajorFlag(index: indexPath.row - 4) ?? false,
                           event: presenter?.getTitleEvent(index: indexPath.row - 4) ?? "")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            presenter?.selectDate()
        default:
            presenter?.didSelectRow(index: indexPath.row - 4)
        }
    }

}
