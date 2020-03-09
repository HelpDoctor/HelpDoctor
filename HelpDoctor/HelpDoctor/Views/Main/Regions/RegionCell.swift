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
    private let icon = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .backgroundColor
        setupRegionName()
        setupIcon()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupRegionName() {
        let leading: CGFloat = 20
        regionName.numberOfLines = 1
        regionName.textAlignment = .left
        regionName.font = .systemFontOfSize(size: 14)
        regionName.textColor = .white
        contentView.addSubview(regionName)
        
        regionName.translatesAutoresizingMaskIntoConstraints = false
        regionName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        regionName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                            constant: leading).isActive = true
        regionName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                             constant: -leading).isActive = true
    }
    
    private func setupIcon() {
        let trailing: CGFloat = 10
        let width: CGFloat = 20
        let iconName = "Checked.pdf"
        guard let image = UIImage(named: iconName) else {
            assertionFailure("Missing ​​\(iconName) asset")
            return
        }
        icon.image = image
        contentView.addSubview(icon)
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        icon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                       constant: -trailing).isActive = true
        icon.widthAnchor.constraint(equalToConstant: width).isActive = true
        icon.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func configure(_ title: String) {
        regionName.text = title
    }
    
    override var isSelected: Bool {
        didSet {
            icon.isHidden = isSelected ? false : true
        }
    }

}
