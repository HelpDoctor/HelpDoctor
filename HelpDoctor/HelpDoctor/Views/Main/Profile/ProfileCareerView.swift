//
//  ProfileCareerView.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 31.03.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class ProfileCareerView: UIView {
    private let jobLabel = UILabel()
    private let tableView = UITableView()
    private let employmentLabel = UILabel()
    private let employmentDataLabel = UILabel()
    private var jobArray: [ProfileKeyJob?] = [nil, nil, nil, nil, nil]
    private let leading = 20.f
    private let heightLabel = 15.f
    private let verticalSpacing = 5.f
    
    convenience init(job: [ProfileKeyJob?]) {
        self.init()
        self.jobArray = job
        self.employmentDataLabel.text = "Врач-специалист"
        backgroundColor = .white
        setupJobLabel()
        setupTableView()
        setupEmploymentLabel()
        setupEmploymentDataLabel()
    }
    
    private func setupJobLabel() {
        jobLabel.font = .boldSystemFontOfSize(size: 14)
        jobLabel.numberOfLines = 1
        jobLabel.text = "Место работы"
        jobLabel.textColor = .black
        self.addSubview(jobLabel)
        
        jobLabel.translatesAutoresizingMaskIntoConstraints = false
        jobLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        jobLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                          constant: leading).isActive = true
        jobLabel.topAnchor.constraint(equalTo: self.topAnchor,
                                      constant: 16).isActive = true
        jobLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                           constant: -leading).isActive = true
    }
    
    private func setupTableView() {
        let height = (heightLabel + verticalSpacing) * jobArray.count.f
        self.addSubview(tableView)
        tableView.register(ProfileJobCell.self, forCellReuseIdentifier: "ProfileJobCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.heightAnchor.constraint(equalToConstant: height).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                           constant: leading).isActive = true
        tableView.topAnchor.constraint(equalTo: jobLabel.bottomAnchor, constant: 9).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                            constant: -leading).isActive = true
    }
    
    private func setupEmploymentLabel() {
        employmentLabel.font = .boldSystemFontOfSize(size: 14)
        employmentLabel.numberOfLines = 1
        employmentLabel.text = "Должность"
        employmentLabel.textColor = .black
        self.addSubview(employmentLabel)
        
        employmentLabel.translatesAutoresizingMaskIntoConstraints = false
        employmentLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        employmentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                 constant: leading).isActive = true
        employmentLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor,
                                             constant: 16).isActive = true
        employmentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                  constant: -leading).isActive = true
    }
    
    private func setupEmploymentDataLabel() {
        employmentDataLabel.font = .systemFontOfSize(size: 14)
        employmentDataLabel.numberOfLines = 1
        employmentDataLabel.textColor = .black
        self.addSubview(employmentDataLabel)
        
        employmentDataLabel.translatesAutoresizingMaskIntoConstraints = false
        employmentDataLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        employmentDataLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                     constant: leading).isActive = true
        employmentDataLabel.topAnchor.constraint(equalTo: employmentLabel.bottomAnchor,
                                                 constant: 9).isActive = true
        employmentDataLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                      constant: -leading).isActive = true
    }
    
}

// MARK: - UITableViewDelegate
extension ProfileCareerView: UITableViewDelegate {
    
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
extension ProfileCareerView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return jobArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileJobCell",
                                                       for: indexPath) as? ProfileJobCell
            else { return UITableViewCell() }
        
        cell.configure(jobArray[indexPath.section]?.nameShort ?? "")
        return cell
    }
    
}
