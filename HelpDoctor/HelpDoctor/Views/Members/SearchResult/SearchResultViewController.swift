//
//  SearchResultViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 23.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: SearchResultPresenterProtocol?
    
    // MARK: - Constants
    private let headerHeight = 40.f
    private var verticalInset = 10.f
    private let heightTopView = 30.f
    private let heightSeparatorView = 10.f
    private let heightButton = 44.f
    private var tabBarHeight = 0.f
    private var keyboardHeight = 0.f
    private let widthButton = 130.f
    private let leading = 20.f
    private let cancelButton = UIButton()
    private let searchTextField = UITextField()
    private let topView = UIView()
    private let label = UILabel()
    private let middleView = UIView()
    private let countLabel = UILabel()
    private let sortButton = UIButton()
    private let filterButton = UIButton()
    private let tableView = UITableView()
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        setupHeaderView(color: .tabBarColor,
                        height: headerHeight,
                        presenter: presenter,
                        title: "Поиск коллег",
                        font: .boldSystemFontOfSize(size: 14))
        setupCancelButton()
        setupSearchTextField()
        setupTopView()
        setupLabel()
        setupMiddleView()
        setupCountLabel()
        setupSortButton()
        setupFilterButton()
        setupTableView()
//        setupSpecTextField()
//        setupLocationTextField()
//        setupJobTextField()
//        setupEducationTextField()
//        setupClearButton()
//        setupSearchButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Public methods
    
    
    // MARK: - Setup views
    private func setupCancelButton() {
        cancelButton.setImage(UIImage(named: "Cross"), for: .normal)
        cancelButton.backgroundColor = .hdButtonColor
        cancelButton.layer.cornerRadius = 5
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        view.addSubview(cancelButton)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                         constant: headerHeight + verticalInset).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                             constant: -verticalInset).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupSearchTextField() {
        searchTextField.font = .systemFontOfSize(size: 14)
        searchTextField.textColor = .textFieldTextColor
        searchTextField.placeholder = "Поиск"
        searchTextField.textAlignment = .left
        searchTextField.autocorrectionType = .no
        searchTextField.backgroundColor = .white
        searchTextField.layer.cornerRadius = 5
        searchTextField.leftView = setupDefaultLeftView()
        searchTextField.leftViewMode = .always
        view.addSubview(searchTextField)
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.topAnchor.constraint(equalTo: cancelButton.topAnchor).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: leading).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor,
                                                  constant: -verticalInset).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupTopView() {
        topView.backgroundColor = .white
        view.addSubview(topView)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor,
                                     constant: verticalInset).isActive = true
        topView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        topView.heightAnchor.constraint(equalToConstant: heightTopView).isActive = true
    }
    
    private func setupLabel() {
        label.font = .boldSystemFontOfSize(size: 12)
        label.textColor = .black
        label.text = "Результаты поиска"
        label.textAlignment = .left
        label.numberOfLines = 1
        topView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: topView.leadingAnchor,
                                       constant: verticalInset).isActive = true
        label.widthAnchor.constraint(equalTo: topView.widthAnchor).isActive = true
        label.heightAnchor.constraint(equalTo: topView.heightAnchor).isActive = true
    }
    
    private func setupMiddleView() {
        middleView.backgroundColor = .searchBarTintColor
        view.addSubview(middleView)
        
        middleView.translatesAutoresizingMaskIntoConstraints = false
        middleView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        middleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        middleView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        middleView.heightAnchor.constraint(equalToConstant: heightTopView).isActive = true
    }
    
    private func setupCountLabel() {
        countLabel.font = .mediumSystemFontOfSize(size: 12)
        countLabel.textColor = .white
        countLabel.text = "Найдено: 0"
        countLabel.textAlignment = .left
        countLabel.numberOfLines = 1
        middleView.addSubview(countLabel)
        
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.topAnchor.constraint(equalTo: middleView.topAnchor).isActive = true
        countLabel.leadingAnchor.constraint(equalTo: middleView.leadingAnchor,
                                       constant: verticalInset).isActive = true
        countLabel.widthAnchor.constraint(equalTo: middleView.widthAnchor, multiplier: 1 / 3).isActive = true
        countLabel.heightAnchor.constraint(equalTo: middleView.heightAnchor).isActive = true
    }
    
    private func setupSortButton() {
        sortButton.addTarget(self, action: #selector(sortButtonPressed), for: .touchUpInside)
        sortButton.setImage(UIImage(named: "SortIcon"), for: .normal)
        sortButton.setTitle(" Сортировать по имени", for: .normal)
        sortButton.titleLabel?.font = .mediumSystemFontOfSize(size: 10)
        sortButton.titleLabel?.textColor = .white
        sortButton.contentHorizontalAlignment = .center
        sortButton.contentVerticalAlignment = .center
        middleView.addSubview(sortButton)
        
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        sortButton.topAnchor.constraint(equalTo: middleView.topAnchor).isActive = true
        sortButton.centerXAnchor.constraint(equalTo: middleView.centerXAnchor).isActive = true
        sortButton.widthAnchor.constraint(equalTo: middleView.widthAnchor, multiplier: 1 / 3).isActive = true
        sortButton.heightAnchor.constraint(equalTo: middleView.heightAnchor).isActive = true
    }
    
    private func setupFilterButton() {
        filterButton.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
        filterButton.setImage(UIImage(named: "FilterHIcon"), for: .normal)
        filterButton.setTitle(" Фильтр", for: .normal)
        filterButton.titleLabel?.font = .mediumSystemFontOfSize(size: 10)
        filterButton.titleLabel?.textColor = .white
        filterButton.contentHorizontalAlignment = .right
        filterButton.contentVerticalAlignment = .center
        middleView.addSubview(filterButton)
        
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        filterButton.topAnchor.constraint(equalTo: middleView.topAnchor).isActive = true
        filterButton.trailingAnchor.constraint(equalTo: middleView.trailingAnchor,
                                               constant: -verticalInset).isActive = true
        filterButton.widthAnchor.constraint(equalTo: middleView.widthAnchor, multiplier: 1 / 3).isActive = true
        filterButton.heightAnchor.constraint(equalTo: middleView.heightAnchor).isActive = true
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
        tableView.topAnchor.constraint(equalTo: middleView.bottomAnchor,
                                       constant: verticalInset).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: verticalInset).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                            constant: -verticalInset).isActive = true
    }
    /*
    private func setupScrollView() {
        let height = Session.height - headerHeight - tabBarHeight
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: Session.width, height: height)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: headerHeight).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: Session.height).isActive = true
    }
    
    
    
    private func setupSeparatorView() {
        separatorView.backgroundColor = .searchBarTintColor
        scrollView.addSubview(separatorView)
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: heightSeparatorView).isActive = true
    }
    
    
    
    private func setupNameTextField() {
        nameTextField.font = .systemFontOfSize(size: 14)
        nameTextField.textColor = .textFieldTextColor
        nameTextField.placeholder = "Имя"
        nameTextField.textAlignment = .left
        nameTextField.autocorrectionType = .no
        nameTextField.backgroundColor = .white
        nameTextField.layer.cornerRadius = 5
        nameTextField.leftView = setupDefaultLeftView()
        nameTextField.leftViewMode = .always
        scrollView.addSubview(nameTextField)
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: lastnameTextField.bottomAnchor,
                                           constant: verticalInset).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                               constant: leading).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: Session.width - (2 * leading)).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupMiddlenameTextField() {
        middlenameTextField.font = .systemFontOfSize(size: 14)
        middlenameTextField.textColor = .textFieldTextColor
        middlenameTextField.placeholder = "Отчество"
        middlenameTextField.textAlignment = .left
        middlenameTextField.autocorrectionType = .no
        middlenameTextField.backgroundColor = .white
        middlenameTextField.layer.cornerRadius = 5
        middlenameTextField.leftView = setupDefaultLeftView()
        middlenameTextField.leftViewMode = .always
        scrollView.addSubview(middlenameTextField)
        
        middlenameTextField.translatesAutoresizingMaskIntoConstraints = false
        middlenameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor,
                                                 constant: verticalInset).isActive = true
        middlenameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                     constant: leading).isActive = true
        middlenameTextField.widthAnchor.constraint(equalToConstant: Session.width - (2 * leading)).isActive = true
        middlenameTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupSpecTextField() {
        specTextField.font = .systemFontOfSize(size: 14)
        specTextField.textColor = .textFieldTextColor
        specTextField.placeholder = "Специализация"
        specTextField.textAlignment = .left
        specTextField.autocorrectionType = .no
        specTextField.backgroundColor = .white
        specTextField.layer.cornerRadius = 5
        specTextField.leftView = setupDefaultLeftView()
        specTextField.leftViewMode = .always
        scrollView.addSubview(specTextField)
        
        specTextField.translatesAutoresizingMaskIntoConstraints = false
        specTextField.topAnchor.constraint(equalTo: middlenameTextField.bottomAnchor,
                                           constant: verticalInset).isActive = true
        specTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                               constant: leading).isActive = true
        specTextField.widthAnchor.constraint(equalToConstant: Session.width - (2 * leading)).isActive = true
        specTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupLocationTextField() {
        locationTextField.font = .systemFontOfSize(size: 14)
        locationTextField.textColor = .textFieldTextColor
        locationTextField.placeholder = "Место жительства"
        locationTextField.textAlignment = .left
        locationTextField.autocorrectionType = .no
        locationTextField.backgroundColor = .white
        locationTextField.layer.cornerRadius = 5
        locationTextField.leftView = setupDefaultLeftView()
        locationTextField.leftViewMode = .always
        scrollView.addSubview(locationTextField)
        
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        locationTextField.topAnchor.constraint(equalTo: specTextField.bottomAnchor,
                                               constant: verticalInset).isActive = true
        locationTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                   constant: leading).isActive = true
        locationTextField.widthAnchor.constraint(equalToConstant: Session.width - (2 * leading)).isActive = true
        locationTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupJobTextField() {
        jobTextField.font = .systemFontOfSize(size: 14)
        jobTextField.textColor = .textFieldTextColor
        jobTextField.placeholder = "Место работы"
        jobTextField.textAlignment = .left
        jobTextField.autocorrectionType = .no
        jobTextField.backgroundColor = .white
        jobTextField.layer.cornerRadius = 5
        jobTextField.leftView = setupDefaultLeftView()
        jobTextField.leftViewMode = .always
        scrollView.addSubview(jobTextField)
        
        jobTextField.translatesAutoresizingMaskIntoConstraints = false
        jobTextField.topAnchor.constraint(equalTo: locationTextField.bottomAnchor,
                                          constant: verticalInset).isActive = true
        jobTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                              constant: leading).isActive = true
        jobTextField.widthAnchor.constraint(equalToConstant: Session.width - (2 * leading)).isActive = true
        jobTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    private func setupEducationTextField() {
        educationTextField.font = .systemFontOfSize(size: 14)
        educationTextField.textColor = .textFieldTextColor
        educationTextField.placeholder = "Учебное заведение"
        educationTextField.textAlignment = .left
        educationTextField.autocorrectionType = .no
        educationTextField.backgroundColor = .white
        educationTextField.layer.cornerRadius = 5
        educationTextField.leftView = setupDefaultLeftView()
        educationTextField.leftViewMode = .always
        scrollView.addSubview(educationTextField)
        
        educationTextField.translatesAutoresizingMaskIntoConstraints = false
        educationTextField.topAnchor.constraint(equalTo: jobTextField.bottomAnchor,
                                                constant: verticalInset).isActive = true
        educationTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                    constant: leading).isActive = true
        educationTextField.widthAnchor.constraint(equalToConstant: Session.width - (2 * leading)).isActive = true
        educationTextField.heightAnchor.constraint(equalToConstant: Session.heightTextField).isActive = true
    }
    
    
    
    private func setupSearchButton() {
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        scrollView.addSubview(searchButton)
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.topAnchor.constraint(equalTo: educationTextField.bottomAnchor,
                                          constant: verticalInset).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                               constant: Session.width - leading).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
    }
    */
    // MARK: - Buttons methods
    @objc private func cancelButtonPressed() {
        
    }
    
    @objc private func sortButtonPressed() {
        
    }
    
    @objc private func filterButtonPressed() {
        
    }
    
}

// MARK: - UITableViewDelegate
extension SearchResultViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.cellForRow(at: indexPath)?.isSelected = true
//        presenter?.addToSelected(index: indexPath.section)
//        searchBar.searchTextField.resignFirstResponder()
    }
    
//    func tableView(_ tableView: UITableView,
//                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteContact = UIContextualAction(style: .destructive,
//                                               title: "") {  (_, _, completion) in
//            self.presenter?.deleteFromSelected(index: indexPath.section)
//            tableView.cellForRow(at: indexPath)?.isSelected = false
//            completion(true)
//        }
//        deleteContact.backgroundColor = .hdButtonColor
//        deleteContact.image = UIImage(named: "Trash Icon")
//        let swipeActions = UISwipeActionsConfiguration(actions: [deleteContact])
//
//        return swipeActions
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
}

// MARK: - UITableViewDataSource
extension SearchResultViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell",
                                                       for: indexPath) as? ContactTableViewCell
        else { return UITableViewCell() }
        
//        cell.configure(contact: (presenter?.getContact(index: indexPath.section)))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
