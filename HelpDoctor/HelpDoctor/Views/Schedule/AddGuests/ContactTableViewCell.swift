//
//  ContactTableViewCell.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 04.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ContactTableViewCell"
    private let topView = UIView()
    private let nameLabel = UILabel()
    private let specLabel = UILabel()
    private let cellImage = UIImageView()
    private let verificationImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .backgroundColor
        setupTopView()
        setupCellImage()
        setupVerificationImage()
        setupNameLabel()
        setupSpecLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override var isSelected: Bool {
        didSet {
            verificationImage.isHidden = isSelected ? false : true
        }
    }
    
    private func setupTopView() {
        topView.layer.cornerRadius = 5
        topView.backgroundColor = .white
        contentView.addSubview(topView)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        topView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    }
    
    private func setupCellImage() {
        cellImage.image = UIImage(named: "Alert Icon")
        cellImage.layer.cornerRadius = 22.5
        topView.addSubview(cellImage)
        
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        cellImage.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        cellImage.widthAnchor.constraint(equalToConstant: 45).isActive = true
        cellImage.heightAnchor.constraint(equalToConstant: 45).isActive = true
        cellImage.leadingAnchor.constraint(equalTo: topView.leadingAnchor,
                                           constant: 10).isActive = true
    }
    
    private func setupVerificationImage() {
        verificationImage.image = UIImage(named: "Checkmark")
        verificationImage.contentMode = .scaleAspectFill
        verificationImage.layer.cornerRadius = 10
        verificationImage.layer.borderColor = UIColor.white.cgColor
        verificationImage.layer.borderWidth = 1
        verificationImage.backgroundColor = UIColor(red: 0.129, green: 0.741, blue: 0.361, alpha: 1)
        topView.addSubview(verificationImage)
        
        verificationImage.translatesAutoresizingMaskIntoConstraints = false
        verificationImage.bottomAnchor.constraint(equalTo: cellImage.bottomAnchor).isActive = true
        verificationImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        verificationImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        verificationImage.trailingAnchor.constraint(equalTo: cellImage.trailingAnchor,
                                                    constant: 5).isActive = true
    }
    
    private func setupNameLabel() {
        nameLabel.numberOfLines = 1
        nameLabel.textAlignment = .left
        nameLabel.font = .mediumSystemFontOfSize(size: 12)
        nameLabel.textColor = .black
        nameLabel.text = "Горин Петр Игоревич"
        topView.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor,
                                           constant: 15).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.5).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
    }
    
    private func setupSpecLabel() {
        specLabel.numberOfLines = 1
        specLabel.textAlignment = .left
        specLabel.font = .mediumSystemFontOfSize(size: 12)
        specLabel.textColor = .countColor
        specLabel.text = "Уролог"
        topView.addSubview(specLabel)
        
        specLabel.translatesAutoresizingMaskIntoConstraints = false
        specLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor,
                                           constant: 15).isActive = true
        specLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        specLabel.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.5).isActive = true
        specLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
    }
    
    func configure(contact: Contacts?) {
        guard let contact = contact else { return }
        nameLabel.text = "\(contact.last_name ?? "") \(contact.first_name ?? "") \(contact.middle_name ?? "")"
        cellImage.image = contact.foto?.toImage()
        specLabel.text = contact.specialization
    }

}
