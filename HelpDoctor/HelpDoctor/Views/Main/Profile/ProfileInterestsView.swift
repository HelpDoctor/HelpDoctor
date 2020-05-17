//
//  ProfileInterestsView.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 31.03.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class ProfileInterestsView: UIView {
    private let interestsLabel = UILabel()
    private let tableView = UITableView()
    private var interestsArray: [ProfileKeyInterests]?
    private let leading = 20.f
    private let heightLabel = 15.f
    private let verticalSpacing = 5.f
    
    convenience init(interests: [ProfileKeyInterests]) {
        self.init()
        self.interestsArray = interests
        backgroundColor = .white
        setupJobLabel()
        setupTableView()
    }
    
    private func setupJobLabel() {
        interestsLabel.font = .boldSystemFontOfSize(size: 14)
        interestsLabel.numberOfLines = 1
        interestsLabel.text = "Область научных интересов"
        interestsLabel.textColor = .black
        self.addSubview(interestsLabel)
        
        interestsLabel.translatesAutoresizingMaskIntoConstraints = false
        interestsLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        interestsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                          constant: leading).isActive = true
        interestsLabel.topAnchor.constraint(equalTo: self.topAnchor,
                                      constant: 16).isActive = true
        interestsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                           constant: -leading).isActive = true
    }
    
    private func setupTableView() {
        let height = (heightLabel + verticalSpacing) * (interestsArray?.count.f ?? 0)
        self.addSubview(tableView)
        tableView.register(ProfileJobCell.self, forCellReuseIdentifier: "ProfileInterestsCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.heightAnchor.constraint(equalToConstant: height).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                           constant: leading).isActive = true
        tableView.topAnchor.constraint(equalTo: interestsLabel.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                            constant: -leading).isActive = true
    }
    
}

// MARK: - UITableViewDelegate
extension ProfileInterestsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightLabel
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return verticalSpacing
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
}

// MARK: - UITableViewDataSource
extension ProfileInterestsView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return interestsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileInterestsCell",
                                                       for: indexPath) as? ProfileJobCell
            else { return UITableViewCell() }
        
        cell.configure(interestsArray?[indexPath.section].name ?? "")
        return cell
    }
    
}
