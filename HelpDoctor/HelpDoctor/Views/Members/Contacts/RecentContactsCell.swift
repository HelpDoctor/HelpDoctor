//
//  RecentContactsCell.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 21.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class RecentContactsCell: UICollectionViewCell {
    static let reuseIdentifier = "RecentContactsCell"
    private let cellView = UIView()
    private let cellImage = UIImageView()
    private let cellLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellImage()
        setupCellLabel()
        backgroundColor = .backgroundColor
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellImage() {
        let imageSize = 30.f
        cellImage.layer.cornerRadius = imageSize / 2
        cellImage.layer.masksToBounds = true
        contentView.addSubview(cellImage)
        
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        cellImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        cellImage.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        cellImage.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        cellImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    }
    
    private func setupCellLabel() {
        cellLabel.font = .mediumSystemFontOfSize(size: 8)
        cellLabel.numberOfLines = 1
        cellLabel.textAlignment = .center
        cellLabel.textColor = .white
        contentView.addSubview(cellLabel)
        
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.topAnchor.constraint(equalTo: cellImage.bottomAnchor,
                                       constant: 5).isActive = true
        cellLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cellLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    func configure(contact: Contacts?) {
        guard let contact = contact else { return }
        cellLabel.text = "\(contact.lastName ?? "") \(contact.firstName ?? "") \(contact.middleName ?? "")"
        cellImage.image = contact.foto?.toImage()
    }
    
}
