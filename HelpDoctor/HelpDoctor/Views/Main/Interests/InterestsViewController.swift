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
    private var tableView = UITableView()
    private let searchBar = UISearchBar()
    private let descriptionLabel = UILabel()
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupHeaderViewWithBack(title: "Выбор научных интересов", presenter: presenter)
        setupSearchBar()
        setupDescriptionLabel()
        setupTableView()
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
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    // MARK: - Setup views
    private func setupSearchBar() {
        let top: CGFloat = 50
        let height: CGFloat = 56
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
        view.addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: leading).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: -leading).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(InterestTableViewCell.self, forCellReuseIdentifier: "InterestTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .backgroundColor
        tableView.keyboardDismissMode = .onDrag
        tableView.allowsMultipleSelection = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    // MARK: - Private methods
    func selectRows() {
        presenter?.selectRows()
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
