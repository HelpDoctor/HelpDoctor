//
//  ResultSearchViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 26.11.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class ResultSearchViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: ResultSearchPresenterProtocol?
    
    // MARK: - Constants
    private let headerHeight = 40.f
    private let verticalInset = 10.f
    private let searchBar = UITextField()
    private let closeButton = UIButton()
    private let topView = UIView()
    private let resultLabel = UILabel()
    private let centralView = UIView()
    private let contactsLabel = UILabel()
    private let sortButton = UIButton()
    private let filterButton = UIButton()
    private let tableView = UITableView()
    var filterParams = ""
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupHeaderView(color: .tabBarColor,
                        height: headerHeight,
                        presenter: presenter,
                        title: "Поиск коллег",
                        font: .boldSystemFontOfSize(size: 14))
        setupSearchBar()
        setupCloseButton()
        setupTopView()
        setupResultLabel()
        setupCentralView()
        setupContactsLabel()
        setupSortButton()
        setupFilterButton()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Public methods
    func reloadTableView() {
        tableView.reloadData()
        contactsLabel.text = "Найдено: \(presenter?.getCountContacts() ?? 0)"
    }
    
    // MARK: - Setup views
    private func setupSearchBar() {
        searchBar.font = .systemFontOfSize(size: 14)
        searchBar.isUserInteractionEnabled = false
        searchBar.textColor = .textFieldTextColor
        searchBar.autocapitalizationType = .none
        searchBar.textAlignment = .left
        searchBar.backgroundColor = .white
        searchBar.layer.cornerRadius = 5
        searchBar.autocorrectionType = .no
        searchBar.leftView = setupDefaultLeftView()
        searchBar.leftViewMode = .always
        searchBar.text = filterParams
        view.addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                       constant: headerHeight + verticalInset).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: 20).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: Session.width - 70).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupCloseButton() {
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        closeButton.backgroundColor = .hdButtonColor
        closeButton.layer.cornerRadius = 5
        closeButton.setImage(UIImage(named: "Cross"), for: .normal)
        view.addSubview(closeButton)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor,
                                               constant: verticalInset).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupTopView() {
        topView.backgroundColor = .white
        view.addSubview(topView)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: searchBar.bottomAnchor,
                                     constant: verticalInset).isActive = true
        topView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupResultLabel() {
        resultLabel.font = .mediumSystemFontOfSize(size: 12)
        resultLabel.textColor = .black
        resultLabel.text = "Результаты поиска"
        resultLabel.textAlignment = .left
        resultLabel.numberOfLines = 1
        topView.addSubview(resultLabel)
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        resultLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor,
                                                     constant: verticalInset).isActive = true
        resultLabel.widthAnchor.constraint(equalToConstant: Session.width - (verticalInset * 2)).isActive = true
        resultLabel.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupCentralView() {
        centralView.backgroundColor = .searchBarTintColor
        view.addSubview(centralView)
        
        centralView.translatesAutoresizingMaskIntoConstraints = false
        centralView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        centralView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centralView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        centralView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupContactsLabel() {
        let count = presenter?.getCountContacts()
        contactsLabel.font = .mediumSystemFontOfSize(size: 12)
        contactsLabel.textColor = .white
        contactsLabel.text = "Найдено: \(count ?? 0)"
        contactsLabel.textAlignment = .left
        contactsLabel.numberOfLines = 1
        centralView.addSubview(contactsLabel)
        
        contactsLabel.translatesAutoresizingMaskIntoConstraints = false
        contactsLabel.topAnchor.constraint(equalTo: centralView.topAnchor).isActive = true
        contactsLabel.leadingAnchor.constraint(equalTo: centralView.leadingAnchor,
                                               constant: verticalInset).isActive = true
        contactsLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        contactsLabel.bottomAnchor.constraint(equalTo: centralView.bottomAnchor).isActive = true
    }
    
    private func setupSortButton() {
        sortButton.addTarget(self, action: #selector(sortButtonPressed), for: .touchUpInside)
        sortButton.setImage(UIImage(named: "SortIcon"), for: .normal)
        sortButton.setTitle(" Сортировать по имени", for: .normal)
        sortButton.titleLabel?.font = .mediumSystemFontOfSize(size: 12)
        sortButton.titleLabel?.textColor = .white
        sortButton.contentHorizontalAlignment = .center
        centralView.addSubview(sortButton)
        
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        sortButton.topAnchor.constraint(equalTo: centralView.topAnchor).isActive = true
        sortButton.leadingAnchor.constraint(equalTo: contactsLabel.trailingAnchor,
                                               constant: verticalInset).isActive = true
        sortButton.widthAnchor.constraint(equalToConstant: (Session.width - (verticalInset * 4) - 140)).isActive = true
        sortButton.bottomAnchor.constraint(equalTo: centralView.bottomAnchor).isActive = true
    }
    
    private func setupFilterButton() {
        filterButton.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
        filterButton.setImage(UIImage(named: "FilterHIcon"), for: .normal)
        filterButton.setTitle(" Фильтр", for: .normal)
        filterButton.titleLabel?.font = .mediumSystemFontOfSize(size: 12)
        filterButton.titleLabel?.textColor = .white
        filterButton.contentHorizontalAlignment = .right
        centralView.addSubview(filterButton)
        
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        filterButton.topAnchor.constraint(equalTo: centralView.topAnchor).isActive = true
        filterButton.leadingAnchor.constraint(equalTo: sortButton.trailingAnchor,
                                               constant: verticalInset).isActive = true
        filterButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        filterButton.bottomAnchor.constraint(equalTo: centralView.bottomAnchor).isActive = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "ContactTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .backgroundColor
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.allowsMultipleSelection = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: centralView.bottomAnchor,
                                       constant: verticalInset).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: verticalInset).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                            constant: -verticalInset).isActive = true
    }
    
    // MARK: - Buttons methods
    @objc private func filterButtonPressed() {
        presenter?.toFilter()
    }
    
    @objc private func sortButtonPressed() {
//        presenter?.saveGuests()
    }
    
    @objc private func closeButtonPressed() {
        searchBar.text = ""
        presenter?.searchUsers(searchBar.text ?? "", 0, 1)
    }
    
}

// MARK: - UITableViewDelegate
extension ResultSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
}

// MARK: - UITableViewDataSource
extension ResultSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.getCountContacts() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell",
                                                       for: indexPath) as? ContactTableViewCell
            else { return UITableViewCell() }
        cell.configure(contact: (presenter?.getContact(index: indexPath.section)))
        cell.messageUsersCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
