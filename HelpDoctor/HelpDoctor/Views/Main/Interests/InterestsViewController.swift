//
//  InterestsViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 03.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class InterestsViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: InterestsPresenterProtocol?
    
    // MARK: - Constants and variables
    private let scrollView = UIScrollView()
    private var tableView = UITableView()
    private let searchBar = UISearchBar()
    private let descriptionLabel = UILabel()
    private let stackView = UIView()
    private let addTextField = UITextField()
    private let addButton = HDButton(title: "Добавить", fontSize: 12)
    
    private var keyboardHeight: CGFloat = 0
    private let heightSearchBar: CGFloat = 56
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupHeaderViewWithBack(title: "Выбор научных интересов", presenter: presenter)
        setupScrollView()
        setupSearchBar()
        setupDescriptionLabel()
        setupStackView()
        setupAddButton()
        setupAddTextField()
        setupTableView()
        selectRows()
//        addTapGestureToHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .clear)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Public methods
    /// Выделение ячеек интересов пользователя
    /// - Parameter index: индекс ячейки
    func setSelected(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
    }
    
    /// Обновление таблицы
    func reloadTableView() {
        tableView.reloadData()
    }
    
    /// Выделение ячеек интересов пользователя
    func selectRows() {
        presenter?.selectRows()
    }
    
    // MARK: - Setup views
    /// Установка ScrollView
    private func setupScrollView() {
        let top: CGFloat = 50
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: Session.width, height: Session.height)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: top).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: view.frame.size.height).isActive = true
    }
    
    /// Установка строки поиска
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.barTintColor = .searchBarTintColor
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = .white
        } else {
            guard let searchField = searchBar.value(forKey: "searchField") as? UITextField else { return }
            searchField.backgroundColor = .white
        }
        searchBar.placeholder = "Поиск"
        scrollView.addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: heightSearchBar).isActive = true
    }
    
    /// Установка надписи описания
    private func setupDescriptionLabel() {
        let text = "Здесь вы можете выбрать область научных интересов. Для этого выберите интересующую вас область:"
        let leading: CGFloat = 10
        let height: CGFloat = (text.height(withConstrainedWidth: Session.width - (2 * leading),
                                           font: .systemFontOfSize(size: 12)))
        descriptionLabel.font = .systemFontOfSize(size: 12)
        descriptionLabel.textColor = .white
        descriptionLabel.text = text
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        scrollView.addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                  constant: leading).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка группы добавления интереса
    private func setupStackView() {
        let top: CGFloat = Session.height - 50 - 56 - 18
        stackView.backgroundColor = .white
        scrollView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor,
                                          constant: top).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: heightSearchBar).isActive = true
    }
    
    /// Установка кнопки добавления интереса
    private func setupAddButton() {
        let trailing: CGFloat = 14
        let height: CGFloat = 35
        let width: CGFloat = 85
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        addButton.isEnabled = true
        stackView.addSubview(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        addButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,
                                            constant: -trailing).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка поля ввода нового интереса
    private func setupAddTextField() {
        let height: CGFloat = 36
        let leading: CGFloat = 8
        addTextField.layer.borderColor = UIColor(red: 0.18, green: 0.369, blue: 0.667, alpha: 1).cgColor
        addTextField.layer.borderWidth = 1
        addTextField.layer.cornerRadius = 5
        addTextField.placeholder = "Добавить научный интерес"
        addTextField.font = UIFont.systemFontOfSize(size: 14)
        addTextField.textColor = .textFieldTextColor
        addTextField.leftView = UIView(frame: CGRect(x: 0,
                                                     y: 0,
                                                     width: 8,
                                                     height: addTextField.frame.height))
        addTextField.leftViewMode = .always
        stackView.addSubview(addTextField)
        
        addTextField.translatesAutoresizingMaskIntoConstraints = false
        addTextField.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        addTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,
                                              constant: leading).isActive = true
        addTextField.trailingAnchor.constraint(equalTo: addButton.leadingAnchor,
                                               constant: -leading).isActive = true
        addTextField.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка таблицы интересов
    private func setupTableView() {
        scrollView.addSubview(tableView)
        tableView.register(InterestTableViewCell.self, forCellReuseIdentifier: "InterestTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .backgroundColor
        tableView.keyboardDismissMode = .onDrag
        tableView.allowsMultipleSelection = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
    }
/*
    /// Добавление распознавания касания экрана
    private func addTapGestureToHideKeyboard() {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self,
                                                         action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(hideKeyboardGesture)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown​),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    // MARK: - IBActions
    /// Скрытие клавиатуры
    @objc func hideKeyboard() {
        scrollView.endEditing(true)
        view.viewWithTag(998)?.removeFromSuperview()
        view.viewWithTag(999)?.removeFromSuperview()
    }
    
    /// Изменение размера ScrollView при появлении клавиатуры
    /// - Parameter notification: событие появления клавиатуры
    @objc func keyboardWasShown​(notification: Notification) {
        guard let info = notification.userInfo else {
            assertionFailure()
            return
        }
        //swiftlint:disable force_cast
        let kbSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        keyboardHeight = kbSize.height
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    /// Изменение размера ScrollView при скрытии клавиатуры
    /// - Parameter notification: событие скрытия клавиатуры
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    */
    // MARK: - Buttons methods
    /// Обработка нажатия кнопки добавления интереса
    @objc private func addButtonPressed() {
        presenter?.createInterest(interest: addTextField.text)
        addTextField.becomeFirstResponder()
    }

}

// MARK: - UISearchBarDelegate
extension InterestsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            presenter?.searchTextIsEmpty()
            return
        }
        presenter?.filter(searchText: searchText)
    }
    
}

// MARK: - UITableViewDelegate
extension InterestsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tap")
        tableView.cellForRow(at: indexPath)?.isSelected = true
        presenter?.appendIndexArray(index: indexPath.item)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        presenter?.removeIndexArray(index: indexPath.item)
    }
    
}

// MARK: - UITableViewDataSource
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

}
