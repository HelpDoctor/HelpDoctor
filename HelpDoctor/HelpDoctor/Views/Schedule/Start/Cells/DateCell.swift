//
//  DateCell.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class DateCell: UITableViewCell {
    
    static let reuseIdentifier = "DateCell"
    
    private let dateView = UIView()
    private let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDateView()
        setupDateLabel()
        isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDateView() {
        dateView.backgroundColor = .white
        dateView.layer.cornerRadius = 5
        dateView.clipsToBounds = true
        contentView.addSubview(dateView)
        
        dateView.translatesAutoresizingMaskIntoConstraints = false
        dateView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1).isActive = true
        dateView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1).isActive = true
        dateView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        dateView.widthAnchor.constraint(equalToConstant: 135).isActive = true
    }
    
    private func setupDateLabel() {
        dateLabel.numberOfLines = 1
        dateLabel.textAlignment = .center
        dateLabel.font = .systemFontOfSize(size: 14)
        dateLabel.textColor = .black
        dateView.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: dateView.topAnchor, constant: 2).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: dateView.bottomAnchor, constant: -2).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: 18).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: dateView.trailingAnchor, constant: -18).isActive = true
    }
    
    func configure(_ date: String) {
        dateLabel.text = date
    }
    
}
