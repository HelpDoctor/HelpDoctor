//
//  GuestCell.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 04.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class GuestCell: UICollectionViewCell {
    static let reuseIdentifier = "GuestCell"
    private let cellView = UIView()
    private let cellImage = UIImageView()
    private let cellLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellImage()
        setupCellLabel()
        backgroundColor = UIColor(red: 0.188, green: 0.298, blue: 0.537, alpha: 1)
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellImage() {
        cellImage.image = UIImage(named: "Alert Icon")
        cellImage.layer.cornerRadius = 10
        contentView.addSubview(cellImage)
        
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        cellImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cellImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        cellImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        cellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    }
    
    private func setupCellLabel() {
        cellLabel.font = .systemFontOfSize(size: 8)
        cellLabel.numberOfLines = 1
        cellLabel.textAlignment = .left
        cellLabel.textColor = .white
        contentView.addSubview(cellLabel)
        
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cellLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        cellLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 6).isActive = true
        cellLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6).isActive = true
    }
    
    func configure(_ guestName: String, _ guestImage: UIImage) {
        cellLabel.text = guestName
        cellImage.image = guestImage
    }
    
    func configure(contact: Contacts?) {
        guard let contact = contact else { return }
        cellLabel.text = "\(contact.last_name ?? "") \(contact.first_name ?? "") \(contact.middle_name ?? "")"
        cellImage.image = contact.foto?.toImage()
    }
    
}
