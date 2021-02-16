//
//  ContactsViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 19.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: ContactsPresenterProtocol?
    
    // MARK: - Constants
    private let headerHeight = 40.f
    private let heightCollectionView = 60.f
    private let verticalInset = 10.f
    private let searchBar = UISearchBar()
    private let topView = UIView()
    private let recentContactsLabel = UILabel()
    private let centralView = UIView()
    private let contactsLabel = UILabel()
    private let bottomView = UIView()
    private let guestCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let contactsCountLabel = UILabel()
    private let sortButton = UIButton()
    private let tableView = UITableView()
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupHeaderView(color: .tabBarColor,
                        height: headerHeight,
                        presenter: presenter,
                        title: "Мои контакты",
                        font: .boldSystemFontOfSize(size: 14))
        setupSearchBar()
        setupTopView()
        setupSelectedGuestsLabel()
        setupGuestCollectionView()
        setupCentralView()
        setupContactsLabel()
        setupBottomView()
        setupContactsCountLabel()
        setupSortButton()
        setupTableView()
        presenter?.getContactList()
        guard let headerView = view.viewWithTag(Session.tagHeaderView) as? HeaderView else { return }
        headerView.hideBackButton()
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
    
    func reloadCollectionView() {
        guestCollectionView.reloadData()
    }
    
    func setCountContactList(contactsCount: Int) {
        contactsCountLabel.text = "Контактов: \(contactsCount)"
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
        recentContactsLabel.font = .boldSystemFontOfSize(size: 12)
        recentContactsLabel.textColor = .black
        recentContactsLabel.text = "Недавние контакты"
        recentContactsLabel.textAlignment = .left
        recentContactsLabel.numberOfLines = 1
        topView.addSubview(recentContactsLabel)
        
        recentContactsLabel.translatesAutoresizingMaskIntoConstraints = false
        recentContactsLabel.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        recentContactsLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor,
                                                     constant: verticalInset).isActive = true
        recentContactsLabel.widthAnchor.constraint(equalToConstant: Session.width - (verticalInset * 2)).isActive = true
        recentContactsLabel.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupGuestCollectionView() {
        guestCollectionView.backgroundColor = .backgroundColor
        guestCollectionView.layer.cornerRadius = 5
        guestCollectionView.register(RecentContactsCell.self, forCellWithReuseIdentifier: "RecentContactsCell")
        guestCollectionView.dataSource = self
        guestCollectionView.delegate = self
        view.addSubview(guestCollectionView)
        
        guestCollectionView.translatesAutoresizingMaskIntoConstraints = false
        guestCollectionView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        guestCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        guestCollectionView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        guestCollectionView.heightAnchor.constraint(equalToConstant: heightCollectionView).isActive = true
    }
    
    private func setupCentralView() {
        centralView.backgroundColor = .white
        view.addSubview(centralView)
        
        centralView.translatesAutoresizingMaskIntoConstraints = false
        centralView.topAnchor.constraint(equalTo: guestCollectionView.bottomAnchor).isActive = true
        centralView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centralView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        centralView.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupContactsLabel() {
        contactsLabel.font = .boldSystemFontOfSize(size: 12)
        contactsLabel.textColor = .black
        contactsLabel.text = "Контакты"
        contactsLabel.textAlignment = .left
        contactsLabel.numberOfLines = 1
        centralView.addSubview(contactsLabel)
        
        contactsLabel.translatesAutoresizingMaskIntoConstraints = false
        contactsLabel.topAnchor.constraint(equalTo: centralView.topAnchor).isActive = true
        contactsLabel.leadingAnchor.constraint(equalTo: centralView.leadingAnchor,
                                               constant: verticalInset).isActive = true
        contactsLabel.widthAnchor.constraint(equalToConstant: Session.width - (verticalInset * 2)).isActive = true
        contactsLabel.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupBottomView() {
        bottomView.backgroundColor = .searchBarTintColor
        view.addSubview(bottomView)
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.topAnchor.constraint(equalTo: centralView.bottomAnchor).isActive = true
        bottomView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupContactsCountLabel() {
        let width = (Session.width / 2) - (verticalInset * 2)
        contactsCountLabel.font = .mediumSystemFontOfSize(size: 12)
        contactsCountLabel.textColor = .white
        contactsCountLabel.text = "Контактов:"
        contactsCountLabel.textAlignment = .left
        contactsCountLabel.numberOfLines = 1
        bottomView.addSubview(contactsCountLabel)
        
        contactsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        contactsCountLabel.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        contactsCountLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor,
                                                    constant: verticalInset).isActive = true
        contactsCountLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        contactsCountLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
    }
    
    private func setupSortButton() {
        sortButton.addTarget(self, action: #selector(sortButtonPressed), for: .touchUpInside)
        sortButton.setImage(UIImage(named: "SortIcon"), for: .normal)
        sortButton.setTitle(" Сортировать", for: .normal)
        sortButton.titleLabel?.font = .mediumSystemFontOfSize(size: 10)
        sortButton.titleLabel?.textColor = .white
        sortButton.contentHorizontalAlignment = .right
        bottomView.addSubview(sortButton)
        
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        sortButton.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        sortButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor,
                                               constant: -verticalInset).isActive = true
        sortButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sortButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
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
        tableView.topAnchor.constraint(equalTo: bottomView.bottomAnchor,
                                       constant: verticalInset).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: verticalInset).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                            constant: -verticalInset).isActive = true
    }
    
    // MARK: - Buttons methods
    @objc private func sortButtonPressed() {
        let popoverContentController = ContactsSortPopoverController()
        popoverContentController.modalPresentationStyle = .popover
        popoverContentController.preferredContentSize = CGSize(width: 180, height: 100)
        popoverContentController.delegate = self
        if let ppc = popoverContentController.popoverPresentationController {
            ppc.delegate = self
        }
        self.present(popoverContentController, animated: true, completion: nil)
    }
    
}

// MARK: - UIPopoverPresentationControllerDelegate
extension ContactsViewController: UIPopoverPresentationControllerDelegate {
    
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        popoverPresentationController.permittedArrowDirections = .any
        popoverPresentationController.sourceView = sortButton
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}

// MARK: - ProfilePopoverDelegate
extension ContactsViewController: ContactsSortPopoverDelegate {
    func sortByName() {
        presenter?.sortByName()
    }
    
    func sortBySpec() {
        presenter?.sortBySpec()
    }
}

// MARK: - Collection view
extension ContactsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        presenter?.addInterest(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //        presenter?.deleteInterest(index: indexPath.item)
    }
    
}

extension ContactsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getCountRecentContacts() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentContactsCell",
                                                            for: indexPath) as? RecentContactsCell else {
            return UICollectionViewCell()
        }
        cell.configure(contact: (presenter?.getRecentContact(index: indexPath.item)))
        return cell
    }
    
}

extension ContactsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 45, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
}

// MARK: - UISearchBarDelegate
extension ContactsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            presenter?.searchTextIsEmpty()
            return
        }
        presenter?.filter(searchText: searchText)
    }
    
}

// MARK: - UITableViewDelegate
extension ContactsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let contact = presenter?.getContact(index: indexPath.section) else { return }
        let viewController = UserViewController()
        let vcPresenter = UserPresenter(view: viewController)
        viewController.presenter = vcPresenter
        viewController.userId = contact.id
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteContact = UIContextualAction(style: .destructive,
                                               title: "") {  (_, _, completion) in
            self.presenter?.deleteFromSelected(index: indexPath.section)
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
extension ContactsViewController: UITableViewDataSource {
    
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
