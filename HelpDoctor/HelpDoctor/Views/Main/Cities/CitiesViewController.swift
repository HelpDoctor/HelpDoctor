//
//  CitiesViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 03.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: CitiesPresenterProtocol?
    
    // MARK: - Constants
    private let backgroundColor = UIColor.backgroundColor
    private let headerHeight = 60.f
    private var tableView = UITableView()
    private var okButton = HDButton(title: "Готово")
    private let searchBar = UISearchBar()
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        setupHeaderView(color: backgroundColor, height: headerHeight, presenter: presenter)
        setupSearchBar()
        setupTableView()
        setupOkButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .clear)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Public methods
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func setTitleButton() {
        okButton.setTitle("Далее", for: .normal)
    }
    
    // MARK: - Setup views
    private func setupSearchBar() {
        let top: CGFloat = 60
        let height: CGFloat = 56
        searchBar.delegate = self
        searchBar.barTintColor = .searchBarTintColor
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = .white
        } else {
            guard let searchField = searchBar.value(forKey: "searchField") as? UITextField else { return }
            searchField.backgroundColor = .white
        }
        searchBar.placeholder = "Поиск"
        view.addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                       constant: top).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(RegionCell.self, forCellReuseIdentifier: "RegionCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .backgroundColor
        tableView.keyboardDismissMode = .onDrag
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setupOkButton() {
        okButton.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
        okButton.isEnabled = true
        view.addSubview(okButton)
        
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        okButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -18).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        okButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
    }
    
    // MARK: - Navigation
    @objc private func okButtonPressed() {
        presenter?.next(index: tableView.indexPathForSelectedRow?.item)
    }
}

// MARK: - UISearchBarDelegate
extension CitiesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            presenter?.searchTextIsEmpty()
            return
        }
        presenter?.filter(searchText: searchText)
    }
    
}

// MARK: - UITableViewDelegate
extension CitiesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerTitle = UILabel()
        let leading: CGFloat = 20
        headerView.backgroundColor = .white
        headerView.addSubview(headerTitle)
        headerTitle.text = presenter?.getRegionName()
        headerTitle.font = .semiBoldSystemFontOfSize(size: 14)
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        headerTitle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor,
                                             constant: leading).isActive = true
        headerTitle.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,
                                              constant: -leading).isActive = true
        headerTitle.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}

// MARK: - UITableViewDataSource
extension CitiesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.getRegionName()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getCountCities() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RegionCell",
                                                       for: indexPath) as? RegionCell
            else { return UITableViewCell() }

        cell.configure(presenter?.getCityTitle(index: indexPath.row) ?? "City not found")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.isSelected = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.isSelected = false
    }

}
