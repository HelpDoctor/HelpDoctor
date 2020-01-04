//
//  RegionCell.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 02.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class RegionCell: UITableViewCell {
    private let regionName = UILabel()
    let icon = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupRegionName()
        setupIcon()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupRegionName() {
        regionName.numberOfLines = 1
        regionName.textAlignment = .left
        regionName.font = .systemFontOfSize(size: 14)
        regionName.textColor = .black
        contentView.addSubview(regionName)
        
        regionName.translatesAutoresizingMaskIntoConstraints = false
        regionName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        regionName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        regionName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40).isActive = true
        regionName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
    }
    
    private func setupIcon() {
        let iconName = "Ellipse.pdf"
        guard let image = UIImage(named: iconName) else {
            assertionFailure("Missing ​​\(iconName) asset")
            return
        }
        icon.image = image
        contentView.addSubview(icon)
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 13).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 14).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    func configure(_ title: String) {
        regionName.text = title
    }

}
