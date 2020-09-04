//
//  RepeatNotificationsTableViewCell.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 19.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//
/*
import UIKit

class RepeatNotificationsTableViewCell: UITableViewCell {
    
    private let title = UILabel()
    private let icon = UIImageView()
    
    private let selectedIcon = UIImage(named: "SelectedEllipse.pdf")
    private let unselectedIcon = UIImage(named: "Ellipse.pdf")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupTitle()
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
    
    private func setupTitle() {
        title.numberOfLines = 1
        title.textAlignment = .left
        title.font = .systemFontOfSize(size: 14)
        title.textColor = .black
        contentView.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
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
        self.title.text = title
    }

}
*/
