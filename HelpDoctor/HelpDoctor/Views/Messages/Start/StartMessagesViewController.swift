//
//  StartMessagesViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 12.02.2021.
//  Copyright © 2021 Mikhail Semerikov. All rights reserved.
//

import UIKit

class StartMessagesViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: StartMessagesPresenterProtocol?
    
    // MARK: - Constants
    private let sizeImage = 50.f
    private let leading = 20.f
    private let avatarImage = UIImageView()
    private let titleLabel = UILabel()
    private let logoImage = UIImageView()
    private let todayLabel = PaddingLabel()
    private var chatTableView = UITableView()
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupAvatarImage()
        setupTitleLabel()
        setupLogoImage()
        setupTodayLabel()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .backgroundColor)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Public methods
    
    
    // MARK: - Setup views
    private func setupAvatarImage() {
        let top = 10.f
        avatarImage.clipsToBounds = true
        avatarImage.layer.cornerRadius = sizeImage / 2
        avatarImage.image = Session.instance.user?.foto?.toImage()
        view.addSubview(avatarImage)
        
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
        avatarImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true
        avatarImage.widthAnchor.constraint(equalToConstant: sizeImage).isActive = true
        avatarImage.heightAnchor.constraint(equalToConstant: sizeImage).isActive = true
    }
    
    private func setupTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.text = "Здравствуйте, Доктор"
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor,
                                            constant: leading / 2).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: avatarImage.centerYAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: Session.width - 160).isActive = true
    }
    
    private func setupLogoImage() {
        logoImage.clipsToBounds = true
        logoImage.layer.cornerRadius = sizeImage / 2
        logoImage.image = UIImage(named: "Logo")
        view.addSubview(logoImage)
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.topAnchor.constraint(equalTo: avatarImage.topAnchor).isActive = true
        logoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leading).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: sizeImage).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: sizeImage).isActive = true
    }
    
    private func setupTodayLabel() {
        let top = 10.f
        let height = 30.f
        todayLabel.backgroundColor = .white
        todayLabel.font = .systemFont(ofSize: 14, weight: .bold)
        todayLabel.textColor = .black
        todayLabel.text = "Сегодня 21 сентября"
        todayLabel.textAlignment = .left
        view.addSubview(todayLabel)
        
        todayLabel.translatesAutoresizingMaskIntoConstraints = false
        todayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        todayLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: top).isActive = true
        todayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        todayLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupTableView() {
        view.addSubview(chatTableView)
        chatTableView.register(ChatCell.self, forCellReuseIdentifier: "ChatCell")
        chatTableView.backgroundColor = .clear
        chatTableView.dataSource = self
        chatTableView.delegate = self
        chatTableView.separatorStyle = .none
//        chatTableView.refreshControl = UIRefreshControl()
//        chatTableView.refreshControl?.attributedTitle = NSAttributedString(string: "Идет обновление...")
//        chatTableView.refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: UIControl.Event.valueChanged)
        
        chatTableView.translatesAutoresizingMaskIntoConstraints = false
        chatTableView.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 10).isActive = true
        chatTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        chatTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true
        chatTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leading).isActive = true
    }
    
}

// MARK: - Table View Delegate
extension StartMessagesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
}

// MARK: - Table Data Source
extension StartMessagesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell",
                                                       for: indexPath) as? ChatCell
            else { return UITableViewCell() }
        cell.configure("Горин Петр Игоревич")
        cell.layer.cornerRadius = 5
//        cell.configure(startTime: presenter?.getStartTimeEvent(index: indexPath.section) ?? "",
//                       endTime: presenter?.getEndTimeEvent(index: indexPath.section) ?? "",
//                       event: presenter?.getTitleEvent(index: indexPath.section) ?? "",
//                       eventColor: presenter?.getEventColor(index: indexPath.section) ?? .clear,
//                       isMajor: presenter?.getMajorFlag(index: indexPath.section) ?? false)
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter?.didSelectRow(index: indexPath.section)
    }
    
}
