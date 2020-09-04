//
//  RepeatNotificationsViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 19.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//
/*
import UIKit

class RepeatNotificationsViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: RepeatNotificationsPresenterProtocol?
    
    // MARK: - Constants and variables
    private var tableView = UITableView()
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupHeaderViewWithAvatar(title: "Повтор",
                                  text: nil,
                                  userImage: nil,
                                  presenter: presenter)
        setupTableView()
        selectRows()
        addSwipeGestureToBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Public methods
    func setSelected(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
    }
    
    // MARK: - Setup views
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(RepeatNotificationsTableViewCell.self,
                           forCellReuseIdentifier: "RepeatNotificationsTableViewCell")
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
        tableView.layer.cornerRadius = 5
        tableView.layer.masksToBounds = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -58).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    // MARK: - Private methods
    private func selectRows() {
        presenter?.selectRows()
    }
    
    /// Добавляет свайп влево для перехода назад
    private func addSwipeGestureToBack() {
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.addTarget(self, action: #selector(backButtonPressed))
        swipeLeft.direction = .right
        view.addGestureRecognizer(swipeLeft)
    }
    
    /// Переход на предыдущий экран
    @objc private func backButtonPressed() {
        presenter?.back()
    }
}

extension RepeatNotificationsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        footerView.backgroundColor = .clear
        return footerView
    }
    
}

extension RepeatNotificationsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepeatNotificationsTableViewCell",
                                                       for: indexPath) as? RepeatNotificationsTableViewCell
            else { return UITableViewCell() }
        
        cell.configure(presenter?.getInterestsTitle(index: indexPath.row) ?? "Not found")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = true
        presenter?.appendIndexArray(index: indexPath.item)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        presenter?.removeIndexArray(index: indexPath.item)
    }
    
}
*/
