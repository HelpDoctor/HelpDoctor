//
//  InterestsViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 03.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class InterestsViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: InterestsPresenterProtocol?
    
    // MARK: - Constants
    var tableView = UITableView()
    private var okButton = HDButton()
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupHeaderView()
        setupTableView()
        setupOkButton()
        selectRows()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.statusBarBackgroundColor = .clear
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Public methods
    func setSelected(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
    }
    
    // MARK: - Setup views
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(InterestTableViewCell.self, forCellReuseIdentifier: "InterestTableViewCell")
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -58).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    private func setupOkButton() {
        okButton = HDButton(title: "Готово")
        okButton.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
        okButton.isEnabled = true
        view.addSubview(okButton)
        
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        okButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -18).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        okButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    // MARK: - Private methods
    func selectRows() {
        presenter?.selectRows()
    }
    
    // MARK: - Navigation
    @objc private func okButtonPressed() {
        presenter?.next()
    }
}

extension InterestsViewController: UITableViewDelegate {}

extension InterestsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getCountInterests() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InterestTableViewCell",
                                                       for: indexPath) as? InterestTableViewCell
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
