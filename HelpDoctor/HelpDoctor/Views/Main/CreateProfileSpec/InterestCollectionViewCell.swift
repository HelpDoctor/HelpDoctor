//
//  InterestCollectionViewCell.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 10.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class InterestCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "InterestCell"
    
    private let cellView = UIView()
    private let cellLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellLabel()
        backgroundColor = .clear
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            layer.borderColor = isSelected ? UIColor.red.cgColor : UIColor.white.cgColor
        }
    }
    
    private func setupCellLabel() {
        cellLabel.numberOfLines = 2
        cellLabel.textAlignment = .center
        cellLabel.font = .systemFontOfSize(size: 10)
        cellLabel.textColor = .white
        contentView.addSubview(cellLabel)
        
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1).isActive = true
        cellLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1).isActive = true
        cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 1).isActive = true
        cellLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1).isActive = true
    }
    
    func configure(_ interest: String) {
        cellLabel.text = interest
    }
}
