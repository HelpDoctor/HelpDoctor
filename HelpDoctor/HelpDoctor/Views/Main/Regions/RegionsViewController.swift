//
//  RegionsViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 02.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class RegionsViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: RegionsPresenterProtocol?
    
    // MARK: - Constants
    private let backgroundColor = UIColor.backgroundColor
    private let headerHeight = 60.f
    private var tableView = UITableView()
    private var okButton = HDButton(title: "Готово")
    private let searchBar = UISearchBar()
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getRegions()
        view.backgroundColor = backgroundColor
        setupHeaderView(color: backgroundColor,
                        height: headerHeight,
                        presenter: presenter,
                        title: "Выбор субъекта",
                        font: .boldSystemFontOfSize(size: 18))
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
        let top = 60.f
        let height = 56.f
        searchBar.delegate = self
        searchBar.barTintColor = .searchBarTintColor
        searchBar.searchTextField.backgroundColor = .white
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
        okButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                           constant: -20).isActive = true
        okButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                         constant: -18).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        okButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
    }
    
    // MARK: - Navigation
    @objc private func okButtonPressed() {
        presenter?.next(index: tableView.indexPathForSelectedRow?.item)
    }
    
}

// MARK: - UISearchBarDelegate
extension RegionsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            presenter?.searchTextIsEmpty()
            return
        }
        presenter?.filter(searchText: searchText)
    }
    
}

// MARK: - UITableViewDelegate
extension RegionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.isSelected = true
        searchBar.searchTextField.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.isSelected = false
    }
    
}

// MARK: - UITableViewDataSource
extension RegionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getCountRegions() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RegionCell",
                                                       for: indexPath) as? RegionCell
        else { fatalError("Could not dequeue a cell") }
        
        cell.configure(presenter?.getRegionTitle(index: indexPath.row) ?? "Region not found")
        return cell
    }
    
}
