//
//  BlockedUsersViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 07.11.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class BlockedUsersViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: BlockedUsersPresenterProtocol?
    
    // MARK: - Constants
    private let headerHeight = 40.f
    private let heightCollectionView = 70.f
    private let verticalInset = 10.f
    private let searchBar = UISearchBar()
    private let topView = UIView()
    private let selectedGuestsLabel = UILabel()
    private let centralView = UIView()
    private let contactsLabel = UILabel()
    private let inviteButton = UIButton()
    private let tableView = UITableView()
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupHeaderView(color: .tabBarColor,
                        height: headerHeight,
                        presenter: presenter,
                        title: "Заблокированные контакты",
                        font: .boldSystemFontOfSize(size: 14))
        setupSearchBar()
        setupTopView()
        setupSelectedGuestsLabel()
        setupCentralView()
        setupContactsLabel()
        setupInviteButton()
        setupTableView()
        presenter?.getBlockedUsers()
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
    }
    
    func setCountBlockedList(contactsCount: Int) {
        contactsLabel.text = "Заблокировано: \(contactsCount)"
    }
    
    func setSelected(index: Int) {
        let indexPath = IndexPath(row: 0, section: index)
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
    }
    
    // MARK: - Setup views
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.barTintColor = .backgroundColor
        searchBar.searchTextField.backgroundColor = .white
        searchBar.placeholder = "Поиск"
        view.addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                       constant: headerHeight + verticalInset).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
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
    
    private func setupSelectedGuestsLabel() {
        selectedGuestsLabel.font = .boldSystemFontOfSize(size: 12)
        selectedGuestsLabel.textColor = .black
        selectedGuestsLabel.text = "Контакты"
        selectedGuestsLabel.textAlignment = .left
        selectedGuestsLabel.numberOfLines = 1
        topView.addSubview(selectedGuestsLabel)
        
        selectedGuestsLabel.translatesAutoresizingMaskIntoConstraints = false
        selectedGuestsLabel.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        selectedGuestsLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor,
                                                     constant: verticalInset).isActive = true
        selectedGuestsLabel.widthAnchor.constraint(equalToConstant: Session.width - (verticalInset * 2)).isActive = true
        selectedGuestsLabel.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
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
        contactsLabel.font = .mediumSystemFontOfSize(size: 12)
        contactsLabel.textColor = .white
        contactsLabel.text = "Заблокировано:"
        contactsLabel.textAlignment = .left
        contactsLabel.numberOfLines = 1
        centralView.addSubview(contactsLabel)
        
        contactsLabel.translatesAutoresizingMaskIntoConstraints = false
        contactsLabel.topAnchor.constraint(equalTo: centralView.topAnchor).isActive = true
        contactsLabel.leadingAnchor.constraint(equalTo: centralView.leadingAnchor,
                                               constant: verticalInset).isActive = true
        contactsLabel.widthAnchor.constraint(equalToConstant: (Session.width / 2) - (verticalInset * 2)).isActive = true
        contactsLabel.bottomAnchor.constraint(equalTo: centralView.bottomAnchor).isActive = true
    }
    
    private func setupInviteButton() {
        inviteButton.addTarget(self, action: #selector(inviteButtonPressed), for: .touchUpInside)
        inviteButton.setImage(UIImage(named: "SortIcon"), for: .normal)
        inviteButton.setTitle(" Сортировать по имени", for: .normal)
        inviteButton.titleLabel?.font = .mediumSystemFontOfSize(size: 10)
        inviteButton.titleLabel?.textColor = .white
        inviteButton.contentHorizontalAlignment = .right
        centralView.addSubview(inviteButton)
        
        inviteButton.translatesAutoresizingMaskIntoConstraints = false
        inviteButton.topAnchor.constraint(equalTo: centralView.topAnchor).isActive = true
        inviteButton.trailingAnchor.constraint(equalTo: centralView.trailingAnchor,
                                               constant: -verticalInset).isActive = true
        inviteButton.widthAnchor.constraint(equalToConstant: (Session.width / 2) - (verticalInset * 2)).isActive = true
        inviteButton.bottomAnchor.constraint(equalTo: centralView.bottomAnchor).isActive = true
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
    @objc private func inviteButtonPressed() {
        
    }
    
}

// MARK: - UISearchBarDelegate
extension BlockedUsersViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            presenter?.searchTextIsEmpty()
            return
        }
        presenter?.filter(searchText: searchText)
    }
    
}

// MARK: - UITableViewDelegate
extension BlockedUsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.searchTextField.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteContact = UIContextualAction(style: .destructive,
                                               title: "") {  (_, _, completion) in
                                                tableView.cellForRow(at: indexPath)?.isSelected = false
                                                completion(true)
        }
        deleteContact.backgroundColor = .hdButtonColor
        deleteContact.image = UIImage(named: "Trash Icon")
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteContact])
        
        return swipeActions
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
}

// MARK: - UITableViewDataSource
extension BlockedUsersViewController: UITableViewDataSource {
    
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
        cell.blockedUsersCell()
        
        let message = "Разблокировать пользователя? Пользователь сможет отправлять вам сообщения и видеть ваш профиль"
        cell.unlockButtonAction = { [unowned self] in
            let alert = UIAlertController(title: "Разблокировать пользователя",
                                          message: message,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: { _ in
                presenter?.removeFromBlockList(indexPath.row)
                alert.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
