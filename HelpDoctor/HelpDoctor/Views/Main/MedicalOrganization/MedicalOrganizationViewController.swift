//
//  MedicalOrganizationViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 03.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class MedicalOrganizationViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: MedicalOrganizationPresenterProtocol?
    
    // MARK: - Constants
    private var headerView = HeaderView()
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.statusBarBackgroundColor = .clear
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Setup views
    private func setupHeaderView() {
        headerView = HeaderView(title: "HelpDoctor")
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(RegionCell.self, forCellReuseIdentifier: "RegionCell")
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10).isActive = true
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
    
    // MARK: - Navigation
    @objc private func okButtonPressed() {
        presenter?.next(index: tableView.indexPathForSelectedRow?.item)
    }
}

extension MedicalOrganizationViewController: UITableViewDelegate {}

extension MedicalOrganizationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getCountMedicalOrganizations() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RegionCell",
                                                       for: indexPath) as? RegionCell
            else { return UITableViewCell() }

        cell.configure(presenter?.getMedicalOrganizationTitle(index: indexPath.row) ?? "Medical organization not found")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let icon = (tableView.cellForRow(at: indexPath) as? RegionCell)?.icon else { return }
        icon.image = UIImage(named: "SelectedEllipse.pdf")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let icon = (tableView.cellForRow(at: indexPath) as? RegionCell)?.icon else { return }
        icon.image = UIImage(named: "Ellipse.pdf")
    }

}
