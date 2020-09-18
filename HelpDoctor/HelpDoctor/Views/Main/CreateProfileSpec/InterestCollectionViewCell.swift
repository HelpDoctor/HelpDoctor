//
//  InterestCollectionViewCell.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 10.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol InterestCollectionViewCellDelegate: class {
    func fontSize(interest: String) -> CGFloat
}

class InterestCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "InterestCell"
    weak var delegate: InterestCollectionViewCellDelegate?
    private let cellView = UIView()
    private let cellLabel = UILabel()
    private let plusIcon = UIImageView()
    private let unSelectedColor = UIColor(red: 0.118, green: 0.588, blue: 0.988, alpha: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellLabel()
        setupPlusIcon()
        backgroundColor = unSelectedColor
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellLabel() {
        cellLabel.numberOfLines = 3
        cellLabel.textAlignment = .center
        cellLabel.textColor = .white
        contentView.addSubview(cellLabel)
        
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1).isActive = true
        cellLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1).isActive = true
        cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4).isActive = true
        cellLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22).isActive = true
    }
    
    private func setupPlusIcon() {
        plusIcon.image = UIImage(named: "Plus_Symbol")
        contentView.addSubview(plusIcon)
        
        plusIcon.translatesAutoresizingMaskIntoConstraints = false
        plusIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        plusIcon.widthAnchor.constraint(equalToConstant: 10).isActive = true
        plusIcon.heightAnchor.constraint(equalToConstant: 10).isActive = true
        plusIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6).isActive = true
    }
    
    func configure(_ interest: String) {
        cellLabel.text = interest
        cellLabel.font = .systemFontOfSize(size: delegate?.fontSize(interest: interest) ?? 12)
    }
    
    func configure(_ interest: String, icon: String) {
        plusIcon.image = UIImage(named: icon)
        cellLabel.text = interest
        cellLabel.font = .systemFontOfSize(size: delegate?.fontSize(interest: interest) ?? 12)
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor.hdGreenColor : unSelectedColor
        }
    }
    
}
