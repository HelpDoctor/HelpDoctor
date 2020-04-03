//
//  SettingsCell.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 22.02.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    static let reuseIdentifier = "SettingsCell"
    
    private let settingsImage = UIImageView()
    private let settingsLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupSettingsImage()
        setupSettingsLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSettingsImage() {
        let imageName = "help"
        guard let image = UIImage(named: imageName) else {
            assertionFailure("Missing ​​\(imageName) asset")
            return
        }
        settingsImage.image = image
        contentView.addSubview(settingsImage)
        
        settingsImage.translatesAutoresizingMaskIntoConstraints = false
        settingsImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        settingsImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        settingsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                               constant: 30).isActive = true
        settingsImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupSettingsLabel() {
        settingsLabel.numberOfLines = 0
        settingsLabel.textAlignment = .left
        settingsLabel.font = .systemFontOfSize(size: 14)
        settingsLabel.textColor = .white
        contentView.addSubview(settingsLabel)
        
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        settingsLabel.leadingAnchor.constraint(equalTo: settingsImage.trailingAnchor,
                                               constant: 20).isActive = true
        settingsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -10).isActive = true
    }
    
    func configure(settingsRow: SettingsRow) {
        let imageName = String(describing: settingsRow)
        settingsImage.image = UIImage(named: imageName)
        settingsLabel.text = settingsRow.rawValue
    }
    
}
