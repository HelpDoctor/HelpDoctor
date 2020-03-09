//
//  JobCell.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 15.02.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class JobCell: UITableViewCell {
    
    private let stackView = UIView()
    private let jobTextLabel = UILabel()
    private let jobSearchIcon = UIImageView()
    private let separatorView = UIView()
    private let separatorHeight: CGFloat = 5
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSeparatorView()
        setupStackView()
        setupJobTextLabel()
//        setupJobSearchIcon()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView() {
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 5
        stackView.clipsToBounds = true
        contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: separatorView.topAnchor).isActive = true
    }
    
    private func setupJobTextLabel() {
        jobTextLabel.backgroundColor = .clear
        jobTextLabel.textColor = .textFieldTextColor
        jobTextLabel.font = UIFont.systemFontOfSize(size: 14)
        stackView.addSubview(jobTextLabel)
        
        jobTextLabel.translatesAutoresizingMaskIntoConstraints = false
        jobTextLabel.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        jobTextLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        jobTextLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 8).isActive = true
        jobTextLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
    }
    
    private func setupJobSearchIcon() {
        let iconName = "Search_Button"
        guard let image = UIImage(named: iconName) else {
            assertionFailure("Missing ​​\(iconName) asset")
            return
        }
        jobSearchIcon.image = image
        stackView.addSubview(jobSearchIcon)
        
        jobSearchIcon.translatesAutoresizingMaskIntoConstraints = false
        jobSearchIcon.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        jobSearchIcon.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5).isActive = true
        jobSearchIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        jobSearchIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupSeparatorView() {
        separatorView.backgroundColor = .clear
        contentView.addSubview(separatorView)
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: separatorHeight).isActive = true
    }
    
    func configure(_ title: String) {
        jobTextLabel.text = title
        jobTextLabel.textColor = .textFieldTextColor
    }
    
    func configure(_ title: NSAttributedString) {
        jobTextLabel.textColor = UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.3)
        jobTextLabel.attributedText = title
    }

}
