//
//  InterestTableViewCell.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 17.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class InterestTableViewCell: UITableViewCell {
    
    private let interestTitle = UILabel()
    private let icon = UIImageView()
    
    private let selectedIcon = UIImage(named: "Checkbox_Y.pdf")
    private let unselectedIcon = UIImage(named: "Checkbox_N.pdf")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .backgroundColor
        setupInterestTitle()
        setupIcon()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override var isSelected: Bool {
        didSet {
            icon.image = isSelected ? selectedIcon : unselectedIcon
        }
    }
    
    private func setupInterestTitle() {
        let leading: CGFloat = 10
        let trailing: CGFloat = 50
        interestTitle.numberOfLines = 1
        interestTitle.textAlignment = .left
        interestTitle.font = .systemFontOfSize(size: 14)
        interestTitle.textColor = .white
        contentView.addSubview(interestTitle)
        
        interestTitle.translatesAutoresizingMaskIntoConstraints = false
        interestTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        interestTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                               constant: leading).isActive = true
        interestTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -trailing).isActive = true
    }
    
    private func setupIcon() {
        let trailing: CGFloat = 20
        let width: CGFloat = 20
        let iconName = "Checkbox_N.pdf"
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
        interestTitle.text = title
    }
    
}
